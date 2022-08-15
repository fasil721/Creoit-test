// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:netflix_clone/services/tmdb_service.dart';
import 'package:netflix_clone/theme/theme.dart';

class Utils {
  //snackbar global key
  static final snackbarKey = GlobalKey<ScaffoldMessengerState>();

  //loader for button
  static SizedBox buttonLoader(double width) => SizedBox(
        width: width,
        child: LoadingIndicator(
          indicatorType: Indicator.ballPulse,
          colors: [NewTheme.secondaryColor],
          strokeWidth: 2,
        ),
      );

  // collecting date format from given string date format
  static String datePicker(String date) {
    final temp = date.split("");
    final String day = temp[8] + temp[9];
    final String month = temp[5] + temp[6];
    if (month == "01") {
      return "$day January";
    } else if (month == "02") {
      return "$day February";
    } else if (month == "03") {
      return "$day March";
    } else if (month == "04") {
      return "$day April";
    } else if (month == "05") {
      return "$day May";
    } else if (month == "06") {
      return "$day June";
    } else if (month == "07") {
      return "$day July";
    } else if (month == "08") {
      return "$day Augest";
    } else if (month == "09") {
      return "$day September";
    } else if (month == "10") {
      return "$day October";
    } else if (month == "11") {
      return "$day November";
    }
    return "$day December";
  }

  //fetching genres from api and changing to list from model
  static Future<List<String>> genrePicker(List datas) async {
    final genres = await TmdbServices.genre();
    final List<String> gonres = [];
    final List temp = datas;
    for (final i in genres!) {
      for (final j in temp) {
        if (i.id == j) {
          gonres.add(i.name!);
        }
      }
    }
    return gonres;
  }

  // for showing error message botton popup
  static void showErrorSnackBar(String text) {
    final snackBar = SnackBar(
      content:
          Text(text, style: GoogleFonts.poppins(fontWeight: FontWeight.w400)),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
      // shape: const StadiumBorder(),
      margin: const EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: '',
        onPressed: () {},
      ),
    );
    snackbarKey.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
