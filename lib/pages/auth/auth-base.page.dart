import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthBasePage extends StatelessWidget {
  final List<Widget> children;
  const AuthBasePage({required this.children, Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Material(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SafeArea(
              child: Column(// alignment: Alignment.topCenter,
                children: [
                  ...children,
                  Container(
                    height: screenHeight * 0.1,
                  )
                ],
              ),
            ),
          ),
      ),
    );
  }

  static Widget header({required Widget child, double height = 0}) {
    return Padding(
      padding: EdgeInsets.only(top: height),
      child: child,
    );
  }

  static Widget title(String text, {double height = 0, Color? textColor}) {
    return header(
      height: height,
      child: Text(
        text,
        textScaleFactor: 3,
        style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w900,
            shadows: const [
              Shadow(color: Color(0xE77E7E7E), blurRadius: 1, offset: Offset(0, 1))
            ]
        ),
      )
    );
  }

  static Widget authButton(String text, {height = 20.0, Function()? onPressed = null}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(height),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
          ),
        ),
        child: Text(
          text,
          textScaleFactor: 1.1,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
