import 'package:challange_hollic_mobile_app/pages/auth/auth-base.page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/form/form-input-field.widget.dart';
import '../../widgets/link-with-info.widget.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    return AuthBasePage(
      children: [
        AuthBasePage.header(
          height: _screenHeight * 0.12,
          child: _title("Signin", color: Theme.of(context).primaryColor),
        ),

        SizedBox(height: _screenHeight * 0.05),

        // Signin / Login Form

        FormInputField(
          labelText: 'Username',
          hintText: 'Username of email...',
          borderColor: Theme.of(context).primaryColor,
          prefixIcon: Icons.account_circle_outlined,
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormInputField(
              labelText: 'Password',
              hintText: 'Password...',
              obscureText: true,
              borderColor: Theme.of(context).primaryColor,
              prefixIcon: Icons.password
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: LinkWithInfo(
                infoText: 'Forgo password?',
                linkText: 'Click here',
                onLinkPressed: () {}, // TODO: Implement password reset button
                linkColor: Theme.of(context).primaryColor
              ),
            )
          ],
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
                    onPressed: () {} // TODO: Implement signin logic
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
