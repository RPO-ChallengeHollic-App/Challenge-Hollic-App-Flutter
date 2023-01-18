import 'dart:io';

import 'package:challange_hollic_mobile_app/models/auth-token.model.dart';
import 'package:challange_hollic_mobile_app/pages/auth/auth-base.page.dart';
import 'package:challange_hollic_mobile_app/services/challenge-holic-api-service.dart';
import 'package:challange_hollic_mobile_app/validators/signup-form.validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/local-db-helper.util.dart';
import '../../widgets/form/form-input-field.widget.dart';
import '../../widgets/link-with-info.widget.dart';

class SigninPage extends StatelessWidget {
  SigninPage({Key? key}) : super(key: key);
  final GlobalKey<FormState> _signinFormKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signin(BuildContext context, String username, String password) async {
    try {
      AuthToken authToken = await ChallengeHolicApiService.get.localSignin(username, password);
      await LocalDatabaseHelper.get.storeTokens(authToken.access!, authToken.refresh!);
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
          height: _screenHeight * 0.1,
          child: _title("Signin", color: Theme.of(context).primaryColor),
        ),

        SizedBox(height: _screenHeight * 0.05),

        // Signin / Login Form
        Form(
          key: _signinFormKey,
          child: Column(
            children: [
              FormInputField(
                labelText: 'Username',
                hintText: 'Username of email...',
                controller: _usernameController,
                borderColor: Theme.of(context).primaryColor,
                prefixIcon: Icons.account_circle_outlined,
                validator: SignupFormValidator.usernameValidator,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormInputField(
                      labelText: 'Password',
                      hintText: 'Password...',
                      controller: _passwordController,
                      obscureText: true,
                      borderColor: Theme.of(context).primaryColor,
                      prefixIcon: Icons.password,
                      validator: SignupFormValidator.passwordValidator,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: LinkWithInfo(
                        infoText: 'Forgo password?',
                        linkText: 'Click here',
                        onLinkPressed: () {},
                        linkColor: Theme.of(context).primaryColor
                    ),
                  )
                ],
              ),
            ],
          ),
        ),


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
                    'Signin',
                    height: _screenHeight * 0.06,
                    onPressed: () async {
                      if (_signinFormKey.currentState!.validate()) {
                        await _signin(context, _usernameController.text, _passwordController.text);
                      }
                    }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: LinkWithInfo(
                      infoText: 'Don\'t have an account?',
                      linkText: 'Signup',
                      onLinkPressed: () => context.go('/auth/signup'),
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
            Icons.groups_rounded,
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
