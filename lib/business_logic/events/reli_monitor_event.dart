import 'package:equatable/equatable.dart';

abstract class ReliMonitorEvent extends Equatable {}

class ReliMonitorEventSearchingClicked extends ReliMonitorEvent {
  DateTime timestamp;
  ReliMonitorEventSearchingClicked({this.timestamp});
  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}

class ReliMonitorEventRefetchData extends ReliMonitorEvent {
  DateTime timestamp;
  ReliMonitorEventRefetchData({this.timestamp});
  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}

class ReliMonitorEventCancelRefetchData extends ReliMonitorEvent {
  DateTime timestamp;
  ReliMonitorEventCancelRefetchData({this.timestamp});
  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}

class ReliCBMonitorEventSearchingClicked extends ReliMonitorEvent {
  DateTime timestamp;
  ReliCBMonitorEventSearchingClicked({this.timestamp});
  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}

class ReliCBMonitorEventRefetchData extends ReliMonitorEvent {
  DateTime timestamp;
  ReliCBMonitorEventRefetchData({this.timestamp});
  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}

class ReliCBMonitorEventCancelRefetchData extends ReliMonitorEvent {
  DateTime timestamp;
  ReliCBMonitorEventCancelRefetchData({this.timestamp});
  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}
