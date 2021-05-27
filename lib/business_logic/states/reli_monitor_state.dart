import 'package:equatable/equatable.dart';
import 'package:mobile_app/models/error_package.dart';
import 'package:mobile_app/models/reliability_cb_monitor_data.dart';
import 'package:mobile_app/models/reliability_monitor_data.dart';

abstract class ReliMonitorState extends Equatable {}

class ReliMonitorStateInit extends ReliMonitorState {
  DateTime timestamp;
  String data1;
  String data2;
  String data3;
  String data4;
  ReliMonitorStateInit(
      {this.timestamp, this.data1, this.data2, this.data3, this.data4});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}

class ReliMonitorStateLoadingRequest extends ReliMonitorState {
  DateTime timestamp;
  ReliMonitorStateLoadingRequest({this.timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}

class ReliMonitorStateLoadingSuccessful extends ReliMonitorState {
  DateTime timestamp;
  ReliMonitorData reliMonitorData;
  ReliMonitorStateLoadingSuccessful({this.reliMonitorData, this.timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp, reliMonitorData];
}

class ReliMonitorStateLoadingFailure extends ReliMonitorState {
  DateTime timestamp;
  ErrorPackage errorPackage;
  ReliMonitorStateLoadingFailure({errorPackage, timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [errorPackage, timestamp];
}

//--------------------------------------------------------------------
class ReliCBMonitorStateInit extends ReliMonitorState {
  DateTime timestamp;
  String data1;
  String data2;
  String data3;
  String data4;
  ReliCBMonitorStateInit(
      {this.timestamp, this.data1, this.data2, this.data3, this.data4});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}

class ReliCBMonitorStateLoadingRequest extends ReliMonitorState {
  DateTime timestamp;
  ReliCBMonitorStateLoadingRequest({this.timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}

class ReliCBMonitorStateLoadingSuccessful extends ReliMonitorState {
  DateTime timestamp;
  ReliCBMonitorData reliCBMonitorData;
  ReliCBMonitorStateLoadingSuccessful({this.reliCBMonitorData, this.timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp, reliCBMonitorData];
}

class ReliCBMonitorStateLoadingFailure extends ReliMonitorState {
  DateTime timestamp;
  ErrorPackage errorPackage;
  ReliCBMonitorStateLoadingFailure({errorPackage, timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [errorPackage, timestamp];
}
