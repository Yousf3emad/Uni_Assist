
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:uni_assest/consts/app_colors.dart';
import 'package:uni_assest/screens/auth/login_screen.dart';
import 'package:uni_assest/screens/auth/txt_formfield_widget.dart';
import 'package:uni_assest/services/assets_manager.dart';
import 'package:uni_assest/widgets/default_material_btn.dart';
import 'package:uni_assest/widgets/title_text_widget.dart';

import '../../consts/my_validators.dart';
import '../../root_screen.dart';
import 'signup_or_signin_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
  static const String routeName = "RegisterScreen";
}

class _RegisterScreenState extends State<RegisterScreen> {

  //Controllers
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _repeatPassController;
  late final _formKey = GlobalKey<FormState>();
  //focus Nodes
    // Text Form Field
  late final FocusNode _nameFocusNode;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _repeatPassFocusNode;
    // Radio Button
   late final FocusNode _1stLvl;
  late final FocusNode _2ndLvl;
  late final FocusNode _3rdLvl;
  late final FocusNode _4rtLvl;

  @override
  void initState() {
    super.initState();
    // Controllers initialization
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _repeatPassController = TextEditingController();
    // Focus Nodes initialization
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _repeatPassFocusNode = FocusNode();
    _1stLvl = FocusNode();
    _2ndLvl = FocusNode();
    _3rdLvl = FocusNode();
    _4rtLvl = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPassController.dispose();

    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _repeatPassFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Level? selectedOption = Level.firstLvl;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border:const  Border(top: BorderSide(color: AppColors.primaryColor,width: 100)),
                        color: AppColors.drawerColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: size.width,
                      height: size.width*.5,

                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(150),
                          child: Image.asset(AssetsManager.qrRegScreen,height: 260,width: 260,fit: BoxFit.cover,),),
                    ),
                    Positioned(
                      bottom: -8,
                      child: titleTextWidget(
                        color: AppColors.drawerColor,
                        txt: "Uni Assist",
                        fontWeight: FontWeight.w900,
                        fontSize: 32
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24,),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleTextWidget(
                            fontWeight: FontWeight.w700,
                            maxLines: 3,color: Colors.grey[800],
                            txt:
                            "Register now to manage your attendance and schedule easily with Uni Assist.."),
                        const SizedBox(
                          height: 18.0,
                        ),
                        TxtFormFieldWidget(
                          controller: _nameController,
                          focusNode: _nameFocusNode,
                          keyboardType: TextInputType.text,
                          label: "Name",
                          hintTxt: "Please Enter your full name",
                          prefixIcon: IconlyLight.profile,
                          preIconColor: AppColors.drawerColor,
                          validateFct: (value) {
                            return MyValidators.displayNameValidator(value);
                          },
                          onSubmitFct: (value) {
                            FocusScope.of(context).requestFocus(_passwordFocusNode);
                          },
                        ),
                        const SizedBox(
                          height: 18.0,
                        ),
                        TxtFormFieldWidget(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          label: "Email",
                          hintTxt: "youremail@fci.bu.edu.eg",
                          prefixIcon: IconlyLight.message,
                          preIconColor: AppColors.drawerColor,
                          validateFct: (value) {
                             return MyValidators.emailValidator(value);
                          },
                          onSubmitFct: (value) {
                            FocusScope.of(context).requestFocus(_passwordFocusNode);
                          },
                        ),
                        const SizedBox(
                          height: 18.0,
                        ),
                        TxtFormFieldWidget(
                          obSecure: true,
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                          keyboardType: TextInputType.visiblePassword,
                          validateFct: (value) {
                             return MyValidators.passwordValidator(value);
                          },
                          onSubmitFct: (value){
                            FocusScope.of(context).requestFocus(_passwordFocusNode);
                          },
                          label: "Password",
                          hintTxt: "**********",
                          prefixIcon: IconlyLight.password,
                          preIconColor: AppColors.drawerColor,
                          suffixIcon: Icons.remove_red_eye_outlined,
                        ),
                        const SizedBox(
                          height: 18.0,
                        ),
                        TxtFormFieldWidget(
                          obSecure: true,
                          controller: _repeatPassController,
                          focusNode: _repeatPassFocusNode,
                          keyboardType: TextInputType.visiblePassword,
                          validateFct: (value) {
                             return MyValidators.repeatPasswordValidator(value: value,password: _passwordController.text);
                          },
                          onSubmitFct: (value){
                            FocusScope.of(context).requestFocus(_passwordFocusNode);
                          },
                          label: "Repeat Password",
                          hintTxt: "**********",
                          prefixIcon: IconlyLight.password,
                          preIconColor: AppColors.drawerColor,
                        ),
                        const SizedBox(
                          height: 18.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: titleTextWidget(txt: "Level ",),
                        ),
                        Column(
                          children: <Widget>[
                            RadioListTile<Level>(
                              focusNode: _1stLvl,
                              hoverColor: AppColors.primaryColor,
                              activeColor: AppColors.drawerColor,
                              title: const Text(
                                '1st LVL',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              value: Level.firstLvl,
                              groupValue: selectedOption,
                              onChanged: (Level? value) {
                                setState(() {
                                  selectedOption = value;
                                  print(selectedOption);
                                });
                              },
                            ),
                            RadioListTile<Level>(
                              focusNode: _2ndLvl,
                              hoverColor: AppColors.primaryColor,
                              value: Level.secondLvl,
                              groupValue: selectedOption,
                              onChanged: (Level? value) {
                                setState(() {
                                  selectedOption = value;
                                  print("$selectedOption 2");
                                });
                              },
                              title: Text(
                                '2nd LVL',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            RadioListTile<Level>(
                              focusNode: _3rdLvl,
                              hoverColor: AppColors.primaryColor,
                              value: Level.thirdLvl,
                              groupValue: selectedOption,
                              onChanged: (Level? value) {
                                setState(() {
                                  selectedOption = value;
                                  print("$selectedOption 3");
                                });
                              },
                              title: const Text(
                                '3rd LVL',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            RadioListTile<Level>(
                              focusNode: _4rtLvl,
                              hoverColor: AppColors.primaryColor,
                              value: Level.fourthLvl,
                              groupValue: selectedOption,
                              onChanged: (Level? value) {
                                setState(() {
                                  selectedOption = value;
                                  print("$selectedOption 3");
                                });
                              },
                              title: const Text(
                                '4th LVL',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18.0,),
                        defaultMaterialBtn(
                          onPressed: () {
                            // if (_formKey.currentState!.validate()) {
                              Navigator.pushNamed(context, RootScreen.routeName);
                            //}
                          },
                          btnWidth: double.infinity,
                          child: titleTextWidget(
                            txt: "Sign Up",
                          ),
                        ),
                        const SizedBox(
                          height: 38.0,
                        ),
                        SignUpOrSignInWidget(
                          txt: 'have an account?',
                          txtBtn: 'SignIn now',
                          onPressedFct: (){
                            Navigator.pushNamed(context, LoginScreen.routeName,);
                          },
                        ),
                        const SizedBox(height: 24.0,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum Level { firstLvl, secondLvl, thirdLvl,fourthLvl }