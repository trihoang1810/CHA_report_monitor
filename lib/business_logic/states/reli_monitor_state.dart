import 'package:equatable/equatable.dart';
import 'package:mobile_app/models/error_package.dart';
import 'package:mobile_app/models/reliability_monitor_data.dart';

abstract class ReliMonitorState extends Equatable {}

class ReliMonitorStateInit extends ReliMonitorState {
  DateTime timestamp;
  ReliMonitorStateInit({this.timestamp});

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
