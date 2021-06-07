class MyDeforStaticReportView {
  String tenSanPham;
  String mauSo;
  String tinhTrang;
  String tongLoi;
  String ghiChu;
  String nhanVienKiemTra;
  MyDeforStaticReportView(
      {
      this.ghiChu,
      this.mauSo,
      this.nhanVienKiemTra,
      this.tenSanPham,
      this.tinhTrang,
     
      this.tongLoi});
}

class DeforStaticReport {
  DeforStaticReport({
    this.items,
    this.totalItems,
  });

  List<ItemStatic> items = [];
  int totalItems;

  factory DeforStaticReport.fromJson(dynamic jsonObject) {
    List<ItemStatic> listItems = [];
    List items = jsonObject["items"];
    for (var items in items) {
      ItemStatic item = ItemStatic.fromJson(items);
      listItems.add(item);
    }
    return DeforStaticReport(
        items: listItems, totalItems: jsonObject["totalItems"]);
  }
}

class ItemStatic {
  ItemStatic({
    this.id,
    this.mucDichKiemTra,
    this.ngayBatDau,
    this.ngayKetThuc,
    this.maSanPham,
    this.sanPham,
    this.tieuChuanThuNghiem,
    this.mauKiemTraChiuTaiTinh,
  });

  int id;
  String mucDichKiemTra;
  DateTime ngayBatDau;
  DateTime ngayKetThuc;
  String maSanPham;
  SanPhamStatic sanPham;
  String tieuChuanThuNghiem;
  List<MauKiemTraChiuTaiTinh> mauKiemTraChiuTaiTinh = [];

  factory ItemStatic.fromJson(dynamic json) {
    List<MauKiemTraChiuTaiTinh> mauKiemTraChiuTaiTinh = [];
    List items = json["mauKiemTraChiuTaiTinh"];
    for (var item in items) {
      MauKiemTraChiuTaiTinh giKiemTraChiuTaiTinh =
          MauKiemTraChiuTaiTinh.fromJson(item);
      mauKiemTraChiuTaiTinh.add(giKiemTraChiuTaiTinh);
    }
    return ItemStatic(
      id: json["id"],
      mucDichKiemTra: json["mucDichKiemTra"],
      ngayBatDau: DateTime.parse(json["ngayBatDau"]),
      ngayKetThuc: DateTime.parse(json["ngayKetThuc"]),
      maSanPham: json["maSanPham"],
      sanPham: SanPhamStatic.fromJson(json["sanPham"]),
      tieuChuanThuNghiem: json["tieuChuanThuNghiem"],
      mauKiemTraChiuTaiTinh: mauKiemTraChiuTaiTinh,
    );
  }
}

class MauKiemTraChiuTaiTinh {
  MauKiemTraChiuTaiTinh({
    this.phieuKtChiuTaiTinhId,
    this.id,
    this.ketQuaKiemTraTaiTinh,
    this.tongLoi,
    this.ghiChu,
    this.nhanVienKiemTra,
  });

  int phieuKtChiuTaiTinhId;
  int id;
  String ketQuaKiemTraTaiTinh;
  String tongLoi;
  String ghiChu;
  String nhanVienKiemTra;

  factory MauKiemTraChiuTaiTinh.fromJson(dynamic json) {
    return MauKiemTraChiuTaiTinh(
      phieuKtChiuTaiTinhId: json["phieuKtChiuTaiTinhId"],
      id: json["id"],
      ketQuaKiemTraTaiTinh: json["ketQuaKiemTraTaiTinh"],
      tongLoi: json["tongLoi"],
      ghiChu: json["ghiChu"],
      nhanVienKiemTra: json["nhanVienKiemTra"],
    );
  }
}

class SanPhamStatic {
  SanPhamStatic({
    this.tenSanPham,
    this.id,
  });

  String tenSanPham;
  String id;

  factory SanPhamStatic.fromJson(dynamic json) {
    return SanPhamStatic(
      tenSanPham: json["tenSanPham"],
      id: json["id"],
    );
  }
}
