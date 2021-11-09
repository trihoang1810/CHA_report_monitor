class MyDeforRockReportView {
  String ngayBatDau;
  String ngayKetThuc;
  String tenSanPham;
  String mauSo;
  String taiTrong;
  String soLanThu;
  String ketQuaDanhGia;
  String nhanVienKiemTra;
  String tongLoi;
  String ghiChu;
  MyDeforRockReportView(
      {this.ghiChu,
      this.ngayBatDau,
      this.ngayKetThuc,
      this.mauSo,
      this.nhanVienKiemTra,
      this.tenSanPham,
      this.ketQuaDanhGia,
      this.taiTrong,
      this.soLanThu,
      this.tongLoi});
}

class DeforRockReport {
  DeforRockReport({
    this.items,
    this.totalItems,
  });

  List<ItemRock> items = [];
  int totalItems;

  factory DeforRockReport.fromJson(dynamic jsonObject) {
    List<ItemRock> listItems = [];
    List items = jsonObject["items"];
    for (var items in items) {
      ItemRock item = ItemRock.fromJson(items);
      listItems.add(item);
    }
    return DeforRockReport(
        items: listItems, totalItems: jsonObject["totalItems"]);
  }
}

class ItemRock {
  ItemRock({
    this.mucDichKiemTra,
    this.ngayBatDau,
    this.ngayKetThuc,
    this.maSanPham,
    this.sanPham,
    this.tieuChuanThuNghiem,
    this.mauKiemTraRockTest,
  });

  String mucDichKiemTra;
  DateTime ngayBatDau;
  DateTime ngayKetThuc;
  String maSanPham;
  SanPhamRock sanPham;
  String tieuChuanThuNghiem;
  List<MauKiemTraRockTest> mauKiemTraRockTest = [];

  factory ItemRock.fromJson(dynamic json) {
    List<MauKiemTraRockTest> mauKiemTraRockTest = [];
    List items = json["rockTestSheets"];
    for (var item in items) {
      MauKiemTraRockTest giKiemTraRockTest = MauKiemTraRockTest.fromJson(item);
      mauKiemTraRockTest.add(giKiemTraRockTest);
    }
    return ItemRock(
      mucDichKiemTra: json["target"],
      ngayBatDau: DateTime.parse(json["startTime"]),
      ngayKetThuc: DateTime.parse(json["stopTime"]),
      maSanPham: json["productId"],
      sanPham: SanPhamRock.fromJson(json["product"]),
      tieuChuanThuNghiem: json["standard"],
      mauKiemTraRockTest: mauKiemTraRockTest,
    );
  }
}

class MauKiemTraRockTest {
  MauKiemTraRockTest(
      {this.id,
      this.ketQuaDanhGia,
      this.tongLoi,
      this.ghiChu,
      this.nhanVienKiemTra,
      this.taiTrong,
      this.soLanThuNghiem});

  int id;
  int taiTrong;
  int soLanThuNghiem;
  String ketQuaDanhGia;
  String tongLoi;
  String ghiChu;
  String nhanVienKiemTra;

  factory MauKiemTraRockTest.fromJson(dynamic json) {
    return MauKiemTraRockTest(
      id: json["id"],
      taiTrong: json["mass"],
      ketQuaDanhGia: json["testResult"],
      soLanThuNghiem: json["numberOfTest"],
      tongLoi: json["totalError"],
      ghiChu: json["note"],
      nhanVienKiemTra: json["employee"],
    );
  }
}

class SanPhamRock {
  SanPhamRock({
    this.tenSanPham,
    this.id,
  });

  String tenSanPham;
  String id;

  factory SanPhamRock.fromJson(dynamic json) {
    return SanPhamRock(
      tenSanPham: json["name"],
      id: json["id"],
    );
  }
}
