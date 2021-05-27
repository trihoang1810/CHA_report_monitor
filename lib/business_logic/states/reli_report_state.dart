import 'package:equatable/equatable.dart';
import 'package:mobile_app/models/error_package.dart';
import 'package:mobile_app/models/reliability_data.dart';

abstract class ReliReportState extends Equatable {}

class ReliReportStateLoadingRequest extends ReliReportState {
  DateTime timestamp;
  ReliReportStateLoadingRequest({this.timestamp});
  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
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

class ReliCBReportStateLoadingRequest extends ReliReportState {
  DateTime timestamp;
  ReliCBReportStateLoadingRequest({this.timestamp});
  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}

class ReliCBReportStateInit extends ReliReportState {
  DateTime timestamp;
  ReliCBReportStateInit({this.timestamp});
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
