import 'package:challange_hollic_mobile_app/pages/auth/auth-base.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    return AuthBasePage(
      children: [
        AuthBasePage.title(
          'Welcome',
          height: _screenHeight * 0.12,
          textColor: Theme.of(context).primaryColor
        ),

        SvgPicture.asset(
          'assets/images/personal_data.svg',
          semanticsLabel: 'Acme Logo',
          height: _screenHeight * 0.5,
          fit: BoxFit.fitWidth,
        ),

        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AuthBasePage.authButton(
                  'Signin',
                  height: _screenHeight * 0.05,
                  onPressed: () => context.push('/auth/signin'),
                ),
                AuthBasePage.authButton(
                  'Signup',
                  height: _screenHeight * 0.05,
                  onPressed: () => context.push('/auth/signup'),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
