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
class MyReliReportView {
  int id;
  int soLanThu;
  String ngayBatDau;
  String ngayKetThuc;
  String tenSanPham;
  String thoiGianDongEmNap;
  MyReliReportView(
      {this.soLanThu,
        this.id,
      this.ngayBatDau,
      this.ngayKetThuc,
      this.tenSanPham,
      this.thoiGianDongEmNap});
}

class ReliReport {
  ReliReport({
    this.items,
    this.totalItems,
  });

  List<Item> items = [];
  int totalItems;

  factory ReliReport.fromJson(dynamic jsonObject) {
    List<Item> listItems = [];
    List items = jsonObject["items"];
    for (var items in items) {
      Item item = Item.fromJson(items);
      listItems.add(item);
    }
    return ReliReport(items: listItems, totalItems: jsonObject["totalItems"]);
  }
}

class Item {
  Item({
    this.id,
    this.mucDichKiemTra,
    this.ngayBatDau,
    this.ngayKetThuc,
    this.maSanPham,
    this.sanPham,
    this.tieuChuanThuNghiem,
    this.mauKiemTraDongEm,
  });

  int id;
  String mucDichKiemTra;
  DateTime ngayBatDau;
  DateTime ngayKetThuc;
  String maSanPham;
  SanPham sanPham;
  String tieuChuanThuNghiem;
  List<MauKiemTraDongEm> mauKiemTraDongEm = [];

  factory Item.fromJson(dynamic json) {
    List<MauKiemTraDongEm> mauKiemTraDongEm = [];
    List items = json["mauKiemTraDongEm"];
    for (var item in items) {
      MauKiemTraDongEm giKiemTraDongEm = MauKiemTraDongEm.fromJson(item);
      mauKiemTraDongEm.add(giKiemTraDongEm);
    }
    return Item(
      id: json["id"],
      mucDichKiemTra: json["mucDichKiemTra"],
      ngayBatDau: DateTime.parse(json["ngayBatDau"]),
      ngayKetThuc: DateTime.parse(json["ngayKetThuc"]),
      maSanPham: json["maSanPham"],
      sanPham: SanPham.fromJson(json["sanPham"]),
      tieuChuanThuNghiem: json["tieuChuanThuNghiem"],
      mauKiemTraDongEm: mauKiemTraDongEm,
    );
  }
}

class MauKiemTraDongEm {
  MauKiemTraDongEm({
    this.phieuKtDongEmId,
    this.soLanThu,
    this.thoiGianDongEmNap,
    this.chanNapKhongRoiRa,
    this.napKhongRoRiDau,
    this.ketQuaDanhGiaNap,
    this.thoiGianDongEmDe,
    this.chanDeKhongRoiRa,
    this.deKhongRoRiDau,
    this.ketQuaDanhGiaDe,
    this.tongLoi,
    this.ghiChu,
    this.nhanVienKiemTra,
  });

  int phieuKtDongEmId;
  int soLanThu;
  String thoiGianDongEmNap;
  String chanNapKhongRoiRa;
  String napKhongRoRiDau;
  String ketQuaDanhGiaNap;
  String thoiGianDongEmDe;
  String chanDeKhongRoiRa;
  String deKhongRoRiDau;
  String ketQuaDanhGiaDe;
  String tongLoi;
  String ghiChu;
  String nhanVienKiemTra;

  factory MauKiemTraDongEm.fromJson(dynamic json) {
    return MauKiemTraDongEm(
      phieuKtDongEmId: json["phieuKtDongEmId"],
      soLanThu: json["soLanThu"],
      thoiGianDongEmNap: json["thoiGianDongEmNap"],
      chanNapKhongRoiRa: json["chanNapKhongRoiRa"],
      napKhongRoRiDau: json["napKhongRoRiDau"],
      ketQuaDanhGiaNap: json["ketQuaDanhGiaNap"],
      thoiGianDongEmDe: json["thoiGianDongEmDe"],
      chanDeKhongRoiRa: json["chanDeKhongRoiRa"],
      deKhongRoRiDau: json["deKhongRoRiDau"],
      ketQuaDanhGiaDe: json["ketQuaDanhGiaDe"],
      tongLoi: json["tongLoi"],
      ghiChu: json["ghiChu"],
      nhanVienKiemTra: json["nhanVienKiemTra"],
    );
  }
}

class SanPham {
  SanPham({
    this.tenSanPham,
    this.id,
  });

  String tenSanPham;
  String id;

  factory SanPham.fromJson(dynamic json) {
    return SanPham(
      tenSanPham: json["tenSanPham"],
      id: json["id"],
    );
  }
}
