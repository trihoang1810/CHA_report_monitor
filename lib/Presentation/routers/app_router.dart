import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/Presentation/Screens/ModeScreen/mode_screen.dart';
import 'package:mobile_app/Presentation/Screens/ModeScreen/monitor_mode_screen.dart';
import 'package:mobile_app/Presentation/Screens/ModeScreen/report_mode_screen.dart';
import 'package:mobile_app/Presentation/Screens/MonitorMainScreen/deformation_monitor_screen.dart';
import 'package:mobile_app/Presentation/Screens/MonitorMainScreen/reliability_monitor_screen.dart';
import 'package:mobile_app/Presentation/Screens/ReportMainScreen/deformation_report_screen.dart';
import 'package:mobile_app/Presentation/Screens/ReportMainScreen/reliability_report_screen.dart';
import 'package:mobile_app/Presentation/Screens/home_screen.dart';
import 'package:mobile_app/Presentation/Screens/login_screen.dart';
import 'package:mobile_app/Repos/login_repos.dart';
import 'package:mobile_app/business_logic/blocs/login_bloc.dart';

LoginRepository loginRepository =
    new LoginRepository(httpClient: http.Client());

class AppRouter {
  static LoginBloc loginBloc = LoginBloc();
  void clearBloc() {
    LoginBloc loginBloc = LoginBloc();
  }

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
        break;
      case '/loginscreen':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LoginBloc>.value(
            value: loginBloc,
            child: LoginScreen(),
          ),
        );
        break;
      case '/modescren':
        return MaterialPageRoute(builder: (_) => ModeScreen());
        break;
      case '/reliabilityreportscreen':
        return MaterialPageRoute(builder: (_) => ReliabilityReportScreen());
        break;
      case '/reportmodescreen':
        return MaterialPageRoute(builder: (_) => ReportModeScreen());
        break;
      case '/deformationreportscreen':
        return MaterialPageRoute(builder: (_) => DeformationReportScreen());
        break;
      case '/monitormodescreen':
        return MaterialPageRoute(builder: (_) => MonitorModeScreen());
        break;
      case '/reliabilitymonitorscreen':
        return MaterialPageRoute(builder: (_) => ReliabilityMonitorScreen());
        break;
      case '/deformationmonitorscreen':
        return MaterialPageRoute(builder: (_) => DeformationMonitorScreen());
        break;
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}
