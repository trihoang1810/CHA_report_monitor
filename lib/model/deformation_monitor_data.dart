import 'package:equatable/equatable.dart';

class DeforMonitorData extends Equatable {
  DeforMonitorData({
    this.noPressPv1,
    this.noPressPv2,
    this.noPressPv3,
    this.noPressSp12,
    this.noPressSp3,
    this.errorCode,
    this.modeStatus,
    this.forceCylinderSp12,
    this.forceCylinderSp3,
    this.timeHoldSp12,
    this.timeHoldSp3,
    this.seclect1,
    this.seclect2,
    this.redStatus,
    this.greenStatus,
    this.errorStatus,
  });

  int noPressPv1;
  int noPressPv2;
  int noPressPv3;
  int noPressSp12;
  int noPressSp3;
  int errorCode;
  int modeStatus;
  String forceCylinderSp12;
  String forceCylinderSp3;
  String timeHoldSp12;
  String timeHoldSp3;
  bool seclect1;
  bool seclect2;
  bool redStatus;
  bool greenStatus;
  bool errorStatus;
  @override
  List<Object> get props => [
        noPressPv1,
        noPressPv2,
        noPressPv3,
        noPressSp12,
        noPressSp3,
        errorCode,
        modeStatus,
        forceCylinderSp12,
        forceCylinderSp3,
        timeHoldSp12,
        timeHoldSp3,
        seclect1,
        seclect2,
        redStatus,
        greenStatus,
        errorStatus
      ];
}
