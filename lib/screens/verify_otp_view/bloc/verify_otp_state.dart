part of 'verify_otp_bloc.dart';

abstract class VerifyOtpState {
  const VerifyOtpState();
}

class VerifyOtpInitial extends VerifyOtpState {}

class VerifyTheOtpState extends VerifyOtpState {
  const VerifyTheOtpState({required this.isVarified});
  final bool isVarified;
}

class VerifyOtpLoadingState extends VerifyOtpState {}

class OtpLoadedState extends VerifyOtpState {
  final String otp;

  const OtpLoadedState(this.otp);
}
