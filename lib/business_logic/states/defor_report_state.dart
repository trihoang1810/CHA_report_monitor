import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/models/deformation_bending_data.dart';
import 'package:mobile_app/models/deformation_rocktest_data.dart';
import 'package:mobile_app/models/deformation_staticload_data.dart';
import 'package:mobile_app/models/error_package.dart';

abstract class DeforReportState extends Equatable {}

//bending_force_state
class DeforBendingReportStateLoadingRequest extends DeforReportState {
  DateTime timestamp;
  DeforBendingReportStateLoadingRequest({this.timestamp});

  @override
  List<Object> get props => [timestamp];
}

class DeforBendingReportStateInit extends DeforReportState {
  DateTime timestamp;
  DeforBendingReportStateInit({this.timestamp});

  @override
  List<Object> get props => [timestamp];
}

class DeforBendingReportStateLoadingSuccessful extends DeforReportState {
  DateTime timestamp;
  DeforBendingReport deforBendingReport;
  DeforBendingReportStateLoadingSuccessful(
      {this.deforBendingReport, this.timestamp});

  @override
  List<Object> get props => [timestamp];
}

class DeforBendingReportStateLoadingFailure extends DeforReportState {
  DateTime timestamp;
  ErrorPackage errorPackage;
  DeforBendingReportStateLoadingFailure({this.timestamp, this.errorPackage});

  @override
  List<Object> get props => [timestamp];
}

class DeforBendingReportStatePickDateRange extends DeforReportState {
  DateTime timestamp;
  String getFrom = "Từ ngày";
  String getUntil = "Đến ngày";
  DateTimeRange dateRange;
  DeforBendingReportStatePickDateRange(
      {this.dateRange, this.timestamp, this.getFrom, this.getUntil});
  @override
  // TODO: implement props
  List<Object> get props => [timestamp, getFrom, getUntil, dateRange];
}

//static_load_state
class DeforStaticReportStateLoadingRequest extends DeforReportState {
  DateTime timestamp;
  DeforStaticReportStateLoadingRequest({this.timestamp});

  @override
  List<Object> get props => [timestamp];
}

class DeforStaticReportStateInit extends DeforReportState {
  DateTime timestamp;
  DeforStaticReportStateInit({this.timestamp});

  @override
  List<Object> get props => [timestamp];
}

class DeforStaticReportStateLoadingSuccessful extends DeforReportState {
  DateTime timestamp;
  DeforStaticReport deforStaticReport;
  DeforStaticReportStateLoadingSuccessful(
      {this.deforStaticReport, this.timestamp});

  @override
  List<Object> get props => [timestamp, deforStaticReport];
}

class DeforStaticReportStateLoadingFailure extends DeforReportState {
  DateTime timestamp;
  ErrorPackage errorPackage;
  DeforStaticReportStateLoadingFailure({this.timestamp, this.errorPackage});

  @override
  List<Object> get props => [timestamp, errorPackage];
}

class DeforStaticReportStatePickDateRange extends DeforReportState {
  DateTime timestamp;
  String getFrom = "Từ ngày";
  String getUntil = "Đến ngày";
  DateTimeRange dateRange;
  DeforStaticReportStatePickDateRange(
      {this.dateRange, this.timestamp, this.getFrom, this.getUntil});
  @override
  // TODO: implement props
  List<Object> get props => [timestamp, getFrom, getUntil, dateRange];
}

//rock_test_state
class DeforRockReportStateLoadingRequest extends DeforReportState {
  DateTime timestamp;
  DeforRockReportStateLoadingRequest({this.timestamp});

  @override
  List<Object> get props => [timestamp];
}

class DeforRockReportStateInit extends DeforReportState {
  DateTime timestamp;
  DeforRockReportStateInit({this.timestamp});

  @override
  List<Object> get props => [timestamp];
}

class DeforRockReportStateLoadingSuccessful extends DeforReportState {
  DateTime timestamp;
  DeforRockReport deforRockReport;
  DeforRockReportStateLoadingSuccessful(
      {this.deforRockReport, this.timestamp});

  @override
  List<Object> get props => [timestamp];
}

class DeforRockReportStateLoadingFailure extends DeforReportState {
  DateTime timestamp;
  ErrorPackage errorPackage;
  DeforRockReportStateLoadingFailure({this.timestamp, this.errorPackage});

  @override
  List<Object> get props => [timestamp];
}

class DeforRockReportStatePickDateRange extends DeforReportState {
  DateTime timestamp;
  String getFrom = "Từ ngày";
  String getUntil = "Đến ngày";
  DateTimeRange dateRange;
  DeforRockReportStatePickDateRange(
      {this.dateRange, this.timestamp, this.getFrom, this.getUntil});
  @override
  // TODO: implement props
  List<Object> get props => [timestamp, getFrom, getUntil, dateRange];
}
