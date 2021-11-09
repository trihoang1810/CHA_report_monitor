import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/presentations/screens/mode-screen/mode_screen.dart';
import 'package:mobile_app/presentations/screens/mode-screen/monitor_mode_screen.dart';
import 'package:mobile_app/presentations/screens/mode-screen/report_mode_screen.dart';
import 'package:mobile_app/presentations/screens/monitor-main-screen/deformation_monitor_screen.dart';
import 'package:mobile_app/presentations/screens/monitor-main-screen/reliability_monitor_screen.dart';
import 'package:mobile_app/presentations/screens/report-main-screen/deformation_report_screen.dart';
import 'package:mobile_app/presentations/screens/report-main-screen/reliability_report_screen.dart';
import 'package:mobile_app/presentations/screens/others/home_screen.dart';
import 'package:mobile_app/presentations/screens/others/login_screen.dart';
import 'package:mobile_app/repository/login_repos.dart';
import 'package:mobile_app/blocs/blocs/defor_bending_report_bloc.dart';
import 'package:mobile_app/blocs/blocs/defor_monitor_bloc.dart';
import 'package:mobile_app/blocs/blocs/login_bloc.dart';
import 'package:mobile_app/blocs/blocs/reli__report_bloc.dart';
import 'package:mobile_app/blocs/blocs/reli_monitor_bloc.dart';
import 'package:mobile_app/repository/defor_bending_report_repos.dart';
import 'package:mobile_app/repository/defor_rock_report_repos.dart';
import 'package:mobile_app/repository/defor_static_report_repos.dart';
import 'package:mobile_app/repository/reli_cb_report_repos.dart';
import 'package:mobile_app/repository/reli_report_repos.dart';

DeforRockReportRepository deforRockReportRepository =
    new DeforRockReportRepository(httpClient: http.Client());
DeforStaticReportRepository deforStaticReportRepository =
    new DeforStaticReportRepository(httpClient: http.Client());
DeforBendingReportRepository deforBendingReportRepository =
    new DeforBendingReportRepository(httpClient: http.Client());
LoginRepository loginRepository =
    new LoginRepository(httpClient: http.Client());
ReliReportRepository reliReportRepository =
    new ReliReportRepository(httpClient: http.Client());
ReliCBReportRepository reliCBReportRepository =
    new ReliCBReportRepository(httpClient: http.Client());

//-------------------------------------------------------------
class AppRouter {
  static ReliMonitorBloc reliMonitorBloc = ReliMonitorBloc();
  static ReliReportBloc reliReportBloc = ReliReportBloc();
  static LoginBloc loginBloc = LoginBloc();
  static DeforReportBloc deforReportBloc = DeforReportBloc();
  static DeforMonitorBloc deforMonitorBloc = DeforMonitorBloc();
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => HomeScreen());
        break;
      case '/loginscreen':
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) => BlocProvider<LoginBloc>.value(
            value: loginBloc,
            child: LoginScreen(),
          ),
        );
        break;
      case '/modescreen':
        return MaterialPageRoute(
            settings: routeSettings, builder: (context) => ModeScreen());
        break;
      case '/reliabilityreportscreen':
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ReliReportBloc>.value(
              value: reliReportBloc, child: ReliabilityReportScreen()),
        );
        break;
      case '/reportmodescreen':
        return MaterialPageRoute(
          builder: (context) => ReportModeScreen(),
        );

        break;
      case '/deformationreportscreen':
        return MaterialPageRoute(
          builder: (context) => BlocProvider<DeforReportBloc>.value(
              value: deforReportBloc, child: DeformationReportScreen()),
        );
        break;
      case '/monitormodescreen':
        return MaterialPageRoute(builder: (context) => MonitorModeScreen());
        break;
      case '/reliabilitymonitorscreen':
        return MaterialPageRoute(
            builder: (context) => BlocProvider<ReliMonitorBloc>.value(
                value: reliMonitorBloc, child: ReliabilityMonitorScreen()));
        break;
      case '/deformationmonitorscreen':
        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: deforMonitorBloc,
                  child: DeformationMonitorScreen(),
                ));
        break;
      default:
        return MaterialPageRoute(builder: (context) => HomeScreen());
    }
  }
}
