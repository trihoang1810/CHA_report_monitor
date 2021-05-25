import 'package:equatable/equatable.dart';

class DeforStaticReport extends Equatable {
  String nume;
  String name;
  int id;
  String status;
  String total;
  String comment;
  String employee;

  DeforStaticReport({
    this.nume,
    this.name,
    this.id,
    this.status,
    this.total,
    this.comment,
    this.employee,
  });
  @override
  List<Object> get props => [
        this.nume,
        this.name,
        this.id,
        this.status,
        this.total,
        this.comment,
        this.employee,
      ];

  factory DeforStaticReport.fromJson(Map<String, dynamic> json) =>
      DeforStaticReport(
        nume: json["nume"],
        name: json["name"],
        id: json["id"],
        status: json["status"],
        total: json["total"],
        comment: json["comment"],
        employee: json["employee"],
      );
}
