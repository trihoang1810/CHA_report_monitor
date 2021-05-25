import 'package:equatable/equatable.dart';

abstract class ReliMonitorEvent extends Equatable {}

class ReliMonitorEventSearchingClicked extends ReliMonitorEvent {
  DateTime timestamp;
  ReliMonitorEventSearchingClicked({this.timestamp});
  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}
