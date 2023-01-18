import 'dart:io';
import 'dart:math';

import 'package:challange_hollic_mobile_app/models/auth-token.model.dart';
import 'package:challange_hollic_mobile_app/services/challenge-holic-api-service.dart';
import 'package:challange_hollic_mobile_app/utils/file-picker.util.dart';
import 'package:challange_hollic_mobile_app/utils/local-db-helper.util.dart';
import 'package:challange_hollic_mobile_app/validators/signup-form.validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/form/form-input-field.widget.dart';
import '../../widgets/link-with-info.widget.dart';
import 'auth-base.page.dart';

class SignupPage extends StatefulWidget {

  SignupPage({Key? key}) : super(key: key);
  @override
  State<SignupPage> createState() => _SignupPageState();

  static Widget _title(String text, {Color? color}) {
    return Row(
      children: [
        Text(
          text,
          textScaleFactor: 2.5,
          style: TextStyle(
              fontWeight: FontWeight.w900,
              color: color,
              shadows: const [
                Shadow(color: Color(0xE7CCCCCC), blurRadius: 1, offset: Offset(0, 1))
              ]
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Icon(
            Icons.group_add,
            size: 40,
            color: color,
            shadows: const [
              Shadow(color: Color(0xE7CCCCCC), blurRadius: 1, offset: Offset(0, 1))
            ],
          ),
        ),
      ],
    );
  }
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  File? _profileImageFile;

  Future<void> _signup(BuildContext context, String username, String email, String password, File? profile) async {
    try {
      AuthToken authToken = await ChallengeHolicApiService.get.localSingup(username, email, password, profile);
      await LocalDatabaseHelper.get.storeRefreshToken(authToken.refresh!);
      context.pop();
    } on Exception catch(ex) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(ex.toString().substring(11)),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    return AuthBasePage(
      children: [
        AuthBasePage.header(
          child: SignupPage._title("Signup", color: Theme.of(context).primaryColor),
        ),

        SizedBox(height: _screenHeight * 0.05),

        Expanded(
          flex: 3,
          child: Form(
            key: _signUpFormKey,
            child: Column(
              children: [
                _profileImagePicker(
                  profileImageFile: _profileImageFile,
                  defaultImage: 'assets/images/profile_pic_man.svg',
                  radius: _screenHeight * 0.1,
                  onPick: () async {
                    File? pickedFile = await FilePickerUtil.pickSingleFile(allowedExtensions: ["jpg", "jpeg", "png"]);
                    if (pickedFile != null) {
                      setState(() {
                        _profileImageFile = pickedFile;
                      });
                    }
                  }
                ),

                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 150),
                    children: [
                      FormInputField(
                        labelText: 'Username',
                        hintText: 'Username...',
                        controller: _usernameController,
                        borderColor: Theme.of(context).primaryColor,
                        prefixIcon: Icons.account_circle_outlined,
                        validator: SignupFormValidator.usernameValidator,
                      ),

                      FormInputField(
                        labelText: 'E-mail',
                        hintText: 'E-mail...',
                        controller: _emailController,
                        borderColor: Theme.of(context).primaryColor,
                        prefixIcon: Icons.email_outlined,
                        validator: SignupFormValidator.emailValidator,
                      ),

                      FormInputField(
                        labelText: 'Password',
                        hintText: 'Password...',
                        obscureText: true,
                        borderColor: Theme.of(context).primaryColor,
                        prefixIcon: Icons.password_rounded,
                        controller: _passwordController,
                        validator: SignupFormValidator.passwordValidator,
                      ),

                      FormInputField(
                        labelText: 'Re-Password',
                        hintText: 'Repeat password...',
                        obscureText: true,
                        borderColor: Theme.of(context).primaryColor,
                        prefixIcon: Icons.password_rounded,
                        validator: (value) => SignupFormValidator.rePasswordValidator(value, _passwordController.text),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Next + Signin link info
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: AuthBasePage.authButton(
                      'Signup',
                      height: _screenHeight * 0.06,
                      onPressed: () async {
                        if (_signUpFormKey.currentState!.validate()) {
                          await _signup(context, _usernameController.text, _emailController.text, _passwordController.text, _profileImageFile);
                        }
                      }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: LinkWithInfo(
                      infoText: 'Already have an account?',
                      linkText: 'Signin',
                      onLinkPressed: () => context.go('/auth/signin'),
                      linkColor: Theme.of(context).primaryColor
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  static Widget _profileImagePicker({
      File? profileImageFile,
      required double radius,
      required String defaultImage,
      required void Function() onPick}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: onPick,
        child: CircleAvatar(
          maxRadius: radius,
          child: profileImageFile != null ?
          CircleAvatar(
            radius: radius,
            backgroundImage: FileImage(profileImageFile),
          ) : SvgPicture.asset(defaultImage),
        ),
      ),
    );
  }

  Widget _profileImagePickerPopup(BuildContext context, double height) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 10, right: 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [

          const Text(
            'Choose your profile picture',
            style: TextStyle(
                color: Color(0xFFBFBFBF),
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: AuthBasePage.authButton(
                  'Done',
                  onPressed: () {}, // TODO: Implement Done button when selecting profile image
                  height: 50.0
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
