import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

Widget headings(String txt) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        txt,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
Widget dotIcon() => const Padding(
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: Icon(
        FontAwesomeIcons.ggCircle,
        color: Colors.blue,
        size: 4,
      ),
    );
 Widget textGenre(String txt) => Text(
        txt,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 12,
        ),
      );