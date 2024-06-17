import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_assest/consts/app_colors.dart';
import 'package:uni_assest/widgets/sub_title_text_widget.dart';

import '../../../../providers/theme_provider.dart';
import '../../../../widgets/default_material_btn.dart';
import '../../../../widgets/title_text_widget.dart';
import '../../../auth/txt_formfield_widget.dart';

class PdfsScreen extends StatefulWidget {
   PdfsScreen({super.key});

  static const String routeName = "PdfsScreen";

  @override
  State<PdfsScreen> createState() => _PdfsScreenState();

}

class _PdfsScreenState extends State<PdfsScreen> {

  // Controllers
  late final TextEditingController _titleController;

  // Focus Node
  late final FocusNode _titleFocusNode;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _titleFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _titleFocusNode.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);

    final String args = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: titleTextWidget(txt: args),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          //shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisExtent: 50,
            mainAxisSpacing: 18,
          ),
          itemBuilder: (context, index) => Container(
            padding: const EdgeInsets.all(12.0),
            height: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.0),
              color: themeProvider.getIsDarkTheme
                  ? AppColors.drawerColor
                  : AppColors.customGrayColor, //Colors.grey[400],
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      print("View Lecture ${index + 1}");
                    },
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.folder_copy,
                            color: themeProvider.getIsDarkTheme
                                ? Colors.white
                                : Colors.grey[700],
                          ),
                          const SizedBox(
                            width: 6.0,
                          ),
                          SizedBox(
                            width: size.width * 0.24,
                            child: subTitleTextWidget(
                              maxLines: 1,
                              overFlow: TextOverflow.ellipsis,
                              txt: "$args ${index + 1}",
                              color: themeProvider.getIsDarkTheme
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print("download lecture ${index + 1}");
                    },
                    child: Icon(
                      Icons.save_alt_outlined,
                      color: themeProvider.getIsDarkTheme
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          itemCount: 25,
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          isExtended: true,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => Container(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 9, top: 2.0),
                      width: 140,
                      height: 9,
                      decoration: BoxDecoration(
                        color: themeProvider.getIsDarkTheme
                            ? AppColors.drawerColor
                            : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    titleTextWidget(
                      txt: "Add new Folder",
                      color: themeProvider.getIsDarkTheme ? Colors.white : null,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    TxtFormFieldWidget(
                      controller: _titleController,
                      focusNode: _titleFocusNode,
                      keyboardType: TextInputType.text,
                      label: "title",
                      validateFct: (){},
                      onSubmitFct: (){},
                    ),
                    const SizedBox(height: 24.0,),
                    defaultMaterialBtn(
                      btnColor:AppColors.drawerColor,

                      onPressed: () {
                        //if (_formKey.currentState!.validate()) {
                        Navigator.pop(context);
                        //}
                      },
                      btnWidth: double.infinity,
                      child: titleTextWidget(color: Colors.white,
                        txt: "Add",
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          backgroundColor: AppColors.drawerColor,
          child: Icon(
            color: themeProvider.getIsDarkTheme? Colors.white : Colors.black,
            Icons.add,
            size: 35,
          ),
        ),
      ),
    );
  }
}
