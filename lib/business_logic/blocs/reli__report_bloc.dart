import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/models/error_package.dart';
import 'package:mobile_app/business_logic/events/reli_report_event.dart';
import 'package:mobile_app/business_logic/states/reli_report_state.dart';
import 'package:mobile_app/models/reliability_cb_data.dart';
import 'package:mobile_app/models/reliability_data.dart';
import 'package:mobile_app/presentation/routers/app_router.dart';

List<MyReliReportView> reliReportList = [];
List<MyReliReportView> reliReportListNew = [];
List<MyReliCBReportView> reliCBReportList = [];
List<MyReliCBReportView> reliCBReportListNew = [];

class ReliReportBloc extends Bloc<ReliReportEvent, ReliReportState> {
  ReliReportBloc() : super(ReliReportStateInit(timestamp: DateTime.now()));

  @override
  Stream<ReliReportState> mapEventToState(ReliReportEvent event) async* {
    if (event is ReliReportEventSearchingClicked) {
      yield ReliReportStateLoadingRequest();
      try {
        print('vao try relireport');
        final reliReportData = await reliReportRepository
            .loadingReliDataRequest(event.startTime, event.stopTime);
        reliReportListNew.clear();
        print('load relireport thanh cong1');
        if (reliReportData is ReliReport) {
          print('load relireportlist thanh cong');
          print(reliReportData.totalItems);
          for (var item in reliReportData.items) {
            print(item.mucDichKiemTra);
            for (var mau in item.mauKiemTraDongEm) {
              MyReliReportView _myReliReportView = MyReliReportView(
                  id: item.id,
                  soLanThu: mau.soLanThu,
                  ngayBatDau:
                      DateFormat('dd-MM-yyyy - HH:mm').format(item.ngayBatDau),
                  ngayKetThuc:
                      DateFormat('dd-MM-yyyy - HH:mm').format(item.ngayKetThuc),
                  tenSanPham: item.sanPham.tenSanPham,
                  thoiGianDongEmNap: mau.thoiGianDongEmNap);
              reliReportListNew.add(_myReliReportView);
            }
          }
          reliReportList = reliReportListNew;
          yield ReliReportStateLoadingSuccessful(timestamp: event.timestamp);
        } else if (reliReportData is ErrorPackage) {
          print('load relireport that bai' +
              reliReportData.message +
              reliReportData.detail);
          yield ReliReportStateLoadingFailure(
              timestamp: event.timestamp,
              errorPackage: ErrorPackage(
                  errorCode: "Exception", message: "", detail: ""));
        }
      } on SocketException {
        yield ReliReportStateLoadingFailure(
          errorPackage: new ErrorPackage(
              errorCode: "SocketException",
              message: "Lost connection to the server",
              detail: ""),
        );
      } on TimeoutException {
        print('loi time out exception');
        yield ReliReportStateLoadingFailure(
          errorPackage: new ErrorPackage(
              errorCode: "TimeoutException", message: "Overtime", detail: ""),
        );
        print('loi bloc');
      } catch (e) {
        print(e.toString());
        //Chỗ này tránh các lỗi bậy bạ
        yield ReliReportStateLoadingFailure(
          errorPackage: new ErrorPackage(
              errorCode: "Exception", message: e.toString(), detail: ""),
        );
      }
    } else if (event is ReliReportEventPickDateRange) {
      final initialDateRange = DateTimeRange(
        start: DateTime.now().subtract(Duration(hours: 24 * 3)),
        end: DateTime.now(),
      );
      final newDateRange = await showDateRangePicker(
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDateRange: initialDateRange,
        context: event.context,
      );
      if (newDateRange == null) {
        yield ReliReportStateLoadingFailure(
            errorPackage: ErrorPackage(message: "Vui lòng chọn ngày"));
      } else {
        yield ReliReportStatePickDateRange(
            dateRange: newDateRange,
            getFrom: DateFormat('yyyy-MM-dd').format(newDateRange.start),
            getUntil: DateFormat('yyyy-MM-dd').format(newDateRange.end));
      }
    } else if (event is ReliCBReportEventSearchingClicked) {
      print('reli RPCB clicked');
      yield ReliCBReportStateLoadingRequest();
      try {
        print('vao try relicbreport');
        final reliCBReportData = await reliCBReportRepository
            .loadingReliCBDataRequest(DateTime.now(), DateTime.now());
        reliCBReportListNew.clear();
        if (reliCBReportData is ReliCBReport) {
          print('load cb thanh cong');
          for (var item in reliCBReportData.items) {
            print(item.mucDichKiemTra);
            for (var mau in item.mauKiemTraDongCuongBuc) {
              MyReliCBReportView _myReliCBReportView = MyReliCBReportView(
                  id: item.id,
                  soLanThu: mau.soLanThu,
                  ngayBatDau:
                      DateFormat('dd-MM-yyyy - HH:mm').format(item.ngayBatDau),
                  ngayKetThuc:
                      DateFormat('dd-MM-yyyy - HH:mm').format(item.ngayKetThuc),
                  tenSanPham: item.sanPham.tenSanPham,
                  thoiGianDongEmNap: mau.thoiGianDongEmNap);
              reliCBReportListNew.add(_myReliCBReportView);
            }
          }
          reliCBReportList = reliCBReportListNew;
          yield ReliCBReportStateLoadingSuccessful(timestamp: event.timestamp);
        } else if (reliCBReportData is ErrorPackage) {
          ReliCBReportStateLoadingFailure(
              timestamp: event.timestamp,
              errorPackage: ErrorPackage(
                  errorCode: reliCBReportData.errorCode,
                  message: reliCBReportData.message,
                  detail: reliCBReportData.detail));
        } else {
          print("clgt nay");
        }
      } on SocketException {
        yield ReliCBReportStateLoadingFailure(
          errorPackage: ErrorPackage(
              errorCode: "SocketException",
              message: "Lost connection to the server",
              detail: ""),
        );
      } on TimeoutException {
        print('loi time out exception');
        yield ReliCBReportStateLoadingFailure(
          errorPackage: ErrorPackage(
              errorCode: "TimeoutException", message: "Overtime", detail: ""),
        );
        print('loi bloc');
      } catch (e) {
        print('loi bay ba');
        //Chỗ này tránh các lỗi bậy bạ
        yield ReliCBReportStateLoadingFailure(
          errorPackage: ErrorPackage(
              errorCode: "Exception", message: e.toString(), detail: ""),
        );
      }
    } else if (event is ReliCBReportEventPickDateRange) {
      final initialDateRange = DateTimeRange(
        start: DateTime.now().subtract(Duration(hours: 24 * 3)),
        end: DateTime.now(),
      );
      final newDateRange = await showDateRangePicker(
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDateRange: initialDateRange,
        context: event.context,
      );
      if (newDateRange == null) {
        yield ReliCBReportStateLoadingFailure(
            errorPackage: ErrorPackage(message: "Vui lòng chọn ngày"));
      } else {
        yield ReliCBReportStatePickDateRange(
            dateRange: newDateRange,
            getFrom: DateFormat('yyyy-MM-dd').format(newDateRange.start),
            getUntil: DateFormat('yyyy-MM-dd').format(newDateRange.end));
      }
    }
  }
}