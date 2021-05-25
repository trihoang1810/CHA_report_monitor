import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ReliCBReport extends Equatable {
  String id;
  String timestamp;
  String name;
  String first;
  String last;
  String trytime;
  String time;

  ReliCBReport(
      {this.id,
      this.timestamp,
      this.name,
      this.first,
      this.last,
      this.trytime,
      this.time});

  @override
  // TODO: implement props
  List<Object> get props =>
      [this.first, this.id, this.last, this.name, this.time, this.timestamp];
  factory ReliCBReport.fromJson(Map<String, dynamic> json) {
    return ReliCBReport(
      id: json['id'],
      timestamp: json['timestamp'],
      name: json['name'],
      first: json['first'],
      last: json['last'],
      trytime: json['trytime'],
      time: json['time'],
    );
  }
}
