import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:netflix_clone/screens/verify_otp_view/bloc/verify_otp_bloc.dart';
import 'package:netflix_clone/screens/verify_otp_view/verify_otp_view.dart';
import 'package:netflix_clone/utils/utils.dart';

part 'mobile_signup_event.dart';
part 'mobile_signup_state.dart';

class MobileSignupBloc extends Bloc<MobileSignupEvent, MobileSignupState> {
  final VerifyOtpBloc verifyOtpBloc;
  MobileSignupBloc(this.verifyOtpBloc) : super(MobileSignupInitial()) {
    on<MobileNoEvent>(_sendOtp);

    on<OtpSentEvent>((event, emit) async {
      //redirecting page to verify otp view after otp sent
      Get.to(
        () => VerifyOtpView(
          phoneNo: event.phoneNo,
          verificationId: event.verificationid,
        ),
      );
      emit(MobileSignupLoaded());
    });

    on<OtPSendFailedEvent>((event, emit) {
      //notifying error to the user 
      if (event.errorMessage != null) {
        Utils.showErrorSnackBar(event.errorMessage!);
      }
      emit(MobileSignupLoaded());
    });
  }

  Future<void> _sendOtp(
    MobileNoEvent event,
    Emitter<MobileSignupState> emit,
  ) async {
    if (state is! MobileSignupLoading) {
      //validating the user entered phone no is it valid or not
      final isValid = _validatePhoneNo(event.phoneNo);
      if (isValid) {
        emit(MobileSignupLoading());
        try {
          //verifying the user using firebase mobile auth service
          await FirebaseAuth.instance.verifyPhoneNumber(
            timeout: const Duration(seconds: 60),
            phoneNumber: "+91 ${event.phoneNo}",
            verificationCompleted: (PhoneAuthCredential credential) {
              //trigger a event to auto fill the resieved otp
              verifyOtpBloc.add(AutoFillOtpEvent(credential.smsCode));
            },
            verificationFailed: (err) {
              //triggering fail event
              add(OtPSendFailedEvent(err.message));
            },
            codeSent: (verificationid, resendToken) {
              //triggering event after sent otp
              add(OtpSentEvent(verificationid, event.phoneNo));
            },
            codeAutoRetrievalTimeout: (verificationID) {},
          );
        } catch (e) {
          emit(MobileSignupLoaded());
          Utils.showErrorSnackBar("Something went wrong");
          log("Error $e");
        }
      }
    }
  }

  bool _validatePhoneNo(String phoneNo) {
    if (phoneNo.trim().isEmpty) {
      Utils.showErrorSnackBar('Phone number is required');
      return false;
    } else if (phoneNo.trim().length != 10) {
      Utils.showErrorSnackBar('Enter 10 digit number');
      return false;
    }
    return true;
  }
}
