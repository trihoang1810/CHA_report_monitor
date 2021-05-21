import 'package:equatable/equatable.dart';

abstract class ReliReportEvent extends Equatable {}

// ignore: must_be_immutable
class ReliReportEventSearchingClicked extends ReliReportEvent {
  DateTime timestamp;
  @override
  List<Object> get props => [timestamp];
}
