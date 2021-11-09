import 'package:flutter/material.dart';
import 'package:mobile_app/presentations/routers/app_router.dart';

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _appRouter.onGenerateRoute,
      title: 'Báo cáo và Giám sát',
    );
  }
}
