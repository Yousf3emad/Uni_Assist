import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flython/flython.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_assest/consts/app_colors.dart';
import 'package:uni_assest/consts/end_points.dart';
import 'package:uni_assest/services/assets_manager.dart';
import 'package:uni_assest/services/my_app_methods.dart';
import 'package:uni_assest/widgets/default_material_btn.dart';
import 'package:uni_assest/widgets/sub_title_text_widget.dart';
import 'package:uni_assest/widgets/title_text_widget.dart';
import 'package:intl/intl.dart';

import '../../providers/theme_provider.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:typed_data';

import '../../shared/local/cashe/login_status.dart';

class GenerateQrCodeScreen extends StatefulWidget {
  const GenerateQrCodeScreen({super.key});

  @override
  State<GenerateQrCodeScreen> createState() => _GenerateQrCodeScreenState();
}

class _GenerateQrCodeScreenState extends State<GenerateQrCodeScreen> {
  final python = Flython();

  Future<void> _initializePython() async {
    await python.initialize(
      'C:\\Users\\Yousef\\AppData\\Local\\Programs\\Python\\Python312\\python.exe',
      'lib/app.py',
      false,
    );
  }

  Future<void> _runPythonScript() async {
    await python.runCommand('python lib/app.py');
  }

  Future<void> _shutdownPythonServer() async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/shutdown'),
      );

      if (response.statusCode == 200) {
        print('Server shutting down...');
      } else {
        print('Failed to shut down server: ${response.statusCode}');
        throw Exception('Failed to shut down server');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _setQrData(Map<String, String> data) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/set_qr_data'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode != 200) {
        print('Failed to set QR data: ${response.statusCode}');
        throw Exception('Failed to set QR data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Uint8List? _qrImage;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initializePython().then((_) {
      _runPythonScript();
      _startTimer();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      _fetchQRCode();
    });
  }

  Future<void> _fetchQRCode() async {
    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:5000/get_qr'),
      );

      if (response.statusCode == 200) {
        setState(() {
          _qrImage = response.bodyBytes;
        });
      } else {
        print('Failed to fetch QR code: ${response.statusCode}');
        throw Exception('Failed to fetch QR code');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  bool _isGenerate = false;

  int? selectedIndex;
  bool _isLecture = false;
  bool _isSection = false;

  String? _selectedLectureOrSection;
  String? _selectedSubject;

  void _onSubjectTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _isGenerate
              ? (_qrImage != null
                  ? Image.memory(_qrImage!)
                  : SizedBox(
                      height: size.height * .485,
                      width: size.height * .4,
                      child: const Center(
                          child: CircularProgressIndicator(
                        color: AppColors.drawerColor,
                      ))))
              : Image.asset(
                  AssetsManager.qrCode,
                  width: size.height * .2,
                  color: themeProvider.getIsDarkTheme
                      ? AppColors.drawerColor
                      : null,
                ),
          const SizedBox(
            height: 24.0,
          ),
          SizedBox(
            width: 250,
            height: kBottomNavigationBarHeight - 10,
            child: _isGenerate
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: themeProvider.getIsDarkTheme
                              ? AppColors.drawerColor
                              : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.0,
                        vertical: 6,
                      ),
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () async {
                      await _shutdownPythonServer();
                      _timer?.cancel();
                      setState(() {
                        _isGenerate = false;
                        _selectedSubject = null;
                        _selectedLectureOrSection = null;
                        _isSection = false;
                        _isLecture = false;
                        selectedIndex = null;
                      });
                    },
                    child: titleTextWidget(
                      txt: "Cancel",
                    ),
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: themeProvider.getIsDarkTheme
                              ? AppColors.drawerColor
                              : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.0,
                        vertical: 6,
                      ),
                      backgroundColor: themeProvider.getIsDarkTheme
                          ? AppColors.darkScaffoldColor
                          : AppColors.primaryColor,
                    ),
                    onPressed: () async {
                      int? weekNum = await LoginStatus.getWeekNum();
                      if (weekNum == 0) {
                        MyAppMethods.showErrorORWarningDialog(
                            context: context,
                            subTitle: ALLERT_MESSAGE_ATTENDANCE,
                            isError: false,
                            fctConfirmation: () {
                              LoginStatus.saveWeekNum(weekNum: weekNum! + 1);
                              _showSubjectDialog();
                            },
                            fctCancel: () {
                              Navigator.pop(context);
                            });
                      } else {
                        bool notInSameWeek = await isNotInSameWeek();
                        print(notInSameWeek);
                        if (notInSameWeek) {
                          LoginStatus.saveWeekNum(weekNum: weekNum! + 1);
                          _showSubjectDialog();
                        } else {
                          _showSubjectDialog();
                        }
                      }
                      if (weekNum! > 8) {
                        LoginStatus.saveWeekNum(weekNum: 0);
                      }
                      print(weekNum);
                      _showSubjectDialog();
                     },
                    child: titleTextWidget(txt: "Generate Qr Code"),
                  ),
          ),
        ],
      ),
    );
  }

  void _showSubjectDialog() async {
    List<String> subjectsList = await LoginStatus.getSubjects();
    //print(subjectsList[])
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actionsPadding: const EdgeInsets.all(18),
              actions: [
                defaultMaterialBtn(
                  onPressed: () {
                    if (_selectedLectureOrSection == null ||
                        _selectedSubject == null) {
                      print(
                          "=> $_selectedSubject, => $_selectedLectureOrSection");
                      MyAppMethods.showErrorORWarningDialog(
                        context: context,
                        subTitle: _selectedSubject == null
                            ? "choose a subject!!"
                            : "choose lecture Or Section!!",
                        confirmTxt: 'Ok',
                        fctConfirmation: () {
                        },
                        fctCancel: () {
                          Navigator.pop(context);
                        },
                      );
                    } else {
                      Navigator.pop(context, {
                        'selectedSubject': _selectedSubject,
                        'selectedLectureOrSection': _selectedLectureOrSection,
                        'isGenerate': true,

                      });
                      Navigator.pop(context);
                    }
                  },
                  child: titleTextWidget(
                    txt: 'Ok',
                  ),
                  btnWidth: double.infinity,
                ),
              ],
              titlePadding: const EdgeInsets.only(left: 12, top: 18, right: 25),
              title: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.only(left: 12.0, top: 10),
                height: 50,
                child: subTitleTextWidget(
                  textDecoration: TextDecoration.underline,
                  txt: "Choose a Subject ?",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              contentPadding: const EdgeInsets.all(20.0),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      decoration: BoxDecoration(
                        color: AppColors.customGrayColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: subjectsList.length > 3 ? 250 : 150,
                      child: ListView(
                        shrinkWrap: true,
                        children: subjectsList.asMap().entries.map((entry) {
                          int index = entry.key;
                          String subject = entry.value;
                          return Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            decoration: BoxDecoration(
                              color: selectedIndex == index
                                  ? AppColors.drawerColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: titleTextWidget(
                                txt: subject,
                              ),
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  _selectedSubject =
                                      subjectsList[selectedIndex!];
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    subTitleTextWidget(
                      textDecoration: TextDecoration.underline,
                      txt: "Lecture OR Section ?",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        defaultMaterialBtn(
                          onPressed: () {
                            setState(() {
                              _isLecture = true;
                              _isSection = false;
                              _selectedLectureOrSection = "Lecture";
                            });
                          },
                          child: titleTextWidget(
                            color: _isLecture ? Colors.white : null,
                            txt: 'Lecture',
                          ),
                          btnWidth: 120,
                          btnColor: _isLecture
                              ? AppColors.drawerColor
                              : AppColors.customGrayColor,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .05,
                        ),
                        defaultMaterialBtn(
                          onPressed: () {
                            setState(() {
                              _isLecture = false;
                              _isSection = true;
                              _selectedLectureOrSection = "Section";
                            });
                          },
                          child: titleTextWidget(
                            color: _isSection ? Colors.white : null,
                            txt: "Section",
                          ),
                          btnWidth: 120,
                          btnColor: _isSection
                              ? AppColors.drawerColor
                              : AppColors.customGrayColor,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (result != null && result['isGenerate'] == true) {

      int? weekNum = await LoginStatus.getWeekNum();
      await _setQrData({
        'type': result['selectedLectureOrSection'],
        'subjectName': result['selectedSubject'],
        'week': "$weekNum", // Replace with actual week if necessary
      });

      setState(() {
        _selectedSubject = result['selectedSubject'];
        _selectedLectureOrSection = result['selectedLectureOrSection'];
        _isGenerate = true;
      });
      _startTimer();
    }
  }

  Future<bool> isNotInSameWeek() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedTimeString = prefs.getString('savedTime');

    if (savedTimeString == null) {
      // If there's no saved time, assume they are not in the same week
      return true;
    }

    DateTime savedTime = DateTime.parse(savedTimeString);
    DateTime now = DateTime.now();

    // Get the ISO week number for both dates
    int savedWeek = weekNumber(savedTime);
    int currentWeek = weekNumber(now);

    // Check if the year and week number match
    return !(savedTime.year == now.year && savedWeek == currentWeek);
  }

  int weekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    int weekNum = ((dayOfYear - date.weekday + 10) / 7).floor();
    return weekNum;
  }
}
