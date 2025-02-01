import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:test_mvvm/features/number_trivia/view/pages/number_trivia_page.dart';

final router = GoRouter(
  navigatorKey: GlobalKey<NavigatorState>(),
  routes: [
    GoRoute(
        path: '/',
        name: 'number_trivia',
        builder: (context, state) => const NumberTriviaView()
    ),
  ]
);