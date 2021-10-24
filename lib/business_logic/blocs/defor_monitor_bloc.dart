import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/business_logic/events/defor_monitor_event.dart';
import 'package:mobile_app/business_logic/states/defor_monitor_state.dart';
import 'package:mobile_app/models/deformation_monitor_data.dart';
import 'package:mobile_app/models/error_package.dart';
import 'package:signalr_core/signalr_core.dart';

class DeforMonitorBloc extends Bloc<DeforMonitorEvent, DeforMonitorState> {
  DeforMonitorBloc()
      : super(Defor12MonitorStateInit(
          timestamp: DateTime.now(),
          data: "0",
        ));

  @override
  Stream<DeforMonitorState> mapEventToState(DeforMonitorEvent event) async* {
    if (event is DeforMonitorEventHubConnected) {
      yield Defor12MonitorStateLoadingRequest();
      event.hubConnection.state == HubConnectionState.disconnected
          ? await event.hubConnection.start().onError((error, stackTrace) {
              return DeforMonitorBloc().add(DeforMonitorEventConnectFail(
                  errorPackage: ErrorPackage(
                      message: "Không thể kết nối tới máy chủ",
                      detail: "vui lòng kiểm tra đường truyền")));
            })
          : await event.hubConnection.stop();
      if (event.hubConnection.state == HubConnectionState.disconnected) {
        print(event.hubConnection.state);
        yield DeforMonitorStateConnectFail(
            errorPackage: ErrorPackage(
                message: "Ngắt kết nối",
                detail: "Đã ngắt kết nối tới máy chủ"));
      } else if (event.hubConnection.state == HubConnectionState.connected) {
        print(event.hubConnection.state);

        yield DeforMonitorStateConnectSuccessful(
            deforMonitorData: DeforMonitorData(
                errorCode: 0,
                noPressPv1: 0,
                noPressPv2: 0,
                noPressPv3: 0,
                noPressSp12: 0,
                noPressSp3: 0,
                modeStatus: 0,
                forceCylinderSp12: "0",
                forceCylinderSp3: "0",
                timeHoldSp12: "0",
                timeHoldSp3: "0",
                seclect1: false,
                seclect2: false,
                redStatus: false,
                greenStatus: false,
                errorStatus: false));
      }
    } else if (event is DeforMonitorEventDataUpdated) {
      yield DeforMonitorStateDataUpdated(
          deforMonitorData: event.deforMonitorData);
    } else if (event is DeforMonitorEventConnectFail) {
      yield DeforMonitorStateConnectFail(errorPackage: event.errorPackage);
    }
  }
}
