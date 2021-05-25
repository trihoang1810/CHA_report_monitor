import 'package:equatable/equatable.dart';

class DeforRockReport extends Equatable {
  DeforRockReport(
      {this.nume,
      this.name,
      this.weight,
      this.trytime,
      this.result,
      this.total,
      this.comment,
      this.employee,
      this.id});

  String nume;
  String name;
  String weight;
  String trytime;
  String result;
  String total;
  String comment;
  String employee;
  int id;
  @override
  // TODO: implement props
  List<Object> get props => throw [
        this.nume,
        this.name,
        this.weight,
        this.trytime,
        this.result,
        this.total,
        this.comment,
        this.employee,
        this.id
      ];

  factory DeforRockReport.fromJson(Map<String, dynamic> json) =>
      DeforRockReport(
        nume: json["nume"],
        name: json["name"],
        weight: json["weight"],
        trytime: json["trytime"],
        result: json["result"],
        total: json["total"],
        comment: json["comment"],
        employee: json["employee"],
        id: json["id"],
      );
}
