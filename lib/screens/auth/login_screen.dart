import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:uni_assest/consts/app_colors.dart';
import 'package:uni_assest/consts/my_validators.dart';
import 'package:uni_assest/root_screen.dart';
import 'package:uni_assest/screens/auth/register_screen.dart';
import 'package:uni_assest/screens/auth/signup_or_signin_widget.dart';
import 'package:uni_assest/screens/auth/txt_formfield_widget.dart';
import 'package:uni_assest/services/assets_manager.dart';
import 'package:uni_assest/widgets/default_material_btn.dart';
import 'package:uni_assest/widgets/title_text_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
  static const String routeName = "LoginScreen";
}

class _LoginScreenState extends State<LoginScreen> {
  //Controllers
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  //Form Key
  late final _formKey = GlobalKey<FormState>();
  //Focus Nodes
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  late final FocusNode _drFocusNode;
  late final FocusNode _tasFocusNode;
  late final FocusNode _studentFocusNode;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _drFocusNode = FocusNode();
    _tasFocusNode = FocusNode();
    _studentFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _emailFocusNode.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();

    _drFocusNode.dispose();
    _tasFocusNode.dispose();
    _studentFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    JobTitle? selectedOption = JobTitle.Dr;
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
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    keyboardType: TextInputType.visiblePassword,
                    validateFct: (value) {
                      return MyValidators.passwordValidator(value);
                    },
                    onSubmitFct: (value) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    label: "Password",
                    hintTxt: "**********",
                    prefixIcon: IconlyLight.lock,
                    suffixIcon: Icons.remove_red_eye_outlined,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: RadioListTile<JobTitle>(
                          focusNode: _drFocusNode,
                          hoverColor: AppColors.primaryColor,
                          activeColor: AppColors.drawerColor,
                          title: FittedBox(
                            child: const Text(
                              'Dr.',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          value: JobTitle.Dr,
                          groupValue: selectedOption,
                          onChanged: (JobTitle? value) {
                            setState(() {
                              selectedOption = value;
                              print(selectedOption);
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: RadioListTile<JobTitle>(
                          focusNode: _tasFocusNode,
                          hoverColor: AppColors.primaryColor,
                          value: JobTitle.TAs,
                          groupValue: selectedOption,
                          onChanged: (JobTitle? value) {
                            setState(() {
                              selectedOption = value;
                              print("$selectedOption 2");
                            });
                          },
                          title: FittedBox(
                            child: Text(
                              'TAs',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: RadioListTile<JobTitle>(
                          focusNode: _studentFocusNode,
                          hoverColor: AppColors.primaryColor,
                          value: JobTitle.student,
                          groupValue: selectedOption,
                          onChanged: (JobTitle? value) {
                            setState(() {
                              selectedOption = value;
                              print("$selectedOption 3");
                            });
                          },
                          title: FittedBox(
                            child: const Text(
                              'Student',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                      // if (_formKey.currentState!.validate()) {
                      Navigator.pushNamed(context, RootScreen.routeName);
                      //}
                    },
                    btnWidth: double.infinity,
                    child: titleTextWidget(
                      txt: "Sign In",
                    ),
                  ),
                  const SizedBox(
                    height: 38.0,
                  ),
                  SignUpOrSignInWidget(
                    txt: 'Don\'t have an account?',
                    txtBtn: 'SignUp now',
                    onPressedFct: () {
                      Navigator.pushNamed(
                        context,
                        RegisterScreen.routeName,
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum JobTitle { Dr, TAs, student }
