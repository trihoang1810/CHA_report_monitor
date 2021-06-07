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
    this.id,
    this.mucDichKiemTra,
    this.ngayBatDau,
    this.ngayKetThuc,
    this.maSanPham,
    this.sanPham,
    this.tieuChuanThuNghiem,
    this.mauKiemTraLucUon,
  });

  int id;
  String mucDichKiemTra;
  DateTime ngayBatDau;
  DateTime ngayKetThuc;
  String maSanPham;
  SanPhamBending sanPham;
  String tieuChuanThuNghiem;
  List<MauKiemTraLucUon> mauKiemTraLucUon = [];

  factory ItemBending.fromJson(dynamic json) {
    List<MauKiemTraLucUon> mauKiemTraLucUon = [];
    List items = json["mauKiemTraLucUon"];
    for (var item in items) {
      MauKiemTraLucUon giKiemTraLucUon = MauKiemTraLucUon.fromJson(item);
      mauKiemTraLucUon.add(giKiemTraLucUon);
    }
    return ItemBending(
      id: json["id"],
      mucDichKiemTra: json["mucDichKiemTra"],
      ngayBatDau: DateTime.parse(json["ngayBatDau"]),
      ngayKetThuc: DateTime.parse(json["ngayKetThuc"]),
      maSanPham: json["maSanPham"],
      sanPham: SanPhamBending.fromJson(json["sanPham"]),
      tieuChuanThuNghiem: json["tieuChuanThuNghiem"],
      mauKiemTraLucUon: mauKiemTraLucUon,
    );
  }
}

class MauKiemTraLucUon {
  MauKiemTraLucUon(
      {this.phieuKtLucUonId,
      this.id,
      this.doCongVenh,
      this.tongLoi,
      this.ghiChu,
      this.nhanVienKiemTra,
      this.taiTrong,
      this.thoiGian});

  int phieuKtLucUonId;
  int id;
  String taiTrong;
  String thoiGian;
  String doCongVenh;
  String tongLoi;
  String ghiChu;
  String nhanVienKiemTra;

  factory MauKiemTraLucUon.fromJson(dynamic json) {
    return MauKiemTraLucUon(
      phieuKtLucUonId: json["phieuKtLucUonId"],
      id: json["id"],
      taiTrong: json["taiTrong"],
      thoiGian: json["thoiGian"],
      doCongVenh: json["doCongVenh"],
      tongLoi: json["tongLoi"],
      ghiChu: json["nhanXet"],
      nhanVienKiemTra: json["nhanVienKiemTra"],
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
      tenSanPham: json["tenSanPham"],
      id: json["id"],
    );
  }
}
