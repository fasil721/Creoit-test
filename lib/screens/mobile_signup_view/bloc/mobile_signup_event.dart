part of 'mobile_signup_bloc.dart';

abstract class MobileSignupEvent {
  const MobileSignupEvent();

}

class MobileNoEvent extends MobileSignupEvent {
  final String phoneNo;
  const MobileNoEvent(this.phoneNo);

}

class CheckPermissionEvent extends MobileSignupEvent {}

class OtpSentEvent extends MobileSignupEvent {
  final String verificationid;
  final String phoneNo;

  const OtpSentEvent(this.verificationid, this.phoneNo);
}

class OtPSendFailedEvent extends MobileSignupEvent {
  final String? errorMessage;
  const OtPSendFailedEvent(this.errorMessage);
}
