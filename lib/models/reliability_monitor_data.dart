import 'package:equatable/equatable.dart';

class ReliMonitorData extends Equatable {
  ReliMonitorData({
    this.id,
    this.close,
    this.open,
    this.welcomeSet,
    this.moment,
    this.warning,
    this.running,
  });

  String id;
  String close;
  String open;
  String welcomeSet;
  String moment;
  bool warning;
  bool running;
  @override
  List<Object> get props => [
        this.id,
        this.close,
        this.open,
        this.welcomeSet,
        this.moment,
        this.warning,
        this.running,
      ];
  factory ReliMonitorData.fromJson(Map<String, dynamic> json) =>
      ReliMonitorData(
        id: json["id"],
        close: json["close"],
        open: json["open"],
        welcomeSet: json["set"],
        moment: json["moment"],
        warning: json["warning"],
        running: json["running"],
      );
}
