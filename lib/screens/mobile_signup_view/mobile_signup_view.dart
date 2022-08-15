import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/screens/mobile_signup_view/bloc/mobile_signup_bloc.dart';
import 'package:netflix_clone/theme/theme.dart';
import 'package:netflix_clone/utils/screen_sizer.dart';
import 'package:netflix_clone/utils/utils.dart';
import 'package:netflix_clone/widget/white_space_widgets.dart';

class MobileSignUpView extends StatefulWidget {
  const MobileSignUpView({super.key});

  @override
  State<MobileSignUpView> createState() => _MobileSignUpViewState();
}

class _MobileSignUpViewState extends State<MobileSignUpView> {
  final phoneNoTextController = TextEditingController();
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
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
        ),
        body: BlocBuilder<MobileSignupBloc, MobileSignupState>(
          builder: (context, state) => SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildNoField(context),
                const SizedHeightSpace(3),
                GestureDetector(
                  onTap: state is! MobileSignupLoading
                      ? () {
                          BlocProvider.of<MobileSignupBloc>(context).add(
                            MobileNoEvent(phoneNoTextController.text),
                          );
                        }
                      : null,
                  child: Container(
                    height: getScreenHeightByPercentage(7),
                    margin: EdgeInsets.symmetric(
                      horizontal: getScreenWidthByPercentage(10),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (state is MobileSignupLoading)
                          Utils.buttonLoader(
                            getScreenWidthByPercentage(8),
                          )
                        else ...[
                          Center(
                            child: Text(
                              'Sign In',
                              style: GoogleFonts.rubik(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedHeightSpace(4),
                Center(
                  child: Text(
                    'Recover Password',
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedHeightSpace(4),
                Center(
                  child: Text(
                    "Sign in is protected by Google reCAPTCHA to\nensure you're notabot. Learn more.",
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      color: NewTheme.textColor,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  // final phoneNoTextController = TextEditingController();
  // @override
  // Widget build(BuildContext context) => AnnotatedRegion(
  //       value: Utils.setUiOverlayStyle(),
  //       child: Scaffold(
  //         body: BlocBuilder<MobileSignupBloc, MobileSignupState>(
  //           builder: (context, state) => SafeArea(
  //             child: SingleChildScrollView(
  //               child: Column(
  //                 children: [
  //                   const SizedHeightSpace(4),
  //                   const Text(
  //                     "Sign up or Log in",
  //                     style: TextStyle(
  //                       // fontFamily: Constants.primaryFont,
  //                       color: NewTheme.secondaryColor,
  //                       fontWeight: FontWeight.w300,
  //                       fontSize: 21,
  //                     ),
  //                   ),
  //                   const SizedHeightSpace(3),
  //                   _buildNoField(context),
  //                   const SizedHeightSpace(3),
  //                   _buildSendOtpButton(context, state)
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     );

  Row _buildSendOtpButton(BuildContext context, MobileSignupState state) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: getScreenHeightByPercentage(6.5),
            width: getScreenWidthByPercentage(15),
            child: ElevatedButton(
              onPressed: state is! MobileSignupLoading
                  ? () {
                      BlocProvider.of<MobileSignupBloc>(context).add(
                        MobileNoEvent(phoneNoTextController.text),
                      );
                    }
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state is MobileSignupLoading)
                    Utils.buttonLoader(
                      getScreenWidthByPercentage(4.5),
                    )
                  else ...[
                    Text(
                      "Send ",
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "OTP",
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    )
                  ]
                ],
              ),
            ),
          ),
        ],
      );

  Container _buildNoField(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: NewTheme.formFieldColor,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: getScreenWidthByPercentage(10),
        ),
        child: TextField(
          controller: phoneNoTextController,
          textInputAction: TextInputAction.done,
          style: GoogleFonts.roboto(color: NewTheme.secondaryColor),
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp("[0-9]"),
            ),
          ],
          onSubmitted: (value) =>
              BlocProvider.of<MobileSignupBloc>(context).add(
            MobileNoEvent(value),
          ),
          keyboardType: TextInputType.phone,
          textAlign: TextAlign.center,
          maxLength: 10,
          decoration: InputDecoration(
            counterText: '',
            border: InputBorder.none,
            isDense: true,
            contentPadding: const EdgeInsets.all(20),
            labelStyle: const TextStyle(fontSize: 14),
            hintText: 'Enter your phone number',
            hintStyle: GoogleFonts.inter(
              color: NewTheme.secondaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      );
}
