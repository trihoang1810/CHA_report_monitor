import 'package:equatable/equatable.dart';

abstract class DeforMonitorEvent extends Equatable {}

class Defor1MonitorEventSearchingClicked extends DeforMonitorEvent {
  DateTime timestamp;
  Defor1MonitorEventSearchingClicked({this.timestamp});
  @override
  List<Object> get props => [timestamp];
}

class Defor1MonitorEventRefetchData extends DeforMonitorEvent {
  DateTime timestamp;
  Defor1MonitorEventRefetchData({this.timestamp});
  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}

class Defor1MonitorEventCancelRefetchData extends DeforMonitorEvent {
  DateTime timestamp;
  Defor1MonitorEventCancelRefetchData({this.timestamp});
  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}
