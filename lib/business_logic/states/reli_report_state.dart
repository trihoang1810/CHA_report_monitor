import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/models/error_package.dart';
import 'package:mobile_app/models/reliability_data.dart';

abstract class ReliReportState extends Equatable {}

//đóng êm
class ReliReportStateLoadingRequest extends ReliReportState {
  DateTime timestamp;
  ReliReportStateLoadingRequest({this.timestamp});
  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}

class ReliReportStatePickDateRange extends ReliReportState {
  //mở screen lịch và mình phải chọn
  DateTime timestamp;
  String getFrom = "Từ ngày";
  String getUntil = "Đến ngày";
  DateTimeRange dateRange;
  ReliReportStatePickDateRange(
      {this.dateRange, this.timestamp, this.getFrom, this.getUntil});
  @override
  // TODO: implement props
  List<Object> get props => [timestamp, getFrom, getUntil, dateRange];
}

class ReliReportStateInit extends ReliReportState {
  DateTime timestamp;
  ReliReportStateInit({this.timestamp});
  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}


class ReliReportStateLoadingSuccessful extends ReliReportState {
  DateTime timestamp;
  ReliReport reliReport;
  ReliReportStateLoadingSuccessful({this.reliReport, this.timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}

class ReliReportStateLoadingFailure extends ReliReportState {
  DateTime timestamp;
  ErrorPackage errorPackage;
  ReliReportStateLoadingFailure({this.timestamp, this.errorPackage});
  @override
  List<Object> get props => [timestamp];
}

//------cưỡng bức
class ReliCBReportStateLoadingRequest extends ReliReportState {
  DateTime timestamp;
  ReliCBReportStateLoadingRequest({this.timestamp});
  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}


class ReliCBReportStateLoadingSuccessful extends ReliReportState {
  DateTime timestamp;
  ReliReport reliReport;
  ReliCBReportStateLoadingSuccessful({this.reliReport, this.timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}

class ReliCBReportStateLoadingFailure extends ReliReportState {
  DateTime timestamp;
  ErrorPackage errorPackage;
  ReliCBReportStateLoadingFailure({this.timestamp, this.errorPackage});
  @override
  List<Object> get props => [timestamp];
}

class ReliCBReportStatePickDateRange extends ReliReportState {
  DateTime timestamp;
  String getFrom = "Từ ngày";
  String getUntil = "Đến ngày";
  DateTimeRange dateRange;
  ReliCBReportStatePickDateRange(
      {this.dateRange, this.timestamp, this.getFrom, this.getUntil});
  @override
  // TODO: implement props
  List<Object> get props => [timestamp, getFrom, getUntil, dateRange];
}
