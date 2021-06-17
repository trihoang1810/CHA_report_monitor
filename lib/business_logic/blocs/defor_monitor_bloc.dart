import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/business_logic/events/defor_monitor_event.dart';
import 'package:mobile_app/business_logic/states/defor_monitor_state.dart';
import 'package:mobile_app/models/deformation_monitor_data.dart';
import 'package:mobile_app/models/error_package.dart';
import 'package:mobile_app/presentation/routers/app_router.dart';

class DeforMonitorBloc extends Bloc<DeforMonitorEvent, DeforMonitorState> {
  StreamSubscription _streamSubscription;
  DeforMonitorBloc()
      : super(Defor12MonitorStateInit(
            timestamp: DateTime.now(),
            data1: "",
            data2: "",
            data3: "",
            data4: ""));

  @override
  Stream<DeforMonitorState> mapEventToState(DeforMonitorEvent event) async* {
    if (event is Defor1MonitorEventSearchingClicked) {
      try {
        yield Defor12MonitorStateLoadingRequest(timestamp: event.timestamp);
        final deforMonitorData =
            await deforMonitorRepository.loadingDeforDataRequest();
        if (deforMonitorData is DeforMonitorData) {
          yield Defor12MonitorStateLoadingSuccessful(
              deforMonitorData: deforMonitorData);
          if (_streamSubscription == null) {
            _streamSubscription ??=
                Stream.periodic(const Duration(seconds: 10), (x) => x).listen(
                    (_) => add(Defor1MonitorEventRefetchData()),
                    onError: (error) =>
                        print('Do something with period loading $error'));
          } else
            _streamSubscription.resume();
        } else if (deforMonitorData is ErrorPackage) {
          await _streamSubscription?.cancel();
          _streamSubscription = null;
          yield Defor12MonitorStateLoadingFail(
              timestamp: event.timestamp, errorPackage: deforMonitorData);
        } else {
          print(deforMonitorData.toString());
          yield Defor12MonitorStateLoadingFail(
              timestamp: event.timestamp,
              errorPackage: ErrorPackage(
                  message: "Có lỗi xảy ra", detail: "vui lòng thử lại"));
          await _streamSubscription?.cancel();
          _streamSubscription = null;
          print('Lỗi bậy bạ 1');
        }
      } on SocketException {
        print("Lỗi socket");
        await _streamSubscription?.cancel();
        _streamSubscription = null;
        yield Defor12MonitorStateLoadingFail(
          errorPackage: new ErrorPackage(
              errorCode: "SocketException",
              message: "Lost connection to the server",
              detail: ""),
        );
      } on TimeoutException {
        await _streamSubscription?.cancel();
        _streamSubscription = null;
        print('loi time out exception');
        yield Defor12MonitorStateLoadingFail(
          errorPackage: new ErrorPackage(
              errorCode: "TimeoutException", message: "Overtime", detail: ""),
        );
      } catch (e) {
        print("Lỗi e");
        await _streamSubscription?.cancel();
        _streamSubscription = null;
        yield Defor12MonitorStateLoadingFail(
            errorPackage: ErrorPackage(
                errorCode: "Exception", message: "", detail: e.toString()));
      }
    } else if (event is Defor1MonitorEventRefetchData) {
      try {
        final deforMonitorData =
            await deforMonitorRepository.loadingDeforDataRequest();
        if (deforMonitorData is DeforMonitorData) {
          yield Defor12MonitorStateLoadingSuccessful(
              deforMonitorData: deforMonitorData);
          if (_streamSubscription == null) {
            _streamSubscription ??=
                Stream.periodic(const Duration(seconds: 10), (x) => x).listen(
                    (_) => add(Defor1MonitorEventRefetchData()),
                    onError: (error) =>
                        print('Do something with period loading $error'));
          } else
            _streamSubscription.resume();
        } else if (event is ErrorPackage) {
          await _streamSubscription?.cancel();
          _streamSubscription = null;
          yield Defor12MonitorStateLoadingFail(
              timestamp: event.timestamp, errorPackage: deforMonitorData);
        } else {
          print(deforMonitorData.toString());
          yield Defor12MonitorStateLoadingFail(
              timestamp: event.timestamp,
              errorPackage: ErrorPackage(
                  message: "Có lỗi xảy ra", detail: "vui lòng thử lại"));
          await _streamSubscription?.cancel();
          _streamSubscription = null;
          print('Lỗi bậy bạ 12');
        }
      } on SocketException {
        print("Lỗi socket");
        await _streamSubscription?.cancel();
        _streamSubscription = null;
        yield Defor12MonitorStateLoadingFail(
          errorPackage: new ErrorPackage(
              errorCode: "SocketException",
              message: "Lost connection to the server",
              detail: ""),
        );
      } on TimeoutException {
        await _streamSubscription?.cancel();
        _streamSubscription = null;
        print('loi time out exception');
        yield Defor12MonitorStateLoadingFail(
          errorPackage: new ErrorPackage(
              errorCode: "TimeoutException", message: "Overtime", detail: ""),
        );
      } catch (e) {
        print("Lỗi e");
        await _streamSubscription?.cancel();
        _streamSubscription = null;
        yield Defor12MonitorStateLoadingFail(
            errorPackage: ErrorPackage(
                errorCode: "Exception", message: "", detail: e.toString()));
      }
    } else if (event is Defor1MonitorEventCancelRefetchData) {
      _streamSubscription?.cancel();
    }
  }

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    _streamSubscription = null;
  }
}
