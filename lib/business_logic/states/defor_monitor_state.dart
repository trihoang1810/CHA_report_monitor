import 'package:equatable/equatable.dart';
import 'package:mobile_app/models/deformation_monitor_data.dart';
import 'package:mobile_app/models/error_package.dart';

abstract class DeforMonitorState extends Equatable {}

class Defor12MonitorStateInit extends DeforMonitorState {
  DateTime timestamp;
  String data1;
  String data2;
  String data3;
  String data4;
  Defor12MonitorStateInit(
      {this.timestamp, this.data1, this.data2, this.data3, this.data4});
  @override
  // TODO: implement props
  List<Object> get props => [timestamp, data1, data2, data3, data4];
}

class Defor12MonitorStateLoadingRequest extends DeforMonitorState {
  DateTime timestamp;
  Defor12MonitorStateLoadingRequest({this.timestamp});
  @override
  List<Object> get props => [timestamp];
}

class Defor12MonitorStateLoadingSuccessful extends DeforMonitorState {
  DateTime timestamp;
  DeforMonitorData deforMonitorData;
  Defor12MonitorStateLoadingSuccessful({this.deforMonitorData});
  @override
  List<Object> get props => [timestamp, deforMonitorData];
}

class Defor12MonitorStateRefetchSuccessful extends DeforMonitorState {
  DeforMonitorData deforMonitorData;
  DateTime timestamp;
  Defor12MonitorStateRefetchSuccessful({this.deforMonitorData});
  @override
  List<Object> get props => [timestamp, deforMonitorData];
}

class Defor12MonitorStateLoadingFail extends DeforMonitorState {
  DateTime timestamp;
  ErrorPackage errorPackage;
  Defor12MonitorStateLoadingFail({this.errorPackage, this.timestamp});
  @override
  List<Object> get props => [timestamp, errorPackage];
}

class Defor12MonitorStateRefetchFail extends DeforMonitorState {
  DateTime timestamp;
  ErrorPackage errorPackage;
  Defor12MonitorStateRefetchFail({this.errorPackage, this.timestamp});
  @override
  List<Object> get props => [timestamp, errorPackage];
}

class Defor12MonitorStateCancelRefetch extends DeforMonitorState {
  DateTime timestamp;
  Defor12MonitorStateCancelRefetch({this.timestamp});
  @override
  List<Object> get props => [timestamp];
}
