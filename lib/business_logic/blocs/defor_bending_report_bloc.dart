import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/business_logic/events/defor_report_event.dart';
import 'package:mobile_app/business_logic/states/defor_report_state.dart';
import 'package:mobile_app/models/deformation_bending_data.dart';
import 'package:mobile_app/models/deformation_rocktest_data.dart';
import 'package:mobile_app/models/deformation_staticload_data.dart';
import 'package:mobile_app/models/error_package.dart';
import 'package:mobile_app/presentation/routers/app_router.dart';

List<MyDeforStaticReportView> deforStaticReportList = [];
List<MyDeforStaticReportView> deforStaticReportListNew = [];
List<MyDeforBendingReportView> deforBendingReportList = [];
List<MyDeforBendingReportView> deforBendingReportListNew = [];
List<MyDeforRockReportView> deforRockReportList = [];
List<MyDeforRockReportView> deforRockReportListNew = [];

class DeforReportBloc extends Bloc<DeforReportEvent, DeforReportState> {
  DeforReportBloc()
      : super(DeforBendingReportStateInit(timestamp: DateTime.now()));

  @override
  Stream<DeforReportState> mapEventToState(DeforReportEvent event) async* {
    if (event is DeforBendingReportEventSearchingClicked) {
      yield DeforBendingReportStateLoadingRequest();
      try {
        final deforBendingReportData = await deforBendingReportRepository
            .loadingDeforBendingDataRequest(event.startTime, event.stopTime);
        deforBendingReportListNew.clear();
        if (deforBendingReportData is DeforBendingReport) {
          for (var item in deforBendingReportData.items) {
            for (var mau in item.mauKiemTraLucUon) {
              MyDeforBendingReportView _myDeforBendingReportView =
                  MyDeforBendingReportView(
                      mauSo: mau.id.toString(),
                      tenSanPham: item.sanPham.tenSanPham,
                      taiTrong: mau.taiTrong.toString(),
                      thoiGian: mau.thoiGian.toString(),
                      doCongVenh: mau.doCongVenh,
                      tongLoi: mau.tongLoi,
                      ghiChu: mau.ghiChu,
                      nhanVienKiemTra: mau.nhanVienKiemTra);
              deforBendingReportListNew.add(_myDeforBendingReportView);
            }
          }
          deforBendingReportList = deforBendingReportListNew;
          yield DeforBendingReportStateLoadingSuccessful(
              timestamp: event.timestamp);
        } else if (deforBendingReportData is ErrorPackage) {
          yield DeforBendingReportStateLoadingFailure(
              timestamp: event.timestamp,
              errorPackage: ErrorPackage(
                  errorCode: deforBendingReportData.errorCode,
                  message: deforBendingReportData.message,
                  detail: deforBendingReportData.detail));
        } else {
          // print("ok");
        }
      } on SocketException {
        yield DeforBendingReportStateLoadingFailure(
          timestamp: event.timestamp,
          errorPackage: new ErrorPackage(
              errorCode: "SocketException",
              message: "Lost connection to the server",
              detail: ""),
        );
      } on TimeoutException {
        yield DeforBendingReportStateLoadingFailure(
          errorPackage: new ErrorPackage(
            errorCode: "TimeoutException",
            message: "Overtime",
            detail: "",
          ),
        );
      } catch (e) {
        yield DeforBendingReportStateLoadingFailure(
          timestamp: event.timestamp,
          errorPackage: new ErrorPackage(
            errorCode: "Exception",
            message: "",
            detail: e.toString(),
          ),
        );
      }
    } else if (event is DeforBendingReportEventPickDateRange) {
      final initialDateRange = DateTimeRange(
        start: DateTime.now().subtract(Duration(hours: 24 * 3)),
        end: DateTime.now().add(Duration(hours: 24)),
      );
      final newDateRange = await showDateRangePicker(
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDateRange: initialDateRange,
        context: event.context,
      );
      if (newDateRange == null) {
        yield DeforBendingReportStateLoadingFailure(
            errorPackage: ErrorPackage(message: "Vui lòng chọn ngày"));
      } else {
        yield DeforBendingReportStatePickDateRange(
            dateRange: newDateRange,
            getFrom: DateFormat('yyyy/MM/dd').format(newDateRange.start),
            getUntil: DateFormat('yyyy/MM/dd').format(newDateRange.end));
      }
    }
    //static_load_bloc
    else if (event is DeforStaticReportEventSearchingClicked) {
      yield DeforStaticReportStateLoadingRequest();
      try {
        final deforStaticReportData = await deforStaticReportRepository
            .loadingDeforStaticDataRequest(event.startTime, event.stopTime);
        deforStaticReportListNew.clear();
        if (deforStaticReportData is DeforStaticReport) {
          for (var item in deforStaticReportData.items) {
            for (var mau in item.mauKiemTraChiuTaiTinh) {
              MyDeforStaticReportView _myDeforStaticReportView =
                  MyDeforStaticReportView(
                      mauSo: mau.id.toString(),
                      tenSanPham: item.sanPham.tenSanPham,
                      tinhTrang: mau.ketQuaKiemTraTaiTinh,
                      tongLoi: mau.tongLoi,
                      ghiChu: mau.ghiChu,
                      nhanVienKiemTra: mau.nhanVienKiemTra);
              deforStaticReportListNew.add(_myDeforStaticReportView);
            }
          }
          deforStaticReportList = deforStaticReportListNew;
          yield DeforStaticReportStateLoadingSuccessful(
              timestamp: event.timestamp);
        } else if (deforStaticReportData is ErrorPackage) {
          yield DeforStaticReportStateLoadingFailure(
              timestamp: event.timestamp,
              errorPackage: ErrorPackage(
                  errorCode: deforStaticReportData.errorCode,
                  message: deforStaticReportData.message,
                  detail: deforStaticReportData.detail));
        } else {
          // print("ok");
        }
      } on SocketException {
        yield DeforStaticReportStateLoadingFailure(
          timestamp: event.timestamp,
          errorPackage: new ErrorPackage(
              errorCode: "SocketException",
              message: "Lost connection to the server",
              detail: ""),
        );
      } on TimeoutException {
        yield DeforStaticReportStateLoadingFailure(
          errorPackage: new ErrorPackage(
            errorCode: "TimeoutException",
            message: "Overtime",
            detail: "",
          ),
        );
      } catch (e) {
        yield DeforStaticReportStateLoadingFailure(
          timestamp: event.timestamp,
          errorPackage: new ErrorPackage(
            errorCode: "Exception",
            message: "",
            detail: e.toString(),
          ),
        );
      }
    } else if (event is DeforStaticReportEventPickDateRange) {
      final initialDateRange = DateTimeRange(
        start: DateTime.now().subtract(Duration(hours: 24 * 3)),
        end: DateTime.now().add(Duration(hours: 24)),
      );
      final newDateRange = await showDateRangePicker(
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDateRange: initialDateRange,
        context: event.context,
      );
      if (newDateRange == null) {
        yield DeforStaticReportStateLoadingFailure(
            errorPackage: ErrorPackage(message: "Vui lòng chọn ngày"));
      } else {
        yield DeforStaticReportStatePickDateRange(
            dateRange: newDateRange,
            getFrom: DateFormat('yyyy/MM/dd').format(newDateRange.start),
            getUntil: DateFormat('yyyy/MM/dd').format(newDateRange.end));
      }
    }
    // rock_test_bloc
    else if (event is DeforRockReportEventSearchingClicked) {
      yield DeforRockReportStateLoadingRequest();
      try {
        final deforRockReportData = await deforRockReportRepository
            .loadingDeforRockDataRequest(event.startTime, event.stopTime);
        deforRockReportListNew.clear();
        if (deforRockReportData is DeforRockReport) {
          for (var item in deforRockReportData.items) {
            for (var mau in item.mauKiemTraRockTest) {
              MyDeforRockReportView myDeforRockReportView =
                  MyDeforRockReportView(
                      mauSo: mau.id.toString(),
                      tenSanPham: item.sanPham.tenSanPham,
                      taiTrong: mau.taiTrong.toString(),
                      soLanThu: mau.soLanThuNghiem.toString(),
                      ketQuaDanhGia: mau.ketQuaDanhGia,
                      tongLoi: mau.tongLoi,
                      ghiChu: mau.ghiChu,
                      nhanVienKiemTra: mau.nhanVienKiemTra);
              deforRockReportListNew.add(myDeforRockReportView);
            }
          }
          deforRockReportList = deforRockReportListNew;
          yield DeforRockReportStateLoadingSuccessful(
              timestamp: event.timestamp);
        } else if (deforRockReportData is ErrorPackage) {
          yield DeforRockReportStateLoadingFailure(
              timestamp: event.timestamp,
              errorPackage: ErrorPackage(
                  errorCode: deforRockReportData.errorCode,
                  message: deforRockReportData.message,
                  detail: deforRockReportData.detail));
        } else {
          // print("ok");
        }
      } on SocketException {
        yield DeforRockReportStateLoadingFailure(
          timestamp: event.timestamp,
          errorPackage: new ErrorPackage(
              errorCode: "SocketException",
              message: "Lost connection to the server",
              detail: ""),
        );
      } on TimeoutException {
        yield DeforRockReportStateLoadingFailure(
          errorPackage: new ErrorPackage(
            errorCode: "TimeoutException",
            message: "Overtime",
            detail: "",
          ),
        );
      } catch (e) {
        yield DeforRockReportStateLoadingFailure(
          timestamp: event.timestamp,
          errorPackage: new ErrorPackage(
            errorCode: "Exception",
            message: "",
            detail: e.toString(),
          ),
        );
      }
    } else if (event is DeforRockReportEventPickDateRange) {
      final initialDateRange = DateTimeRange(
        start: DateTime.now().subtract(Duration(hours: 24 * 3)),
        end: DateTime.now().add(Duration(hours: 24)),
      );
      final newDateRange = await showDateRangePicker(
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDateRange: initialDateRange,
        context: event.context,
      );
      if (newDateRange == null) {
        yield DeforRockReportStateLoadingFailure(
            errorPackage: ErrorPackage(message: "Vui lòng chọn ngày"));
      } else {
        yield DeforRockReportStatePickDateRange(
            dateRange: newDateRange,
            getFrom: DateFormat('yyyy/MM/dd').format(newDateRange.start),
            getUntil: DateFormat('yyyy/MM/dd').format(newDateRange.end));
      }
    }
  }
}
