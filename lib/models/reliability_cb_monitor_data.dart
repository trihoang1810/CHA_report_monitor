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
        soLanDongNapCaiDat: json["numberClosingSp"],
        soLanDongNapHienTai: json["numberClosingPv"],
        thoiGianGiuNapDong: json["timeLidClose"],
        thoiGianGiuNapMo: json["timeLidOpen"],
        alarm: json["alarm"],
        running: json["running"],
      );
}
