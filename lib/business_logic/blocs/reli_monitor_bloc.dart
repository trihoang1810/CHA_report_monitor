import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/business_logic/events/reli_monitor_event.dart';
import 'package:mobile_app/business_logic/states/reli_monitor_state.dart';
import 'package:mobile_app/models/error_package.dart';
import 'package:mobile_app/models/reliability_cb_monitor_data.dart';
import 'package:mobile_app/models/reliability_monitor_data.dart';
import 'package:signalr_core/signalr_core.dart';

class ReliMonitorBloc extends Bloc<ReliMonitorEvent, ReliMonitorState> {
  int count = 0;
  ReliMonitorBloc()
      : super(ReliMonitorStateInit(
            timestamp: DateTime.now(),
            data1: "null1",
            data2: "null1",
            data3: "null1",
            data4: "null1",
            running: false,
            warning: false));
  @override
  Stream<ReliMonitorState> mapEventToState(ReliMonitorEvent event) async* {
    if (event is ReliMonitorEventHubConnected) {
      yield ReliMonitorStateLoadingRequest(timestamp: event.timestamp);
      event.hubConnection.state == HubConnectionState.disconnected
          ? await event.hubConnection.start().onError((error, stackTrace) {
              count = 1;
              return ReliMonitorBloc().add(ReliMonitorEventConnectFail(
                  errorPackage: ErrorPackage(
                      message: "Không thể kết nối tới máy chủ",
                      detail: "vui lòng kiểm tra đường truyền")));
            })
          : await event.hubConnection.stop();
      if (event.hubConnection.state == HubConnectionState.disconnected &&
          count == 0) {
        yield ReliMonitorStateConnectFail(
            errorPackage: ErrorPackage(
                message: "Ngắt kết nối",
                detail: "Đã ngắt kết nối tới máy chủ"));
      } else if (event.hubConnection.state == HubConnectionState.disconnected &&
          count == 1) {
        yield ReliMonitorStateConnectFail(
            errorPackage: ErrorPackage(
                message: "Không thể kết nối tới máy chủ",
                detail: "vui lòng kiểm tra đường truyền"));
        count = 0;
      } else if (event.hubConnection.state == HubConnectionState.connected) {
        ReliMonitorData reliMonitorData = ReliMonitorData(
            alarm: false,
            running: false,
            soLanDongNapCaiDat: 0,
            soLanDongNapHienTai: 0,
            thoiGianGiuNapDong: 0,
            thoiGianGiuNapMo: 0);
        yield ReliMonitorStateConnectSucessful(
          reliMonitorData: reliMonitorData,
        );
      }
    } else if (event is ReliMonitorEventDataUpdated) {
      print('đã bắt được event');
      print(event.reliMonitorData.soLanDongNapCaiDat);
      yield ReliMonitorStateDataUpdated(
          timestamp: DateTime.now(), reliMonitorData: event.reliMonitorData);
    }
    //--------------------

    if (event is ReliCBMonitorEventHubConnected) {
      yield ReliCBMonitorStateLoadingRequest(timestamp: event.timestamp);
      event.hubConnection.state == HubConnectionState.disconnected
          ? await event.hubConnection.start().onError((error, stackTrace) {
              count = 1;
              var e = error.toString();
              return e;
            })
          : await event.hubConnection.stop();
      if (event.hubConnection.state == HubConnectionState.disconnected &&
          count == 0) {
        yield ReliCBMonitorStateConnectFail(
            errorPackage: ErrorPackage(
                message: "Ngắt kết nối",
                detail: "Đã ngắt kết nối tới máy chủ"));
      } else if (event.hubConnection.state == HubConnectionState.disconnected &&
          count == 1) {
        yield ReliCBMonitorStateConnectFail(
            errorPackage: ErrorPackage(
                message: "Không thể kết nối tới máy chủ",
                detail: "vui lòng kiểm tra đường truyền"));
        count = 0;
      } else if (event.hubConnection.state == HubConnectionState.connected) {
        ReliCBMonitorData reliCBMonitorData = ReliCBMonitorData(
            alarm: false,
            running: false,
            soLanDongNapCaiDat: 0,
            soLanDongNapHienTai: 0,
            thoiGianGiuNapDong: 0,
            thoiGianGiuNapMo: 0);
        yield ReliCBMonitorStateConnectSucessful(
          reliCBMonitorData: reliCBMonitorData,
        );
      }
    } else if (event is ReliCBMonitorEventDataUpdated) {
      yield ReliCBMonitorStateDataUpdated(
          timestamp: DateTime.now(),
          reliCBMonitorData: event.reliCBMonitorData);
    } else if (event is ReliMonitorEventConnectFail) {
      yield ReliMonitorStateConnectFail(errorPackage: event.errorPackage);
    }

    //-----------------------------
  }
}
