import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/business_logic/events/reli_monitor_event.dart';
import 'package:mobile_app/business_logic/states/reli_monitor_state.dart';

class ReliMonitorBloc extends Bloc<ReliMonitorEvent, ReliMonitorState> {
  ReliMonitorBloc() : super(ReliMonitorStateInit(timestamp: DateTime.now()));

  @override
  Stream<ReliMonitorState> mapEventToState(ReliMonitorEvent event) async* {
    if (event is ReliMonitorEventSearchingClicked) {
      try {
        yield ReliMonitorStateLoadingRequest();
      } catch (e) {}
    }
  }
}
