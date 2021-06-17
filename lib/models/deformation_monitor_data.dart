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

  final noPressPv1;
  final noPressPv2;
  final noPressPv3;
  final noPressSp12;
  final noPressSp3;
  final errorCode;
  final modeStatus;
  final forceCylinderSp12;
  final forceCylinderSp3;
  final timeHoldSp12;
  final timeHoldSp3;
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
  factory DeforMonitorData.fromJson(Map<String, dynamic> json) =>
      DeforMonitorData(
        noPressPv1: json["numberOfTestPv1"],
        noPressPv2: json["numberOfTestPv2"],
        noPressPv3: json["numberOfTestPv3"],
        noPressSp12: json["numberOfTestSp12"],
        noPressSp3: json["numberOfTestSp3"],
        errorCode: json["errorCode"],
        modeStatus: json["modeStatus"],
        forceCylinderSp12: json["forceCylinderSp12"],
        forceCylinderSp3: json["forceCylinderSp3"],
        timeHoldSp12: json["timeHoldSp12"],
        timeHoldSp3: json["timeHoldSp3"],
        seclect1: json["seclect1"],
        seclect2: json["seclect2"],
        redStatus: json["redStatus"],
        greenStatus: json["greenStatus"],
        errorStatus: json["errorStatus"],
      );
}
