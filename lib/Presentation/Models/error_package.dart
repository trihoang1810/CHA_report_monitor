import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ErrorPackage extends Equatable {
  String errorCode;
  String message;
  String detail;
  ErrorPackage({this.errorCode, this.message, this.detail});
  @override
  // TODO: implement props
  List<Object> get props => [errorCode, message, detail];

  factory ErrorPackage.fromJson(dynamic jsonObject) {
    return ErrorPackage(
        errorCode: jsonObject['errorCode'],
        message: jsonObject['message'],
        detail: jsonObject['detail']);
  }
}
