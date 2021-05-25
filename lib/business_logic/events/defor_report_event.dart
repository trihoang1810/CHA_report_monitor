import 'package:equatable/equatable.dart';

abstract class DeforReportEvent extends Equatable {}

class DeforBendingReportEventSearchingClicked extends DeforReportEvent {
  DateTime timestamp;
  @override
  List<Object> get props => [timestamp];
}

class DeforStaticReportEventSearchingClicked extends DeforReportEvent {
  DateTime timestamp;
  @override
  List<Object> get props => [timestamp];
}

class DeforRockReportEventSearchingClicked extends DeforReportEvent {
  DateTime timestamp;
  @override
  List<Object> get props => [timestamp];
}
