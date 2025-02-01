import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_mvvm/core/route/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Flutter MVVM',
        scaffoldMessengerKey: GlobalKey<ScaffoldMessengerState>(),
        locale: const Locale('id', 'ID'),
      )
    )
  );
}
