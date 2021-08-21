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
  bool warning;
  bool running;
  ReliMonitorStateInit(
      {this.timestamp,
      this.data1,
      this.data2,
      this.data3,
      this.data4,
      this.running,
      this.warning});

  @override
  // TODO: implement props
  List<Object> get props =>
      [timestamp, data1, data2, data3, data4, running, warning];
}

class ReliMonitorStateLoadingRequest extends ReliMonitorState {
  DateTime timestamp;
  ReliMonitorStateLoadingRequest({this.timestamp});

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

//------------------------------
class ReliMonitorStateConnectSucessful extends ReliMonitorState {
  DateTime timestamp;
  ReliMonitorData reliMonitorData;
  ReliMonitorStateConnectSucessful({this.reliMonitorData, this.timestamp});
  @override
  List<Object> get props => [timestamp, reliMonitorData];
}

class ReliMonitorStateConnectFail extends ReliMonitorState {
  DateTime timestamp;
  ErrorPackage errorPackage;
  ReliMonitorStateConnectFail({this.timestamp, this.errorPackage});
  @override
  List<Object> get props => [timestamp, errorPackage];
}

class ReliMonitorStateDataUpdated extends ReliMonitorState {
  DateTime timestamp;
  ReliMonitorData reliMonitorData;
  ReliMonitorStateDataUpdated({this.reliMonitorData, this.timestamp});
  @override
  List<Object> get props => [timestamp, reliMonitorData];
}

//----------------------------------------
class ReliCBMonitorStateConnectSucessful extends ReliMonitorState {
  DateTime timestamp;
  ReliCBMonitorData reliCBMonitorData;
  ReliCBMonitorStateConnectSucessful({this.reliCBMonitorData, this.timestamp});
  @override
  List<Object> get props => [timestamp, reliCBMonitorData];
}

class ReliCBMonitorStateConnectFail extends ReliMonitorState {
  DateTime timestamp;
  ErrorPackage errorPackage;
  ReliCBMonitorStateConnectFail({this.timestamp, this.errorPackage});
  @override
  List<Object> get props => [timestamp, errorPackage];
}

class ReliCBMonitorStateDataUpdated extends ReliMonitorState {
  DateTime timestamp;
  ReliCBMonitorData reliCBMonitorData;
  ReliCBMonitorStateDataUpdated({this.reliCBMonitorData, this.timestamp});
  @override
  List<Object> get props => [timestamp, reliCBMonitorData];
}
