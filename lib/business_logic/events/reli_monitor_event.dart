import 'package:equatable/equatable.dart';
import 'package:mobile_app/models/error_package.dart';
import 'package:mobile_app/models/reliability_cb_monitor_data.dart';
import 'package:mobile_app/models/reliability_monitor_data.dart';
import 'package:signalr_core/signalr_core.dart';

abstract class ReliMonitorEvent extends Equatable {}

//---------------------------------------------------
class ReliMonitorEventHubConnected extends ReliMonitorEvent {
  DateTime timestamp;
  HubConnection hubConnection;
  ReliMonitorEventHubConnected({this.hubConnection, this.timestamp});
  @override
  List<Object> get props => [timestamp, hubConnection];
}

class ReliMonitorEventDataUpdated extends ReliMonitorEvent {
  DateTime timestamp;
  ReliMonitorData reliMonitorData;
  ReliMonitorEventDataUpdated({this.timestamp, this.reliMonitorData});
  @override
  List<Object> get props => [timestamp, reliMonitorData];
}

//---------------------------------------------------
class ReliCBMonitorEventHubConnected extends ReliMonitorEvent {
  DateTime timestamp;
  HubConnection hubConnection;
  ReliCBMonitorEventHubConnected({this.hubConnection, this.timestamp});
  @override
  List<Object> get props => [timestamp, hubConnection];
}

class ReliCBMonitorEventDataUpdated extends ReliMonitorEvent {
  DateTime timestamp;
  ReliCBMonitorData reliCBMonitorData;
  ReliCBMonitorEventDataUpdated({this.timestamp, this.reliCBMonitorData});
  @override
  List<Object> get props => [timestamp, reliCBMonitorData];
}
class ReliMonitorEventConnectFail extends ReliMonitorEvent {
  ErrorPackage errorPackage;
  ReliMonitorEventConnectFail({this.errorPackage});
  @override
  List<Object> get props => [errorPackage];
}