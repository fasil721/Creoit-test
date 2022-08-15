// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/datas/constants.dart';
import 'package:netflix_clone/datas/secrets.dart';
import 'package:netflix_clone/models/genres_model.dart';
import 'package:netflix_clone/models/movie_models.dart';

class TmdbServices {
  static Future<List<Result>?> fetchData(MovieUrlType type) async {
    late String mainUrl;
    if (type == MovieUrlType.popular) {
      mainUrl = Secrets.popularUrl;
    } else if (type == MovieUrlType.nowPlaying) {
      mainUrl = Secrets.nowPlayingUrl;
    } else if (type == MovieUrlType.upcoming) {
      mainUrl = Secrets.upcomingUrl;
    } else {
      mainUrl = Secrets.topRatedUrl;
    }
    try {
      final response = await http.get(Uri.parse(mainUrl));
      if (response.statusCode == 200) {
        final jsonData = await json.decode(response.body);
        final datas =
            MovieModel.fromJson(Map<String, dynamic>.from(jsonData as Map));

        return datas.results;
      }
      final jsonData = await json.decode(response.body);
      final datas =
          MovieModel.fromJson(Map<String, dynamic>.from(jsonData as Map));
      return datas.results;
    } on HttpException {
      Fluttertoast.showToast(msg: "No Internet");
    } on SocketException {
      Fluttertoast.showToast(msg: "No internet connection");
    } on PlatformException {
      Fluttertoast.showToast(msg: "Invalid Format");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }

  static Future<List<Genre>?> genre() async {
    try {
      final response = await http.get(Uri.parse(Secrets.genreUrl));
      final jsonData = await json.decode(response.body);
      final datas =
          GenresModel.fromJson(Map<String, dynamic>.from(jsonData as Map));
      return datas.genres!;
    } on HttpException {
      Fluttertoast.showToast(msg: "No Internet");
    } on SocketException {
      Fluttertoast.showToast(msg: "No internet connection");
    } on PlatformException {
      Fluttertoast.showToast(msg: "Invalid Format");
      // } catch (e) {
      //   Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }
}
