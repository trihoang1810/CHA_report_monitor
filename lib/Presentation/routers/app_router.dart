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
import 'package:mobile_app/business_logic/blocs/defor_bending_report_bloc.dart';
import 'package:mobile_app/business_logic/blocs/login_bloc.dart';
import 'package:mobile_app/business_logic/blocs/reli__report_bloc.dart';
import 'package:mobile_app/models/deformation_rocktest_data.dart';
import 'package:mobile_app/repos/defor_bending_report_repos.dart';
import 'package:mobile_app/repos/defor_rock_report_repos.dart';
import 'package:mobile_app/repos/defor_static_report_repos.dart';
import 'package:mobile_app/repos/reli_cb_report_repos.dart';
import 'package:mobile_app/repos/reli_report_repos.dart';

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

class AppRouter {
  static ReliReportBloc reliReportBloc = ReliReportBloc();
  static LoginBloc loginBloc = LoginBloc();
  static DeforReportBloc deforReportBloc = DeforReportBloc();

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
      case '/modescreen':
        return MaterialPageRoute(builder: (_) => ModeScreen());
        break;
      case '/reliabilityreportscreen':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ReliReportBloc>.value(
              value: reliReportBloc, child: ReliabilityReportScreen()),
        );
        break;
      case '/reportmodescreen':
        return MaterialPageRoute(
          builder: (_) => ReportModeScreen(),
        );

        break;
      case '/deformationreportscreen':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<DeforReportBloc>.value(
              value: deforReportBloc, child: DeformationReportScreen()),
        );
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
