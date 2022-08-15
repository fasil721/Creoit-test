import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/screens/verify_otp_view/bloc/verify_otp_bloc.dart';
import 'package:netflix_clone/theme/theme.dart';
import 'package:netflix_clone/utils/screen_sizer.dart';
import 'package:netflix_clone/widget/white_space_widgets.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({
    super.key,
    required this.verificationId,
    required this.phoneNo,
  });

  final String phoneNo;
  final String verificationId;

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final pin1TextController = TextEditingController();
  final pin2TextController = TextEditingController();
  final pin3TextController = TextEditingController();
  final pin4TextController = TextEditingController();
  final pin5TextController = TextEditingController();
  final pin6TextController = TextEditingController();
  late FocusNode pin1FocusNode;
  late FocusNode pin2FocusNode;
  late FocusNode pin3FocusNode;
  late FocusNode pin4FocusNode;
  late FocusNode pin5FocusNode;
  late FocusNode pin6FocusNode;

  @override
  void initState() {
    pin1FocusNode = FocusNode();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    pin1FocusNode.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin5FocusNode.dispose();
    pin6FocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedHeightSpace(2),
          BlocBuilder<VerifyOtpBloc, VerifyOtpState>(
            builder: (context, state) {
              final bloc = context.read<VerifyOtpBloc>();
              _checkOtpLoaded(state, bloc);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildOtpField(
                    textEditingController: pin1TextController,
                    focusNode: pin1FocusNode,
                    onChanged: (value) {
                      if (value.length == 1) {
                        pin2FocusNode.requestFocus();
                      } else if (value.isEmpty) {
                        pin1FocusNode.unfocus();
                      }
                      checkIsOtpValid(bloc);
                    },
                  ),
                  _buildOtpField(
                    textEditingController: pin2TextController,
                    focusNode: pin2FocusNode,
                    onChanged: (value) {
                      if (value.length == 1) {
                        pin3FocusNode.requestFocus();
                      } else if (value.isEmpty) {
                        pin1FocusNode.requestFocus();
                      }
                      checkIsOtpValid(bloc);
                    },
                  ),
                  _buildOtpField(
                    textEditingController: pin3TextController,
                    focusNode: pin3FocusNode,
                    onChanged: (value) {
                      if (value.length == 1) {
                        pin4FocusNode.requestFocus();
                      } else if (value.isEmpty) {
                        pin2FocusNode.requestFocus();
                      }
                      checkIsOtpValid(bloc);
                    },
                  ),
                  _buildOtpField(
                    textEditingController: pin4TextController,
                    focusNode: pin4FocusNode,
                    onChanged: (value) {
                      if (value.length == 1) {
                        pin5FocusNode.requestFocus();
                      } else if (value.isEmpty) {
                        pin3FocusNode.requestFocus();
                      }
                      checkIsOtpValid(bloc);
                    },
                  ),
                  _buildOtpField(
                    textEditingController: pin5TextController,
                    focusNode: pin5FocusNode,
                    onChanged: (value) {
                      if (value.length == 1) {
                        pin6FocusNode.requestFocus();
                      } else if (value.isEmpty) {
                        pin4FocusNode.requestFocus();
                      }
                      checkIsOtpValid(bloc);
                    },
                  ),
                  _buildOtpField(
                    textEditingController: pin6TextController,
                    focusNode: pin6FocusNode,
                    onChanged: (value) {
                      if (value.length == 1) {
                        pin6FocusNode.unfocus();
                      } else if (value.isEmpty) {
                        pin5FocusNode.requestFocus();
                      }
                      checkIsOtpValid(bloc);
                    },
                  ),
                ],
              );
            },
          ),
        ],
      );

  void _checkOtpLoaded(VerifyOtpState state, VerifyOtpBloc bloc) {
    if (state is OtpLoadedState) {
      pin1TextController.text = state.otp[0];
      pin2TextController.text = state.otp[1];
      pin3TextController.text = state.otp[2];
      pin4TextController.text = state.otp[3];
      pin5TextController.text = state.otp[4];
      pin6TextController.text = state.otp[5];
      bloc.add(
        VerifyTheOtpEvent(widget.phoneNo, state.otp, widget.verificationId),
      );
    }
  }

  void checkIsOtpValid(VerifyOtpBloc bloc) {
    final pin1 = pin1TextController.text.trim();
    final pin2 = pin2TextController.text.trim();
    final pin3 = pin3TextController.text.trim();
    final pin4 = pin4TextController.text.trim();
    final pin5 = pin5TextController.text.trim();
    final pin6 = pin6TextController.text.trim();
    final isValid = pin1.isNotEmpty &&
        pin2.isNotEmpty &&
        pin3.isNotEmpty &&
        pin4.isNotEmpty &&
        pin5.isNotEmpty &&
        pin6.isNotEmpty;

    if (isValid) {
      final otp = pin1 + pin2 + pin3 + pin4 + pin5 + pin6;
      bloc.add(VerifyTheOtpEvent(widget.phoneNo, otp, widget.verificationId));
    }
  }

  Container _buildOtpField({
    required FocusNode focusNode,
    required TextEditingController textEditingController,
    bool autofocus = false,
    required Function(String)? onChanged,
  }) =>
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: NewTheme.formFieldColor,
        ),
        width: getScreenWidthByPercentage(14),
        child: TextFormField(
          controller: textEditingController,
          focusNode: focusNode,
          autofocus: autofocus,
          maxLength: 1,
          style:  TextStyle(fontSize: 20, color: NewTheme.secondaryColor),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          decoration: otpInputDecoration,
          onChanged: onChanged,
        ),
      );

  final otpInputDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(
      vertical: getScreenHeightByPercentage(1.25),
    ),
    border: _outlineInputBorder(),
    counterText: '',
    hintText: "-",
    hintStyle: const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 25,
      color: NewTheme.textColor,
    ),
    focusedBorder: _outlineInputBorder(),
    enabledBorder: _outlineInputBorder(),
  );
}

OutlineInputBorder _outlineInputBorder() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    );
