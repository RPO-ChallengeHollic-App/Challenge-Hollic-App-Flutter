import 'package:challange_hollic_mobile_app/config/app.config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(ChallengeHolicApp());

class ChallengeHolicApp extends StatelessWidget {
  const ChallengeHolicApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Challegneholic',
      routerConfig: AppConfig.router,
      theme: ThemeData.from(colorScheme: const ColorScheme.light(
        background: Color(0xFFF7F9FA),
        primary: Color(0xFFFFC400)
      )),
    );
  }
}
