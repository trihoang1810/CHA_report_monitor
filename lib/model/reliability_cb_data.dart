
class MyReliCBReportView {

  int soLanThu;
  String ngayBatDau;
  String ngayKetThuc;
  String tenSanPham;
  String thoiGianDongEmNap;
  MyReliCBReportView(
      {this.soLanThu,
   
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
    for (var itemsmini in items) {
      ItemCB item = ItemCB.fromJson(itemsmini);
      listItems.add(item);
    }
    return ReliCBReport(items: listItems, totalItems: jsonObject["totalItems"]);
  }
}

class ItemCB {
  ItemCB({

    this.mucDichKiemTra,
    this.ngayBatDau,
    this.ngayKetThuc,
    this.maSanPham,
    this.sanPham,
    this.tieuChuanThuNghiem,
    this.mauKiemTraDongCuongBuc,
  });


  String mucDichKiemTra;
  DateTime ngayBatDau;
  DateTime ngayKetThuc;
  String maSanPham;
  SanPhamCB sanPham;
  String tieuChuanThuNghiem;
  List<MauKiemTraDongCuongBuc> mauKiemTraDongCuongBuc = [];

  factory ItemCB.fromJson(dynamic json) {
    List<MauKiemTraDongCuongBuc> mauKiemTraDongCuongBuc = [];
    List items = json["deformationTestSheets"];
    for (var item in items) {
      MauKiemTraDongCuongBuc giKiemTraDongCuongBuc =
          MauKiemTraDongCuongBuc.fromJson(item);
      mauKiemTraDongCuongBuc.add(giKiemTraDongCuongBuc);
    }
    return ItemCB(
    
      mucDichKiemTra: json["target"],
      ngayBatDau: DateTime.parse(json["startTime"]),
      ngayKetThuc: DateTime.parse(json["stopTime"]),
      maSanPham: json["productId"],
      sanPham: SanPhamCB.fromJson(json["product"]),
      tieuChuanThuNghiem: json["standard"],
      mauKiemTraDongCuongBuc: mauKiemTraDongCuongBuc,
    );
  }
}

class MauKiemTraDongCuongBuc {
  MauKiemTraDongCuongBuc({
   
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


  int soLanThu;
  int thoiGianDongEmNap;
  String napKhongNutVo;
  String napKhongRoRiDau;
  String ketQuaDanhGiaNap;
  int thoiGianDongEmDe;
  String deKhongNutVo;
  String deKhongRoRiDau;
  String ketQuaDanhGiaDe;
  String tongLoi;
  String ghiChu;
  String nhanVienKiemTra;

  factory MauKiemTraDongCuongBuc.fromJson(dynamic json) {
    return MauKiemTraDongCuongBuc(
 
      soLanThu: json["numberTesting"],
      thoiGianDongEmNap: json["timeSmoothClosingLid"],
      napKhongNutVo: json["statusLidNotBreak"],
      napKhongRoRiDau: json["statusLidNotLeak"],
      ketQuaDanhGiaNap: json["statusLidResult"],
      thoiGianDongEmDe: json["timeSmoothClosingPlinth"],
      deKhongNutVo: json["statusPlinthNotBreak"],
      deKhongRoRiDau: json["statusPlinthNotLeak"],
      ketQuaDanhGiaDe: json["statusPlinthResult"],
      tongLoi: json["totalError"],
      ghiChu: json["note"],
      nhanVienKiemTra: json["employee"],
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
      tenSanPham: json["name"],
      id: json["id"],
    );
  }
}
