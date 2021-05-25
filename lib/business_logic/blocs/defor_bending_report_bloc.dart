import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/business_logic/events/defor_report_event.dart';
import 'package:mobile_app/business_logic/states/defor_report_state.dart';
import 'package:mobile_app/models/deformation_bending_data.dart';
import 'package:mobile_app/models/deformation_rocktest_data.dart';
import 'package:mobile_app/models/deformation_staticload_data.dart';
import 'package:mobile_app/models/error_package.dart';
import 'package:mobile_app/presentation/routers/app_router.dart';

class DeforReportBloc extends Bloc<DeforReportEvent, DeforReportState> {
  DeforReportBloc()
      : super(DeforBendingReportStateInit(timestamp: DateTime.now()));

  @override
  Stream<DeforReportState> mapEventToState(DeforReportEvent event) async* {
    if (event is DeforBendingReportEventSearchingClicked) {
      yield DeforBendingReportStateLoadingRequest();
      try {
        final List deforBendingReportData =
            await deforBendingReportRepository.loadingDeforBendingDataRequest();
        if (deforBendingReportData is List<DeforBendingReport>) {
          yield DeforBendingReportStateLoadingSuccessful(
              timestamp: event.timestamp);
        } else if (deforBendingReportData is ErrorPackage) {
          yield DeforBendingReportStateLoadingFailure(
              timestamp: event.timestamp,
              errorPackage: ErrorPackage(
                  errorCode: deforBendingReportData[0].errorCode,
                  message: deforBendingReportData[0].message,
                  detail: deforBendingReportData[0].detail));
        } else {
          print("vcl");
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
            detail: "",
          ),
        );
      }
      //static_load_bloc
    } else if (event is DeforStaticReportEventSearchingClicked) {
      yield DeforStaticReportStateLoadingRequest();
      try {
        final List deforStaticReportData =
            await deforStaticReportRepository.loadingDeforStaticDataRequest();
        if (deforStaticReportData is List<DeforStaticReport>) {
          yield DeforStaticReportStateLoadingSuccessful(
              timestamp: event.timestamp);
        } else if (deforStaticReportData is ErrorPackage) {
          yield DeforStaticReportStateLoadingFailure(
              timestamp: event.timestamp,
              errorPackage: ErrorPackage(
                  errorCode: deforStaticReportData[0].errorCode,
                  message: deforStaticReportData[0].message,
                  detail: deforStaticReportData[0].detail));
        } else {
          print("vcl");
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
            detail: "",
          ),
        );
      }
    }
    // rock_test_bloc
    else if (event is DeforRockReportEventSearchingClicked) {
      yield DeforRockReportStateLoadingRequest();
      try {
        final List deforRockReportData =
            await deforRockReportRepository.loadingDeforRockDataRequest();
        if (deforRockReportData is List<DeforRockReport>) {
          yield DeforRockReportStateLoadingSuccessful(
              timestamp: event.timestamp);
        } else if (deforRockReportData is ErrorPackage) {
          yield DeforRockReportStateLoadingFailure(
              timestamp: event.timestamp,
              errorPackage: ErrorPackage(
                  errorCode: deforRockReportData[0].errorCode,
                  message: deforRockReportData[0].message,
                  detail: deforRockReportData[0].detail));
        } else {
          print("vcl1");
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
            detail: "",
          ),
        );
      }
    }
  }
}
