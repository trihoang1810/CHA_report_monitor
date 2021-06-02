import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
// class ReliCBReport extends Equatable {
//   String id;
//   String timestamp;
//   String name;
//   String first;
//   String last;
//   String trytime;
//   String time;

//   ReliCBReport(
//       {this.id,
//       this.timestamp,
//       this.name,
//       this.first,
//       this.last,
//       this.trytime,
//       this.time});

//   @override
//   // TODO: implement props
//   List<Object> get props =>
//       [this.first, this.id, this.last, this.name, this.time, this.timestamp];
//   factory ReliCBReport.fromJson(Map<String, dynamic> json) {
//     return ReliCBReport(
//       id: json['id'],
//       timestamp: json['timestamp'],
//       name: json['name'],
//       first: json['first'],
//       last: json['last'],
//       trytime: json['trytime'],
//       time: json['time'],
//     );
//   }
// }
// ignore: must_be_immutable
// class ReliReport extends Equatable {
//   String id;
//   String timestamp;
//   String name;
//   String first;
//   String last;
//   String trytime;
//   String time;

//   ReliReport(
//       {this.id,
//       this.timestamp,
//       this.name,
//       this.first,
//       this.last,
//       this.trytime,
//       this.time});

//   @override
//   // TODO: implement props
//   List<Object> get props =>
//       [this.first, this.id, this.last, this.name, this.time, this.timestamp];
//   factory ReliReport.fromJson(Map<String, dynamic> json) {
//     return ReliReport(
//         id: json['id'],
//         timestamp: json['timestamp'],
//         name: json['name'],
//         first: json['first'],
//         last: json['last'],
//         trytime: json['trytime'],
//         time: json['time']);
//   }
// }
//-------------------------------------------------------------------------------
class MyReliCBReportView {
  int id;
  int soLanThu;
  String ngayBatDau;
  String ngayKetThuc;
  String tenSanPham;
  String thoiGianDongEmNap;
  MyReliCBReportView(
      {this.soLanThu,
      this.id,
      this.ngayBatDau,
      this.ngayKetThuc,
      this.tenSanPham,
      this.thoiGianDongEmNap});
}

class ReliCBReport {
  ReliCBReport({
    this.items,
    this.totalItems,
  });

  List<ItemCB> items = [];
  int totalItems;

  factory ReliCBReport.fromJson(dynamic jsonObject) {
    List<ItemCB> listItems = [];
    List items = jsonObject["items"];
    for (var items in items) {
      ItemCB item = ItemCB.fromJson(items);
      listItems.add(item);
    }
    return ReliCBReport(items: listItems, totalItems: jsonObject["totalItems"]);
  }
}

class ItemCB {
  ItemCB({
    this.id,
    this.mucDichKiemTra,
    this.ngayBatDau,
    this.ngayKetThuc,
    this.maSanPham,
    this.sanPham,
    this.tieuChuanThuNghiem,
    this.mauKiemTraDongCuongBuc,
  });

  int id;
  String mucDichKiemTra;
  DateTime ngayBatDau;
  DateTime ngayKetThuc;
  String maSanPham;
  SanPhamCB sanPham;
  String tieuChuanThuNghiem;
  List<MauKiemTraDongCuongBuc> mauKiemTraDongCuongBuc = [];

  factory ItemCB.fromJson(dynamic json) {
    List<MauKiemTraDongCuongBuc> mauKiemTraDongCuongBuc = [];
    List items = json["mauKiemTraDongCuongBuc"];
    for (var item in items) {
      MauKiemTraDongCuongBuc giKiemTraDongCuongBuc =
          MauKiemTraDongCuongBuc.fromJson(item);
      mauKiemTraDongCuongBuc.add(giKiemTraDongCuongBuc);
    }
    return ItemCB(
      id: json["id"],
      mucDichKiemTra: json["mucDichKiemTra"],
      ngayBatDau: DateTime.parse(json["ngayBatDau"]),
      ngayKetThuc: DateTime.parse(json["ngayKetThuc"]),
      maSanPham: json["maSanPham"],
      sanPham: SanPhamCB.fromJson(json["sanPham"]),
      tieuChuanThuNghiem: json["tieuChuanThuNghiem"],
      mauKiemTraDongCuongBuc: mauKiemTraDongCuongBuc,
    );
  }
}

class MauKiemTraDongCuongBuc {
  MauKiemTraDongCuongBuc({
    this.phieuKtDongCuongBucId,
    this.soLanThu,
    this.thoiGianDongEmNap,
    this.napKhongNutVo,
    this.napKhongRoRiDau,
    this.ketQuaDanhGiaNap,
    this.thoiGianDongEmDe,
    this.deKhongNutVo,
    this.deKhongRoRiDau,
    this.ketQuaDanhGiaDe,
    this.tongLoi,
    this.ghiChu,
    this.nhanVienKiemTra,
  });

  int phieuKtDongCuongBucId;
  int soLanThu;
  String thoiGianDongEmNap;
  String napKhongNutVo;
  String napKhongRoRiDau;
  String ketQuaDanhGiaNap;
  String thoiGianDongEmDe;
  String deKhongNutVo;
  String deKhongRoRiDau;
  String ketQuaDanhGiaDe;
  String tongLoi;
  String ghiChu;
  String nhanVienKiemTra;

  factory MauKiemTraDongCuongBuc.fromJson(dynamic json) {
    return MauKiemTraDongCuongBuc(
      phieuKtDongCuongBucId: json["phieuKtDongCuongBucId"],
      soLanThu: json["soLanThu"],
      thoiGianDongEmNap: json["thoiGianDongEmNap"],
      napKhongNutVo: json["napKhongNutVo"],
      napKhongRoRiDau: json["napKhongRoRiDau"],
      ketQuaDanhGiaNap: json["ketQuaDanhGiaNap"],
      thoiGianDongEmDe: json["thoiGianDongEmDe"],
      deKhongNutVo: json["deKhongNutVo"],
      deKhongRoRiDau: json["deKhongRoRiDau"],
      ketQuaDanhGiaDe: json["ketQuaDanhGiaDe"],
      tongLoi: json["tongLoi"],
      ghiChu: json["ghiChu"],
      nhanVienKiemTra: json["nhanVienKiemTra"],
    );
  }
}

class SanPhamCB {
  SanPhamCB({
    this.tenSanPham,
    this.id,
  });

  String tenSanPham;
  String id;

  factory SanPhamCB.fromJson(dynamic json) {
    return SanPhamCB(
      tenSanPham: json["tenSanPham"],
      id: json["id"],
    );
  }
}
