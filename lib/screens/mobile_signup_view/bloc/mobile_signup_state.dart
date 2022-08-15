part of 'mobile_signup_bloc.dart';

abstract class MobileSignupState  {
  const MobileSignupState();

}

class MobileSignupInitial extends MobileSignupState {}

class MobileSignupLoading extends MobileSignupState {}

class MobileSignupLoaded extends MobileSignupState {}

class OtpLoaded extends MobileSignupState {
  final String otp;
  const OtpLoaded(this.otp);
}
