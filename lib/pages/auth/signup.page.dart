import 'package:challange_hollic_mobile_app/validators/signup-form.validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/form/form-input-field.widget.dart';
import '../../widgets/link-with-info.widget.dart';
import 'auth-base.page.dart';

class SignupPage extends StatelessWidget {
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    return AuthBasePage(
      children: [
        AuthBasePage.header(
          height: _screenHeight * 0.12,
          child: _title("Signup", color: Theme.of(context).primaryColor),
        ),

        SizedBox(height: _screenHeight * 0.05),

        Form(
          key: _signUpFormKey,
          child: Column(
            children: [
              FormInputField(
                labelText: 'Username',
                hintText: 'Username...',
                borderColor: Theme.of(context).primaryColor,
                prefixIcon: Icons.account_circle_outlined,
                validator: SignupFormValidator.usernameValidator,
              ),

              FormInputField(
                labelText: 'E-mail',
                hintText: 'E-mail...',
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
                      'Next',
                      height: _screenHeight * 0.06,
                      onPressed: () { // TODO: Implement Text and function switch for signup after done is clicked
                        if (_signUpFormKey.currentState!.validate()) {
                          showModalBottomSheet(
                            context: context,
                            shape: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20.0),
                              ),
                            ),
                            builder: (context) => _profileImagePickerPopup(_screenHeight * 0.1),
                          );
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

  static Widget _profileImagePickerPopup(double height) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 10, right: 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: CircleAvatar(
              maxRadius: height,
              child: SvgPicture.asset(
                  'assets/images/profile_pic_man.svg'
              ),
            ),
          ),
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
