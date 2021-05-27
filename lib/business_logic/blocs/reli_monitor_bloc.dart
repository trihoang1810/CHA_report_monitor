import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/business_logic/events/reli_monitor_event.dart';
import 'package:mobile_app/business_logic/states/reli_monitor_state.dart';
import 'package:mobile_app/models/error_package.dart';
import 'package:mobile_app/models/reliability_cb_monitor_data.dart';
import 'package:mobile_app/models/reliability_monitor_data.dart';
import 'package:mobile_app/presentation/routers/app_router.dart';

class ReliMonitorBloc extends Bloc<ReliMonitorEvent, ReliMonitorState> {
  ReliMonitorBloc()
      : super(ReliMonitorStateInit(
            timestamp: DateTime.now(),
            data1: "null",
            data2: "null",
            data3: "null",
            data4: "null"));
  @override
  Stream<ReliMonitorState> mapEventToState(ReliMonitorEvent event) async* {
    if (event is ReliMonitorEventSearchingClicked) {
      try {
        yield ReliMonitorStateLoadingRequest(timestamp: event.timestamp);
        final reliMonitorData =
            await reliMonitorRepository.loadingReliDataRequest();
        if (reliMonitorData is ReliMonitorData) {
          print('moment là ${reliMonitorData.moment}');
          yield ReliMonitorStateLoadingSuccessful(
              timestamp: event.timestamp, reliMonitorData: reliMonitorData);
        } else if (reliMonitorData is ErrorPackage) {
          print('thất bại');
          yield ReliMonitorStateLoadingFailure(
              timestamp: event.timestamp, errorPackage: reliMonitorData);
        } else {
          print('Lỗi bậy bạ');
          throw SocketException("Lỗi bậy bạ");
        }
      } on SocketException {
        print("Lỗi socket");
        yield ReliMonitorStateLoadingFailure(
          errorPackage: new ErrorPackage(
              errorCode: "SocketException",
              message: "Lost connection to the server",
              detail: ""),
        );
      } on TimeoutException {
        print('loi time out exception');
        yield ReliMonitorStateLoadingFailure(
          errorPackage: new ErrorPackage(
              errorCode: "TimeoutException", message: "Overtime", detail: ""),
        );
      } catch (e) {
        print("Lỗi e");
        yield ReliMonitorStateLoadingFailure(
            errorPackage:
                ErrorPackage(errorCode: "Exception", message: "", detail: ""));
      }
    } else if (event is ReliCBMonitorEventSearchingClicked) {
      try {
        yield ReliCBMonitorStateLoadingRequest(timestamp: event.timestamp);
        final reliCBMonitorData =
            await reliCBMonitorRepository.loadingReliCBDataRequest();
        if (reliCBMonitorData is ReliCBMonitorData) {
          print('moment là ${reliCBMonitorData.moment}');
          yield ReliCBMonitorStateLoadingSuccessful(
              timestamp: event.timestamp, reliCBMonitorData: reliCBMonitorData);
        } else if (reliCBMonitorData is ErrorPackage) {
          print('thất bại');
          yield ReliCBMonitorStateLoadingFailure(
              timestamp: event.timestamp, errorPackage: reliCBMonitorData);
        } else {
          print('Lỗi bậy bạ');
          throw SocketException("Lỗi bậy bạ");
        }
      } on SocketException {
        print("Lỗi socket");
        yield ReliCBMonitorStateLoadingFailure(
          errorPackage: new ErrorPackage(
              errorCode: "SocketException",
              message: "Lost connection to the server",
              detail: ""),
        );
      } on TimeoutException {
        print('loi time out exception');
        yield ReliCBMonitorStateLoadingFailure(
          errorPackage: new ErrorPackage(
              errorCode: "TimeoutException", message: "Overtime", detail: ""),
        );
      } catch (e) {
        print("Lỗi e");
        yield ReliCBMonitorStateLoadingFailure(
            errorPackage:
                ErrorPackage(errorCode: "Exception", message: "", detail: ""));
      }
    }
  }
}
