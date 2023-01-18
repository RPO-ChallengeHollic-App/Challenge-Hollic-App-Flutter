import 'package:challange_hollic_mobile_app/pages/auth/signup.page.dart';
import 'package:challange_hollic_mobile_app/pages/challenge-list/challenge-detail.page.dart';
import 'package:challange_hollic_mobile_app/pages/challenge-list/challnege-list.page.dart';
import 'package:challange_hollic_mobile_app/pages/groups/group-list.page.dart';
import 'package:go_router/go_router.dart';
import '../pages/auth/signin.page.dart';
import '../pages/auth/welcome.page.dart';

class AppConfig {
  static final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => ChallengeListPage(),
        routes: [
          GoRoute(
              path: 'auth',
              builder: (context, state) => const WelcomePage(),
              routes: [
                GoRoute(
                  path: 'signin',
                  builder: (context, state) => SigninPage(),
                ),
                GoRoute(
                  path: 'signup',
                  builder: (context, state) => SignupPage(),
                )
              ]
          ),
          GoRoute(
            path: 'challenge/detail',
            builder: (context, state) => ChallengeDetailPage()
          ),
          GoRoute(
              path: 'groups',
              builder: (context, state) => GroupListPage()
          ),
        ],
      ),
    ],
  );

  static GoRouter get router => _router;
}