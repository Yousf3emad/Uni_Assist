import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:uni_assest/consts/app_colors.dart';
import 'package:uni_assest/consts/my_validators.dart';
import 'package:uni_assest/root_screen.dart';
import 'package:uni_assest/screens/auth/register_screen.dart';
import 'package:uni_assest/screens/auth/signup_or_signin_widget.dart';
import 'package:uni_assest/screens/auth/txt_formfield_widget.dart';
import 'package:uni_assest/services/assets_manager.dart';
import 'package:uni_assest/widgets/custom_list_tile_widget.dart';
import 'package:uni_assest/widgets/default_material_btn.dart';
import 'package:uni_assest/widgets/sub_title_text_widget.dart';
import 'package:uni_assest/widgets/title_text_widget.dart';

import '../../providers/theme_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
  static const String routeName = "LoginScreen";
}

class _LoginScreenState extends State<LoginScreen> {
  late bool isSecure = true;
  //Controllers
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  //Form Key
  late final _formKey = GlobalKey<FormState>();

  //Focus Nodes
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  late String selectedRole;
  List<String> listOfRole = ["Professor", "Assistant Professor", "Student"];

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();

    selectedRole = "Login as ?";
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _emailFocusNode.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(35.0),
                    child: Image.asset(
                      AssetsManager.computer,
                      height: 150.0,
                      fit: BoxFit.cover,
                      width: 150.0,
                    ),
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  const Text(
                    "Uni Assist",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(
                    height: 45.0,
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    subtitle: InkWell(
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        showMenu(
                          color: themeProvider.getIsDarkTheme? AppColors.darkScaffoldColor : AppColors.customGrayColor,
                          context: context,
                          position: RelativeRect.fromLTRB(
                              size.width * .30, size.height * .40, 70, 20),
                          items: [
                            PopupMenuItem(
                              value: 1,
                              child: Text(listOfRole[0],
                                  style: TextStyle(
                                      color: themeProvider.getIsDarkTheme
                                          ? Colors.white
                                          : null)),
                              onTap: () {
                                setState(() {
                                  selectedRole = listOfRole[0];
                                });
                              },
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: Text(listOfRole[1],
                                  style: TextStyle(
                                      color: themeProvider.getIsDarkTheme
                                          ? Colors.white
                                          : null)),
                              onTap: () {
                                setState(() {
                                  selectedRole = listOfRole[1];
                                });
                              },
                            ),
                            PopupMenuItem(
                              value: 3,
                              child: Text(listOfRole[2],
                                  style: TextStyle(
                                      color: themeProvider.getIsDarkTheme
                                          ? Colors.white
                                          : null)),
                              onTap: () {
                                setState(() {
                                  selectedRole = listOfRole[2];
                                });
                              },
                            ),
                          ],
                        );
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            AssetsManager.login,
                            height: 35.0,
                            width: 35.0,
                          ),
                          Container(
                            width: size.width * .8,
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                titleTextWidget(
                                    txt: selectedRole,
                                    color: themeProvider.getIsDarkTheme
                                        ? Colors.white
                                        : Colors.grey[800]),
                                Icon(
                                  size: 27,
                                  Icons.keyboard_arrow_down_outlined,
                                  color: themeProvider.getIsDarkTheme
                                      ? Colors.grey[200]
                                      : Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  TxtFormFieldWidget(
                    obSecure: false,
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    label: "Email",
                    hintTxt: "youremail@fci.bu.edu.eg",
                    prefixIcon: IconlyLight.message,
                    validateFct: (value) {
                      return MyValidators.emailValidator(value);
                    },
                    onSubmitFct: (value) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  TxtFormFieldWidget(
                    obSecure: isSecure,
                    isSecureClick: (){
                      setState(() {
                        isSecure = !isSecure;
                      });
                    },
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    keyboardType: TextInputType.visiblePassword,
                    validateFct: (value) {
                      return MyValidators.passwordValidator(value);
                    },
                    onSubmitFct: (value) {
                      FocusScope.of(context)  .requestFocus(_passwordFocusNode);
                    },
                    label: "Password",
                    hintTxt: "**********",
                    prefixIcon: IconlyLight.lock,
                    suffixIcon: isSecure ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined,
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: TextButton(
                        onPressed: () async {
                          // await Navigator.pushNamed(
                          //     context, ForgotPasswordScreen.routeName);
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w600,
                            color: AppColors.drawerColor,
                            decoration: TextDecoration.underline,
                            fontStyle: FontStyle.italic,
                            decorationColor: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 35.0,
                  ),
                  defaultMaterialBtn(
                    onPressed: () {
                       if (_formKey.currentState!.validate()) {
                      Navigator.pushNamed(context, RootScreen.routeName);
                      }
                    },
                    btnWidth: double.infinity,
                    child: titleTextWidget(
                      txt: "Sign In",
                    ),
                  ),
                  const SizedBox(
                    height: 38.0,
                  ),
                  // SignUpOrSignInWidget(
                  //   txt: 'Don\'t have an account?',
                  //   txtBtn: 'SignUp now',
                  //   onPressedFct: () {
                  //     // Navigator.pushNamed(
                  //     //   context,
                  //     //   RegisterScreen.routeName,
                  //     // );
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
