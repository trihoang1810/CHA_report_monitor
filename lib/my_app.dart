import 'package:flutter/material.dart';
import 'package:mobile_app/Presentation/routers/app_router.dart';
import 'package:mobile_app/presentation/widget/constant.dart';

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
