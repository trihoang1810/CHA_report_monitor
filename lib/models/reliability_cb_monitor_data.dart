import 'package:equatable/equatable.dart';

class ReliCBMonitorData extends Equatable {
  ReliCBMonitorData({
    this.thoiGianGiuNapMo,
    this.thoiGianGiuNapDong,
    this.soLanDongNapHienTai,
    this.soLanDongNapCaiDat,
    this.alarm,
    this.running,
  });

  int soLanDongNapCaiDat;
  int soLanDongNapHienTai;
  int thoiGianGiuNapDong;
  int thoiGianGiuNapMo;
  bool alarm;
  bool running;
  @override
  List<Object> get props => [
        soLanDongNapCaiDat,
        soLanDongNapHienTai,
        thoiGianGiuNapDong,
        thoiGianGiuNapMo,
        alarm,
        running,
      ];
  factory ReliCBMonitorData.fromJson(Map<String, dynamic> json) =>
      ReliCBMonitorData(
        soLanDongNapCaiDat: json["soLanDongNapCaiDat"],
        soLanDongNapHienTai: json["soLanDongNapHienTai"],
        thoiGianGiuNapDong: json["thoiGianGiuNapDong"],
        thoiGianGiuNapMo: json["thoiGianGiuNapMo"],
        alarm: json["alarm"],
        running: json["running"],
      );
}