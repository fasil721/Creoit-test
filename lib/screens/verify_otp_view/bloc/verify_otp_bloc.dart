import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:netflix_clone/screens/root_page/root_page.dart';
import 'package:netflix_clone/utils/utils.dart';

part 'verify_otp_event.dart';
part 'verify_otp_state.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  VerifyOtpBloc() : super(VerifyOtpInitial()) {
    on<VerifyTheOtpEvent>(_verifyOtp);
    on<AutoFillOtpEvent>(
      (event, emit) {
        //auto filling the otp code
        log("misson success otp is ${event.otp}");
        if (event.otp != null && event.otp!.length == 6) {
          //updating the ui with otp
          emit(OtpLoadedState(event.otp!));
        }
      },
    );
  }

  Future<void> _verifyOtp(
    VerifyTheOtpEvent event,
    Emitter<VerifyOtpState> emit,
  ) async {
    emit(VerifyOtpLoadingState());
    final auth = FirebaseAuth.instance;
    try {
      //checking the given otp valid or not
      final credential = PhoneAuthProvider.credential(
        verificationId: event.verificationId,
        smsCode: event.otp,
      );
      //saving user credential to the firebase
      await auth.signInWithCredential(credential);
      //its for showing a verified check ui
      emit(const VerifyTheOtpState(isVarified: true));
      await Future.delayed(const Duration(seconds: 1));
      //redirecting user to the rootpage 
      Get.offAll(() => const RootPage());
    } on FirebaseAuthException {
      //it will if otp is not valid
      Utils.showErrorSnackBar("Invalid Otp");
      emit(const VerifyTheOtpState(isVarified: false));
    } catch (e) {
      emit(const VerifyTheOtpState(isVarified: false));
      Utils.showErrorSnackBar("Something went wrong");
      log('error : $e');
    }
  }
}
