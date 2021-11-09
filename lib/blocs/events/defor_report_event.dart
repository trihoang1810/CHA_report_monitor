import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class DeforReportEvent extends Equatable {}

class DeforBendingReportEventSearchingClicked extends DeforReportEvent {
  DateTime timestamp;
  DateTime startTime;
  DateTime stopTime;
  DeforBendingReportEventSearchingClicked(
      {this.startTime, this.stopTime, this.timestamp});
  @override
  List<Object> get props => [timestamp, startTime, stopTime];
}

class DeforBendingReportEventPickDateRange extends DeforReportEvent {
  BuildContext context;
  DateTime timestamp;
  DeforBendingReportEventPickDateRange({this.context, this.timestamp});
  @override
  List<Object> get props => [timestamp, context];
}

class DeforStaticReportEventSearchingClicked extends DeforReportEvent {
  DateTime startTime;
  DateTime stopTime;
  DateTime timestamp;
  DeforStaticReportEventSearchingClicked(
      {this.timestamp, this.startTime, this.stopTime});
  @override
  List<Object> get props => [timestamp, startTime, stopTime];
}

class DeforStaticReportEventPickDateRange extends DeforReportEvent {
  BuildContext context;
  DateTime timestamp;
  DeforStaticReportEventPickDateRange({this.context, this.timestamp});
  @override
  List<Object> get props => [timestamp, context];
}

class DeforRockReportEventSearchingClicked extends DeforReportEvent {
  DateTime timestamp;
  DateTime startTime;
  DateTime stopTime;
  DeforRockReportEventSearchingClicked(
      {this.startTime, this.stopTime, this.timestamp});
  @override
  List<Object> get props => [timestamp, startTime, stopTime];
}

class DeforRockReportEventPickDateRange extends DeforReportEvent {
  BuildContext context;
  DateTime timestamp;
  DeforRockReportEventPickDateRange({this.context, this.timestamp});
  @override
  List<Object> get props => [timestamp, context];
}
