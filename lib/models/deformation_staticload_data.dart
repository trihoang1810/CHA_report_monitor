class MyDeforStaticReportView {
  String tenSanPham;
  String mauSo;
  String tinhTrang;
  String tongLoi;
  String ghiChu;
  String nhanVienKiemTra;
  MyDeforStaticReportView(
      {this.ghiChu,
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
    this.mucDichKiemTra,
    this.ngayBatDau,
    this.ngayKetThuc,
    this.maSanPham,
    this.sanPham,
    this.tieuChuanThuNghiem,
    this.mauKiemTraChiuTaiTinh,
  });

  String mucDichKiemTra;
  DateTime ngayBatDau;
  DateTime ngayKetThuc;
  String maSanPham;
  SanPhamStatic sanPham;
  String tieuChuanThuNghiem;
  List<MauKiemTraChiuTaiTinh> mauKiemTraChiuTaiTinh = [];

  factory ItemStatic.fromJson(dynamic json) {
    List<MauKiemTraChiuTaiTinh> mauKiemTraChiuTaiTinh = [];
    List items = json["staticLoadTestSheet"];
    for (var item in items) {
      MauKiemTraChiuTaiTinh giKiemTraChiuTaiTinh =
          MauKiemTraChiuTaiTinh.fromJson(item);
      mauKiemTraChiuTaiTinh.add(giKiemTraChiuTaiTinh);
    }
    return ItemStatic(
      mucDichKiemTra: json["target"],
      ngayBatDau: DateTime.parse(json["startTime"]),
      ngayKetThuc: DateTime.parse(json["stopTime"]),
      maSanPham: json["productId"],
      sanPham: SanPhamStatic.fromJson(json["product"]),
      tieuChuanThuNghiem: json["standard"],
      mauKiemTraChiuTaiTinh: mauKiemTraChiuTaiTinh,
    );
  }
}

class MauKiemTraChiuTaiTinh {
  MauKiemTraChiuTaiTinh({
    this.id,
    this.ketQuaKiemTraTaiTinh,
    this.tongLoi,
    this.ghiChu,
    this.nhanVienKiemTra,
  });

  int id;
  String ketQuaKiemTraTaiTinh;
  String tongLoi;
  String ghiChu;
  String nhanVienKiemTra;

  factory MauKiemTraChiuTaiTinh.fromJson(dynamic json) {
    return MauKiemTraChiuTaiTinh(
      id: json["id"],
      ketQuaKiemTraTaiTinh: json["testResult"],
      tongLoi: json["totalError"],
      ghiChu: json["note"],
      nhanVienKiemTra: json["employee"],
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
      tenSanPham: json["name"],
      id: json["id"],
    );
  }
}
