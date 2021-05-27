import 'package:equatable/equatable.dart';

class ReliCBMonitorData extends Equatable {
  ReliCBMonitorData({
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
  int welcomeSet;
  int moment;
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
  factory ReliCBMonitorData.fromJson(Map<String, dynamic> json) =>
      ReliCBMonitorData(
        id: json["id"],
        close: json["close"],
        open: json["open"],
        welcomeSet: json["set"],
        moment: json["moment"],
        warning: json["warning"],
        running: json["running"],
      );
}
