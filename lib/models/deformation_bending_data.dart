import 'package:equatable/equatable.dart';

class DeforBendingReport extends Equatable {
  String nume;
  int id;
  String taitrong;
  String time;
  String dcv;
  String tongloi;
  String nxet;
  String nvkt;

  DeforBendingReport(
      {this.nume,
      this.id,
      this.taitrong,
      this.time,
      this.dcv,
      this.tongloi,
      this.nxet,
      this.nvkt});
  @override
  List<Object> get props => [
        this.nume,
        this.id,
        this.taitrong,
        this.dcv,
        this.time,
        this.tongloi,
        this.nxet,
        this.nvkt
      ];

  factory DeforBendingReport.fromJson(Map<String, dynamic> json) {
    return DeforBendingReport(
      nume: json['num'],
      id: json['id'],
      taitrong: json['taitrong'],
      time: json['time'],
      dcv: json['dcv'],
      tongloi: json['tongloi'],
      nxet: json['nxet'],
      nvkt: json['nvkt'],
    );
  }
}
