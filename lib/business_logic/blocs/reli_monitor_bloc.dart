import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/business_logic/events/reli_monitor_event.dart';
import 'package:mobile_app/business_logic/states/reli_monitor_state.dart';
import 'package:mobile_app/models/error_package.dart';
import 'package:mobile_app/models/reliability_cb_monitor_data.dart';
import 'package:mobile_app/models/reliability_monitor_data.dart';
import 'package:signalr_core/signalr_core.dart';

class ReliMonitorBloc extends Bloc<ReliMonitorEvent, ReliMonitorState> {
  StreamSubscription _periodicSubscription;
  StreamSubscription _periodicSubscription1;
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
    //-------------------

    if (event is ReliMonitorEventHubConnected) {
      yield ReliMonitorStateLoadingRequest(timestamp: event.timestamp);
      event.hubConnection.state == HubConnectionState.disconnected
          ? await event.hubConnection.start().onError((error, stackTrace) {
              var e = error.toString();
              return e;
            })
          : await event.hubConnection.stop();
      if (event.hubConnection.state == HubConnectionState.disconnected) {
        yield ReliMonitorStateConnectFail(
            timestamp: event.timestamp,
            errorPackage: ErrorPackage(
                message: "Ngắt kết nối",
                detail: "Đã ngắt kết nối tới máy chủ"));
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
              var e = error.toString();
              return e;
            })
          : await event.hubConnection.stop();
      if (event.hubConnection.state == HubConnectionState.disconnected) {
        yield ReliCBMonitorStateConnectFail(
            timestamp: event.timestamp,
            errorPackage: ErrorPackage(
                message: "Ngắt kết nối",
                detail: "Đã ngắt kết nối tới máy chủ"));
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
    }

    //-----------------------------
  }

  @override
  Future<void> close() async {
    await _periodicSubscription?.cancel();
    _periodicSubscription = null;
    await _periodicSubscription1?.cancel();
    _periodicSubscription1 = null;
    return super.close();
  }
}
