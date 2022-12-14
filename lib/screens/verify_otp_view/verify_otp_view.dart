import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/screens/verify_otp_view/bloc/verify_otp_bloc.dart';
import 'package:netflix_clone/theme/theme.dart';
import 'package:netflix_clone/utils/screen_sizer.dart';
import 'package:netflix_clone/widget/verify_otp_field.dart';
import 'package:netflix_clone/widget/white_space_widgets.dart';

class VerifyOtpView extends StatefulWidget {
  const VerifyOtpView({
    super.key,
    required this.verificationId,
    required this.phoneNo,
  });
  final String phoneNo;
  final String verificationId;
  @override
  State<VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppbar(),
        body: BlocBuilder<VerifyOtpBloc, VerifyOtpState>(
          builder: (context, state) => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getScreenWidthByPercentage(2.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedHeightSpace(25),
                  if (state is VerifyTheOtpState && state.isVarified)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Verified",
                              style: GoogleFonts.poppins(
                                color: NewTheme.secondaryColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 27,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  " via ",
                                  style: GoogleFonts.poppins(
                                    color: NewTheme.textColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "OTP",
                                  style: GoogleFonts.poppins(
                                    color: NewTheme.secondaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Image.asset(
                          'assets/icons/check_icon.png',
                          filterQuality: FilterQuality.high,
                          color: NewTheme.primaryColor,
                          width: 40,
                        ),
                      ],
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Waiting for \nOTP",
                          style: GoogleFonts.roboto(
                            color: NewTheme.secondaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 26,
                          ),
                        ),
                        if (state is VerifyOtpLoadingState)
                           Center(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                color: NewTheme.secondaryColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                  const SizedHeightSpace(3),
                  OtpForm(
                    phoneNo: widget.phoneNo,
                    verificationId: widget.verificationId,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  AppBar _buildAppbar() => AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Image.asset(
          'assets/icons/netflix-image.png',
          width: getScreenWidthByPercentage(20),
          filterQuality: FilterQuality.high,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Row(
              children: [
                Text(
                  'Help',
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        ],
      );
}
