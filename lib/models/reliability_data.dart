class MyReliReportView {
  int soLanThu;
  String ngayBatDau;
  String ngayKetThuc;
  String tenSanPham;
  String thoiGianDongEmNap;
  MyReliReportView(
      {this.soLanThu,
      this.ngayBatDau,
      this.ngayKetThuc,
      this.tenSanPham,
      this.thoiGianDongEmNap});
}

//đây là raw
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
    for (var itemsmini in items) {
      Item item = Item.fromJson(itemsmini);
      listItems.add(item);
    }
    return ReliReport(items: listItems, totalItems: jsonObject["totalItems"]);
  }
}

class Item {
  Item({
    this.mucDichKiemTra,
    this.ngayBatDau,
    this.ngayKetThuc,
    this.maSanPham,
    this.sanPham,
    this.tieuChuanThuNghiem,
    this.mauKiemTraDongEm,
  });

  String mucDichKiemTra;
  DateTime ngayBatDau;
  DateTime ngayKetThuc;
  String maSanPham;
  SanPham sanPham;
  String tieuChuanThuNghiem;
  List<MauKiemTraDongEm> mauKiemTraDongEm = [];

  factory Item.fromJson(dynamic json) {
    List<MauKiemTraDongEm> mauKiemTraDongEm = [];
    List items = json["reliabilityTestSheets"];
    for (var item in items) {
      MauKiemTraDongEm giKiemTraDongEm = MauKiemTraDongEm.fromJson(item);
      mauKiemTraDongEm.add(giKiemTraDongEm);
    }
    return Item(
      mucDichKiemTra: json["target"],
      ngayBatDau: DateTime.parse(json["startTime"]),
      ngayKetThuc: DateTime.parse(json["stopTime"]),
      maSanPham: json["productId"],
      sanPham: SanPham.fromJson(json["product"]),
      tieuChuanThuNghiem: json["standard"],
      mauKiemTraDongEm: mauKiemTraDongEm,
    );
  }
}

class MauKiemTraDongEm {
  MauKiemTraDongEm({
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

  int soLanThu;
  int thoiGianDongEmNap;
  String chanNapKhongRoiRa;
  String napKhongRoRiDau;
  String ketQuaDanhGiaNap;
  int thoiGianDongEmDe;
  String chanDeKhongRoiRa;
  String deKhongRoRiDau;
  String ketQuaDanhGiaDe;
  String tongLoi;
  String ghiChu;
  String nhanVienKiemTra;

  factory MauKiemTraDongEm.fromJson(dynamic json) {
    return MauKiemTraDongEm(
      soLanThu: json["numberTesting"],
      thoiGianDongEmNap: json["timeSmoothClosingLid"],
      chanNapKhongRoiRa: json["statusLidNotFall"],
      napKhongRoRiDau: json["statusLidNotLeak"],
      ketQuaDanhGiaNap: json["statusLidResul"],
      thoiGianDongEmDe: json["timeSmoothClosingPlinth"],
      chanDeKhongRoiRa: json["statusPlinthNotFall"],
      deKhongRoRiDau: json["statusPlinthNotLeak"],
      ketQuaDanhGiaDe: json["statusPlinthResult"],
      tongLoi: json["totalError"],
      ghiChu: json["note"],
      nhanVienKiemTra: json["employee"],
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
      tenSanPham: json["name"],
      id: json["id"],
    );
  }
}
