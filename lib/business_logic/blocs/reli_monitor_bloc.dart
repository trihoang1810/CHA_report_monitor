import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/business_logic/events/reli_monitor_event.dart';
import 'package:mobile_app/business_logic/states/reli_monitor_state.dart';
import 'package:mobile_app/models/error_package.dart';
import 'package:mobile_app/models/reliability_cb_monitor_data.dart';
import 'package:mobile_app/models/reliability_monitor_data.dart';
import 'package:mobile_app/presentation/routers/app_router.dart';

class ReliMonitorBloc extends Bloc<ReliMonitorEvent, ReliMonitorState> {
  StreamSubscription _periodicSubscription;
  StreamSubscription _periodicSubscription1;
  ReliMonitorBloc()
      : super(ReliMonitorStateInit(
            timestamp: DateTime.now(),
            data1: "null",
            data2: "null",
            data3: "null",
            data4: "null"));
  @override
  Stream<ReliMonitorState> mapEventToState(ReliMonitorEvent event) async* {
    if (event is ReliMonitorEventSearchingClicked) {
      try {
        yield ReliMonitorStateLoadingRequest(timestamp: event.timestamp);

        final reliMonitorData =
            await reliMonitorRepository.loadingReliDataRequest();
        if (reliMonitorData is ReliMonitorData) {
          yield ReliMonitorStateLoadingSuccessful(
              timestamp: event.timestamp, reliMonitorData: reliMonitorData);
          if (_periodicSubscription == null) {
            _periodicSubscription ??=
                Stream.periodic(const Duration(seconds: 5), (x) => x).listen(
                    (_) => add(ReliMonitorEventRefetchData()),
                    onError: (error) => print("Do something with $error"));
          } else {
            _periodicSubscription.resume();
          }
          // Stream.periodic(const Duration(seconds: 5), (x) => x)
          //     .listen((_) => add(ReliMonitorEventRefetchData()));
        } else if (reliMonitorData is ErrorPackage) {
          print('thất bại');
          await _periodicSubscription?.cancel();
          _periodicSubscription = null;
          yield ReliMonitorStateLoadingFailure(
              timestamp: event.timestamp, errorPackage: reliMonitorData);
        } else {
          yield ReliMonitorStateLoadingFailure(
              timestamp: event.timestamp,
              errorPackage: ErrorPackage(
                  message: "Có lỗi xảy ra", detail: "vui lòng thử lại"));
          await _periodicSubscription?.cancel();
          _periodicSubscription = null;
          print('Lỗi bậy bạ');
        }
      } on SocketException {
        print("Lỗi socket");
        await _periodicSubscription?.cancel();
        _periodicSubscription = null;
        yield ReliMonitorStateLoadingFailure(
          errorPackage: new ErrorPackage(
              errorCode: "SocketException",
              message: "Lost connection to the server",
              detail: ""),
        );
      } on TimeoutException {
        await _periodicSubscription?.cancel();
        _periodicSubscription = null;
        print('loi time out exception');
        yield ReliMonitorStateLoadingFailure(
          errorPackage: new ErrorPackage(
              errorCode: "TimeoutException", message: "Overtime", detail: ""),
        );
      } catch (e) {
        print("Lỗi e");
        await _periodicSubscription?.cancel();
        _periodicSubscription = null;
        yield ReliMonitorStateLoadingFailure(
            errorPackage: ErrorPackage(
                errorCode: "Exception", message: "", detail: e.toString()));
      }
    } else if (event is ReliMonitorEventRefetchData) {
      try {
        final reliMonitorRefetchData =
            await reliMonitorRepository.loadingReliDataRequest();
        if (reliMonitorRefetchData is ReliMonitorData) {
          print('refetch thanh cong');
          yield ReliMonitorStateLoadingRefetchSuccessful(
              timestamp: event.timestamp,
              reliMonitorData: reliMonitorRefetchData);
          if (_periodicSubscription == null) {
            _periodicSubscription ??=
                Stream.periodic(const Duration(seconds: 5), (x) => x).listen(
                    (_) => add(ReliMonitorEventRefetchData()),
                    onError: (error) => print("Do something with $error"));
          } else {
            _periodicSubscription.resume();
          }
        } else if (reliMonitorRefetchData is ErrorPackage) {
          print("loi error package refetch");
          await _periodicSubscription?.cancel();
          _periodicSubscription = null;
          yield ReliMonitorStateLoadingRefetchFailure(
              timestamp: event.timestamp, errorPackage: reliMonitorRefetchData);
        }
      } on SocketException {
        print("Lỗi socket");
        await _periodicSubscription?.cancel();
        _periodicSubscription = null;
        yield ReliMonitorStateLoadingRefetchFailure(
          errorPackage: new ErrorPackage(
              errorCode: "SocketException",
              message: "Lost connection to the server",
              detail: ""),
        );
      } on TimeoutException {
        print('loi time out exception');
        await _periodicSubscription?.cancel();
        _periodicSubscription = null;
        yield ReliMonitorStateLoadingRefetchFailure(
          errorPackage: new ErrorPackage(
              errorCode: "TimeoutException", message: "Overtime", detail: ""),
        );
      } catch (e) {
        print("loi catch refetch");
        await _periodicSubscription?.cancel();
        _periodicSubscription = null;
        yield ReliMonitorStateLoadingRefetchFailure(
            errorPackage: ErrorPackage(
                errorCode: "Exception", message: "", detail: e.toString()));
      }
    } else if (event is ReliMonitorEventCancelRefetchData) {
      yield ReliMonitorStateCancelLoadingRefetch(
          timestamp: event.timestamp, errorPackage: ErrorPackage());
      _periodicSubscription?.cancel();
    } else if (event is ReliCBMonitorEventSearchingClicked) {
      try {
        yield ReliCBMonitorStateLoadingRequest(timestamp: event.timestamp);
        final reliCBMonitorData =
            await reliCBMonitorRepository.loadingReliCBDataRequest();
        if (reliCBMonitorData is ReliCBMonitorData) {
          print('moment là ${reliCBMonitorData.soLanDongNapHienTai}');
          yield ReliCBMonitorStateLoadingSuccessful(
              timestamp: event.timestamp, reliCBMonitorData: reliCBMonitorData);
          if (_periodicSubscription1 == null) {
            _periodicSubscription1 ??=
                Stream.periodic(const Duration(seconds: 5), (x) => x).listen(
                    (_) => add(ReliCBMonitorEventRefetchData()),
                    onError: (error) => print("Do something with $error"));
          } else {
            _periodicSubscription1.resume();
          }
        } else if (reliCBMonitorData is ErrorPackage) {
          print('thất bại');
          yield ReliCBMonitorStateLoadingFailure(
              timestamp: event.timestamp, errorPackage: reliCBMonitorData);
        } else {
          print('Lỗi bậy bạ');
          throw SocketException("Lỗi bậy bạ");
        }
      } on SocketException {
        print("Lỗi socket");
        yield ReliCBMonitorStateLoadingFailure(
          errorPackage: new ErrorPackage(
              errorCode: "SocketException",
              message: "Lost connection to the server",
              detail: ""),
        );
      } on TimeoutException {
        print('loi time out exception');
        yield ReliCBMonitorStateLoadingFailure(
          errorPackage: new ErrorPackage(
              errorCode: "TimeoutException", message: "Overtime", detail: ""),
        );
      } catch (e) {
        print("Lỗi e");
        yield ReliCBMonitorStateLoadingFailure(
            errorPackage: ErrorPackage(
                errorCode: "Exception", message: "", detail: e.toString()));
      }
    } else if (event is ReliCBMonitorEventRefetchData) {
      try {
        final reliCBMonitorRefetchData =
            await reliCBMonitorRepository.loadingReliCBDataRequest();
        if (reliCBMonitorRefetchData is ReliCBMonitorData) {
          print('refetch thanh cong');
          yield ReliCBMonitorStateLoadingRefetchSuccessful(
              timestamp: event.timestamp,
              reliCBMonitorData: reliCBMonitorRefetchData);
          if (_periodicSubscription1 == null) {
            _periodicSubscription1 ??=
                Stream.periodic(const Duration(seconds: 5), (x) => x).listen(
                    (_) => add(ReliCBMonitorEventRefetchData()),
                    onError: (error) => print("Do something with $error"));
          } else {
            _periodicSubscription1.resume();
          }
        } else if (reliCBMonitorRefetchData is ErrorPackage) {
          print("loi error package refetch");
          yield ReliMonitorStateLoadingRefetchFailure(
              timestamp: event.timestamp,
              errorPackage: reliCBMonitorRefetchData);
        }
      } on SocketException {
        print("Lỗi socket");
        yield ReliCBMonitorStateLoadingRefetchFailure(
          errorPackage: new ErrorPackage(
              errorCode: "SocketException",
              message: "Lost connection to the server",
              detail: ""),
        );
      } on TimeoutException {
        print('loi time out exception');
        yield ReliCBMonitorStateLoadingRefetchFailure(
          errorPackage: new ErrorPackage(
              errorCode: "TimeoutException", message: "Overtime", detail: ""),
        );
      } catch (e) {
        print("loi catch refetch");
        _periodicSubscription.pause();
        yield ReliCBMonitorStateLoadingRefetchFailure(
            errorPackage: ErrorPackage(
                errorCode: "Exception", message: "", detail: e.toString()));
      }
    } else if (event is ReliCBMonitorEventCancelRefetchData) {
      yield ReliCBMonitorStateCancelLoadingRefetch(
          timestamp: event.timestamp, errorPackage: ErrorPackage());
      _periodicSubscription?.cancel();
    }
  }

  @override
  Future<void> close() async {
    await _periodicSubscription?.cancel();
    _periodicSubscription = null;
    await _periodicSubscription1?.cancel();
    _periodicSubscription1 = null;
    return super.close();
  }
}
