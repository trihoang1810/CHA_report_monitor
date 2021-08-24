import 'package:equatable/equatable.dart';
import 'package:mobile_app/models/deformation_monitor_data.dart';
import 'package:mobile_app/models/error_package.dart';

abstract class DeforMonitorState extends Equatable {}

class Defor12MonitorStateInit extends DeforMonitorState {
  DateTime timestamp;
  String data;
  Defor12MonitorStateInit({this.timestamp, this.data});
  @override
  // TODO: implement props
  List<Object> get props => [timestamp, data];
}

class Defor12MonitorStateLoadingRequest extends DeforMonitorState {
  DateTime timestamp;
  Defor12MonitorStateLoadingRequest({this.timestamp});
  @override
  List<Object> get props => [timestamp];
}

//----------------------------------------------
class DeforMonitorStateConnectSuccessful extends DeforMonitorState {
  DateTime timestamp;
  DeforMonitorData deforMonitorData;
  DeforMonitorStateConnectSuccessful({this.deforMonitorData, this.timestamp});
  @override
  List<Object> get props => [timestamp, deforMonitorData];
}

class DeforMonitorStateConnectFail extends DeforMonitorState {
  ErrorPackage errorPackage;
  DeforMonitorStateConnectFail({this.errorPackage});
  @override
  List<Object> get props => [errorPackage];
}

class DeforMonitorStateDataUpdated extends DeforMonitorState {
  DeforMonitorData deforMonitorData;
  DeforMonitorStateDataUpdated({this.deforMonitorData});
  @override
  List<Object> get props => [deforMonitorData];
}
