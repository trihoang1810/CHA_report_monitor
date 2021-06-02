import 'package:equatable/equatable.dart';

class ReliMonitorData extends Equatable {
  ReliMonitorData({
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
  factory ReliMonitorData.fromJson(Map<String, dynamic> json) =>
      ReliMonitorData(
        soLanDongNapCaiDat: json["soLanDongNapCaiDat"],
        soLanDongNapHienTai: json["soLanDongNapHienTai"],
        thoiGianGiuNapDong: json["thoiGianGiuNapDong"],
        thoiGianGiuNapMo: json["thoiGianGiuNapMo"],
        alarm: json["alarm"],
        running: json["running"],
      );
}
