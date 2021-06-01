import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ReliReportEvent extends Equatable {}

// ignore: must_be_immutable
class ReliReportEventSearchingClicked extends ReliReportEvent {
  DateTime startTime;
  DateTime stopTime;
  DateTime timestamp;
  ReliReportEventSearchingClicked(
      {this.timestamp, this.startTime, this.stopTime});
  @override
  List<Object> get props => [startTime, stopTime, timestamp];
}

class ReliReportEventPickDateRange extends ReliReportEvent {
  BuildContext context;
  DateTime timestamp;
  ReliReportEventPickDateRange({this.context,this.timestamp});
  @override
  List<Object> get props => [timestamp,context];
}

class ReliCBReportEventSearchingClicked extends ReliReportEvent {
  DateTime timestamp;
  ReliCBReportEventSearchingClicked({this.timestamp});
  @override
  List<Object> get props => [timestamp];
}
