import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/Presentation/Models/error_package.dart';
import 'package:mobile_app/Presentation/routers/app_router.dart';
import 'package:mobile_app/business_logic/events/reli_report_event.dart';
import 'package:mobile_app/business_logic/states/reli_report_state.dart';
import 'package:mobile_app/presentation/models/reliability_data.dart';

class ReliReportBloc extends Bloc<ReliReportEvent, ReliReportState> {
  ReliReportBloc() : super(ReliReportStateInit(timestamp: DateTime.now()));

  @override
  Stream<ReliReportState> mapEventToState(ReliReportEvent event) async* {
    if (event is ReliReportEventSearchingClicked) {
      yield ReliReportStateLoadingRequest();
      try {
        print('vao try relireport');
        final List reliReportData =
            await reliReportRepository.loadingReliDataRequest();
        if (reliReportData is List<ReliReport>) {
          print('load thanh cong');
          print(reliReportData[2].first);
          yield ReliReportStateLoadingSuccessful(timestamp: event.timestamp);
        } else if (reliReportData is ErrorPackage) {
          ReliReportStateLoadingFailure(
              timestamp: event.timestamp,
              errorPackage: ErrorPackage(
                  errorCode: reliReportData[0].errorCode,
                  message: reliReportData[0].message,
                  detail: reliReportData[0].detail));
        } else {
          print("clgt nay");
        }
      } on SocketException {
        yield ReliReportStateLoadingFailure(
          errorPackage: new ErrorPackage(
              errorCode: "SocketException",
              message: "Lost connection to the server",
              detail: ""),
        );
      } on TimeoutException {
        print('loi time out exception');
        yield ReliReportStateLoadingFailure(
          errorPackage: new ErrorPackage(
              errorCode: "TimeoutException", message: "Overtime", detail: ""),
        );
        print('loi bloc');
      } catch (e) {
        print('loi bay ba');
        //Chỗ này tránh các lỗi bậy bạ
        yield ReliReportStateLoadingFailure(
          errorPackage:
              new ErrorPackage(errorCode: "Exception", message: "", detail: ""),
        );
      }
    }
  }
}
