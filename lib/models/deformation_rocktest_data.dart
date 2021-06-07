class MyDeforRockReportView {
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
    this.id,
    this.mucDichKiemTra,
    this.ngayBatDau,
    this.ngayKetThuc,
    this.maSanPham,
    this.sanPham,
    this.tieuChuanThuNghiem,
    this.mauKiemTraRockTest,
  });

  int id;
  String mucDichKiemTra;
  DateTime ngayBatDau;
  DateTime ngayKetThuc;
  String maSanPham;
  SanPhamRock sanPham;
  String tieuChuanThuNghiem;
  List<MauKiemTraRockTest> mauKiemTraRockTest = [];

  factory ItemRock.fromJson(dynamic json) {
    List<MauKiemTraRockTest> mauKiemTraRockTest = [];
    List items = json["mauKiemTraRockTest"];
    for (var item in items) {
      MauKiemTraRockTest giKiemTraRockTest = MauKiemTraRockTest.fromJson(item);
      mauKiemTraRockTest.add(giKiemTraRockTest);
    }
    return ItemRock(
      id: json["id"],
      mucDichKiemTra: json["mucDichKiemTra"],
      ngayBatDau: DateTime.parse(json["ngayBatDau"]),
      ngayKetThuc: DateTime.parse(json["ngayKetThuc"]),
      maSanPham: json["maSanPham"],
      sanPham: SanPhamRock.fromJson(json["sanPham"]),
      tieuChuanThuNghiem: json["tieuChuanThuNghiem"],
      mauKiemTraRockTest: mauKiemTraRockTest,
    );
  }
}

class MauKiemTraRockTest {
  MauKiemTraRockTest(
      {this.phieuKtRockTestId,
      this.id,
      this.ketQuaDanhGia,
      this.tongLoi,
      this.ghiChu,
      this.nhanVienKiemTra,
      this.taiTrong,
      this.soLanThuNghiem});

  int phieuKtRockTestId;
  int id;
  String taiTrong;
  String soLanThuNghiem;
  String ketQuaDanhGia;
  String tongLoi;
  String ghiChu;
  String nhanVienKiemTra;

  factory MauKiemTraRockTest.fromJson(dynamic json) {
    return MauKiemTraRockTest(
      phieuKtRockTestId: json["phieuKtRockTestId"],
      id: json["id"],
      taiTrong: json["taiTrong"],
      ketQuaDanhGia: json["ketQuaDanhGia"],
      soLanThuNghiem: json["soLanThuNghiem"],
      tongLoi: json["tongLoi"],
      ghiChu: json["ghiChu"],
      nhanVienKiemTra: json["nhanVienKiemTra"],
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
      tenSanPham: json["tenSanPham"],
      id: json["id"],
    );
  }
}
