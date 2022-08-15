import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:netflix_clone/screens/home/home.dart';
import 'package:netflix_clone/utils/utils.dart';

part 'verify_otp_event.dart';
part 'verify_otp_state.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  VerifyOtpBloc() : super(VerifyOtpInitial()) {
    on<VerifyTheOtpEvent>(_verifyOtp);
    on<AutoFillOtpEvent>(
      (event, emit) {
        log("misson success otp is ${event.otp}");
        if (event.otp != null && event.otp!.length == 6) {
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
      final credential = PhoneAuthProvider.credential(
        verificationId: event.verificationId,
        smsCode: event.otp,
      );
      await auth.signInWithCredential(credential);
      emit(const VerifyTheOtpState(isVarified: true));
      await Future.delayed(const Duration(seconds: 1));

      Get.to(() => const HomePage());
    } on FirebaseAuthException {
      Utils.showErrorSnackBar("Invalid Otp");
      emit(const VerifyTheOtpState(isVarified: false));
    } catch (e) {
      emit(const VerifyTheOtpState(isVarified: false));
      Utils.showErrorSnackBar("Something went wrong");
      log('error : $e');
    }
  }
}
