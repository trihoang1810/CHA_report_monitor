import 'package:equatable/equatable.dart';
import 'package:mobile_app/Presentation/Models/error_package.dart';
import 'package:mobile_app/presentation/models/reliability_data.dart';

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
