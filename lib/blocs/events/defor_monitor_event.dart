import 'package:equatable/equatable.dart';
import 'package:mobile_app/model/deformation_monitor_data.dart';
import 'package:mobile_app/model/error_package.dart';
import 'package:signalr_core/signalr_core.dart';

abstract class DeforMonitorEvent extends Equatable {}

//-----------------------------------------------
class DeforMonitorEventHubConnected extends DeforMonitorEvent {
  DateTime timestamp;
  HubConnection hubConnection;
  DeforMonitorEventHubConnected({this.hubConnection, this.timestamp});
  @override
  List<Object> get props => [timestamp, hubConnection];
}

class DeforMonitorEventDataUpdated extends DeforMonitorEvent {
  DateTime timestamp;
  DeforMonitorData deforMonitorData;
  DeforMonitorEventDataUpdated({this.timestamp, this.deforMonitorData});
  @override
  List<Object> get props => [timestamp, deforMonitorData];
}

class DeforMonitorEventConnectFail extends DeforMonitorEvent {
  ErrorPackage errorPackage;
  DeforMonitorEventConnectFail({this.errorPackage});
  @override
  List<Object> get props => [errorPackage];
}
