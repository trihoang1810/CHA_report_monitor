class MyDeforBendingReportView {
  String tenSanPham;
  String mauSo;
  String taiTrong;
  String thoiGian;
  String doCongVenh;
  String nhanVienKiemTra;
  String tongLoi;
  String ghiChu;
  MyDeforBendingReportView(
      {this.ghiChu,
      this.mauSo,
      this.nhanVienKiemTra,
      this.tenSanPham,
      this.doCongVenh,
      this.taiTrong,
      this.thoiGian,
      this.tongLoi});
}

class DeforBendingReport {
  DeforBendingReport({
    this.items,
    this.totalItems,
  });

  List<ItemBending> items = [];
  int totalItems;

  factory DeforBendingReport.fromJson(dynamic jsonObject) {
    List<ItemBending> listItems = [];
    List items = jsonObject["items"];
    for (var items in items) {
      ItemBending item = ItemBending.fromJson(items);
      listItems.add(item);
    }
    return DeforBendingReport(
        items: listItems, totalItems: jsonObject["totalItems"]);
  }
}

class ItemBending {
  ItemBending({
    this.mucDichKiemTra,
    this.ngayBatDau,
    this.ngayKetThuc,
    this.maSanPham,
    this.sanPham,
    this.tieuChuanThuNghiem,
    this.mauKiemTraLucUon,
  });

  String mucDichKiemTra;
  DateTime ngayBatDau;
  DateTime ngayKetThuc;
  String maSanPham;
  SanPhamBending sanPham;
  String tieuChuanThuNghiem;
  List<MauKiemTraLucUon> mauKiemTraLucUon = [];

  factory ItemBending.fromJson(dynamic json) {
    List<MauKiemTraLucUon> mauKiemTraLucUon = [];
    List items = json["curlingForceTestSheet"];
    for (var item in items) {
      MauKiemTraLucUon giKiemTraLucUon = MauKiemTraLucUon.fromJson(item);
      mauKiemTraLucUon.add(giKiemTraLucUon);
    }
    return ItemBending(
      mucDichKiemTra: json["target"],
      ngayBatDau: DateTime.parse(json["startTime"]),
      ngayKetThuc: DateTime.parse(json["stopTime"]),
      maSanPham: json["productId"],
      sanPham: SanPhamBending.fromJson(json["product"]),
      tieuChuanThuNghiem: json["standard"],
      mauKiemTraLucUon: mauKiemTraLucUon,
    );
  }
}

class MauKiemTraLucUon {
  MauKiemTraLucUon(
      {this.id,
      this.doCongVenh,
      this.tongLoi,
      this.ghiChu,
      this.nhanVienKiemTra,
      this.taiTrong,
      this.thoiGian});

  int id;
  int taiTrong;
  int thoiGian;
  String doCongVenh;
  String tongLoi;
  String ghiChu;
  String nhanVienKiemTra;

  factory MauKiemTraLucUon.fromJson(dynamic json) {
    return MauKiemTraLucUon(
      id: json["id"],
      taiTrong: json["mass"],
      thoiGian: json["timeSpan"],
      doCongVenh: json["warping"],
      tongLoi: json["totalError"],
      ghiChu: json["remark"],
      nhanVienKiemTra: json["employee"],
    );
  }
}

class SanPhamBending {
  SanPhamBending({
    this.tenSanPham,
    this.id,
  });

  String tenSanPham;
  String id;

  factory SanPhamBending.fromJson(dynamic json) {
    return SanPhamBending(
      tenSanPham: json["name"],
      id: json["id"],
    );
  }
}
