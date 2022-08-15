// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/datas/constants.dart';
import 'package:netflix_clone/datas/secrets.dart';
import 'package:netflix_clone/models/genres_model.dart';
import 'package:netflix_clone/models/movie_models.dart';
import 'package:netflix_clone/utils/utils.dart';

class TmdbServices {
  //fetching movies based on movie type
  static Future<List<Result>?> fetchData(MovieUrlType type) async {
    late String mainUrl;
    //checking the movie type and perticular url for that
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
      //integrating the api with http pachage
      final response = await http.get(Uri.parse(mainUrl));
      if (response.statusCode == 200) {
        //decoding the api response data and parsing into a model for organising
        // and it will help us to easy to manage and use
        final jsonData = await json.decode(response.body);
        final datas =
            MovieModel.fromJson(Map<String, dynamic>.from(jsonData as Map));

        return datas.results;
      } else {
        //notifying the error to user in ui
        Utils.showErrorSnackBar('something went wrong');
      }
    } on HttpException catch (err) {
      Fluttertoast.showToast(msg: err.message);
    } on SocketException catch (err) {
      Fluttertoast.showToast(msg: err.message);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }

  // fetching movie genres from the api
  static Future<List<Genre>?> genre() async {
    try {
      //integrating api using http pachage
      final response = await http.get(Uri.parse(Secrets.genreUrl));
      final jsonData = await json.decode(response.body);
      if (response.statusCode == 200) {
        //decoding the api response data and parsing into a model for organising
        // and it will help us to easy to manage and use
        final datas =
            GenresModel.fromJson(Map<String, dynamic>.from(jsonData as Map));
        return datas.genres!;
      }
    } on HttpException catch (err) {
      Fluttertoast.showToast(msg: err.message);
    } on SocketException catch (err) {
      Fluttertoast.showToast(msg: err.message);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }
}
