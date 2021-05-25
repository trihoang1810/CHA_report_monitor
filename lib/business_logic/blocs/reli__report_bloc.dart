import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/Presentation/Models/error_package.dart';
import 'package:mobile_app/business_logic/events/reli_report_event.dart';
import 'package:mobile_app/business_logic/states/reli_report_state.dart';
import 'package:mobile_app/models/reliability_cb_data.dart';
import 'package:mobile_app/models/reliability_data.dart';
import 'package:mobile_app/presentation/routers/app_router.dart';

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
          yield ReliReportStateLoadingFailure(
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
    } else if (event is ReliCBReportEventSearchingClicked) {
      print('reli RPCB clicked');
      yield ReliCBReportStateLoadingRequest();
      try {
        print('vao try relicbreport');
        final List reliCBReportData =
            await reliCBReportRepository.loadingReliCBDataRequest();
        if (reliCBReportData is List<ReliCBReport>) {
          print('load cb thanh cong');
          print(reliCBReportData[2].first);
          yield ReliCBReportStateLoadingSuccessful(timestamp: event.timestamp);
        } else if (reliCBReportData is ErrorPackage) {
          ReliCBReportStateLoadingFailure(
              timestamp: event.timestamp,
              errorPackage: ErrorPackage(
                  errorCode: reliCBReportData[0].errorCode,
                  message: reliCBReportData[0].message,
                  detail: reliCBReportData[0].detail));
        } else {
          print("clgt nay");
        }
      } on SocketException {
        yield ReliCBReportStateLoadingFailure(
          errorPackage: new ErrorPackage(
              errorCode: "SocketException",
              message: "Lost connection to the server",
              detail: ""),
        );
      } on TimeoutException {
        print('loi time out exception');
        yield ReliCBReportStateLoadingFailure(
          errorPackage: new ErrorPackage(
              errorCode: "TimeoutException", message: "Overtime", detail: ""),
        );
        print('loi bloc');
      } catch (e) {
        print('loi bay ba');
        //Chỗ này tránh các lỗi bậy bạ
        yield ReliCBReportStateLoadingFailure(
          errorPackage:
              new ErrorPackage(errorCode: "Exception", message: "", detail: ""),
        );
      }
    }
  }
}
