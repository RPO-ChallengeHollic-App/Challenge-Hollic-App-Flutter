import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LinkWithInfo extends StatelessWidget {
  final String infoText;
  final String linkText;
  final Color? linkColor;
  final Function()? onLinkPressed;

  const LinkWithInfo({
    required this.infoText,
    required this.linkText,
    this.linkColor,
    this.onLinkPressed,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: const TextStyle(
            color: Color(0xFFBFBFBF),
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
          ),
          children: [
            TextSpan(text: '$infoText '),
            TextSpan(
                style: TextStyle(
                  color: linkColor,
                  decoration: TextDecoration.underline,
                  decorationThickness: 2,
                ),
              text: linkText,
              recognizer: TapGestureRecognizer()..onTap = onLinkPressed // .. --> cascade return reference
            ),
          ]
      ),
    );
  }
}
