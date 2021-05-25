import 'package:flutter/material.dart' as mat;
import 'package:mobile_app/Presentation/routers/app_router.dart';

class MyApp extends mat.StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  @override
  mat.Widget build(mat.BuildContext context) {
    return mat.MaterialApp(
      onGenerateRoute: _appRouter.onGenerateRoute,
      title: 'Báo cáo và Giám sát NBC',
    );
  }
}
