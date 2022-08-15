part of 'verify_otp_bloc.dart';

abstract class VerifyOtpEvent {
  const VerifyOtpEvent();
}

class VerifyTheOtpEvent extends VerifyOtpEvent {
  const VerifyTheOtpEvent(this.phoneNo, this.otp, this.verificationId);
  final String otp;
  final String phoneNo;
  final String verificationId;
}

class AutoFillOtpEvent extends VerifyOtpEvent {
  final String? otp;

  const AutoFillOtpEvent(this.otp);
}
