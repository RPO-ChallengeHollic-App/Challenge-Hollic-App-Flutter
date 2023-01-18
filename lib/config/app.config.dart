import 'package:challange_hollic_mobile_app/pages/auth/signup.page.dart';
import 'package:go_router/go_router.dart';
import '../pages/auth/signin.page.dart';
import '../pages/auth/welcome.page.dart';

class AppConfig {
  static final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => WelcomePage(),
        routes: [
          GoRoute(
              path: 'auth',
              builder: (context, state) => const WelcomePage(),
              routes: [
                GoRoute(
                  path: 'signin',
                  builder: (context, state) => const SigninPage(),
                ),
                GoRoute(
                  path: 'signup',
                  builder: (context, state) => SignupPage(),
                )
              ]
          ),
        ],
      ),
    ],
  );

  static GoRouter get router => _router;
}