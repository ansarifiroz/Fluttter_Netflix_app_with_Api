import 'dart:convert';
import 'dart:developer';

import 'package:netflix/common/utils.dart';
import 'package:netflix/models/movie_detail_model.dart';
import 'package:netflix/models/recomendation_modal.dart';
import 'package:netflix/models/search_model.dart';
import 'package:netflix/models/tv_series_model.dart';
import 'package:netflix/models/upcoming_movie_model.dart';
import 'package:http/http.dart' as http;

const baseurl = "https://api.themoviedb.org/3/";

var key = '?api_key=$apikey';
late String endpoint;

class ApiServices {
  // Upcoming Movies
  Future<UpcomingMovieModel> getUpcomingMovies() async {
    endpoint = "movie/upcoming";
    final url = "$baseurl$endpoint$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Upcoming success");
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load upcoming movies");
  }

// Now Playing Movies
  Future<UpcomingMovieModel> getNowPlayingMovies() async {
    endpoint = "movie/now_playing";
    final url = "$baseurl$endpoint$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Now playing success");
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load now playing");
  }

  // Top Rated Tv Shows

  Future<TvSeriesModel> getTopRatedSeries() async {
    endpoint = "tv/top_rated";
    final url = "$baseurl$endpoint$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Top rated success");
      return TvSeriesModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load top rated tv series");
  }

  // Search
  Future<SearchModel> getSearchMovie(String query) async {
    endpoint = "search/movie?query=";
    final url = "$baseurl$endpoint$query";
    print("seach url is $url");
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0MDNjN2M3NTNiYzlmMWIwOGM3YzlmMDRhN2FlZTU0MSIsIm5iZiI6MTczMDYyMTA3Ny4yMTE5MTc2LCJzdWIiOiI2NzI3MmE3NDU3NzIyYjU1NzE3YWEyZDYiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.UDXAdsDIRPhwtCFE_jwE6QpCBEcQQAEwRm7y3zpdBm4'
    });
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      log(" Search success");
      return SearchModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load Search Movie");
  }

// Movie Detailed View

  Future<MovieDetailedModel> getGetMovieDetail(int movieId) async {
    endpoint = "movie/$movieId";
    final url = "$baseurl$endpoint$key";
    print("movie detail url is $url");
    final response = await http.get(
      Uri.parse(url),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      log(" detailed movie info success");
      return MovieDetailedModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load Movie details ");
  }

//More like this

  Future<MovieRecomendationModel> getMoreLikeThis(int movieId) async {
    endpoint = "movie/$movieId/similar";
    final url = "$baseurl$endpoint$key";
    print("recommendation url is $url");
    final response = await http.get(
      Uri.parse(url),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      log(" detailed movie info success");
      return MovieRecomendationModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load More like this  ");
  }

  //Tv Series detailed view
  Future<TvSeriesModel> getTvSeriesDetail(int seriesId) async {
    endpoint = "tv/$seriesId";
    final url = "$baseurl$endpoint$key";
    print("recommendation url is $url");

    final response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      log("Detailed TV info success");
      return TvSeriesModel.fromJson(jsonDecode(response.body));
    }
    throw Exception(
        "Failed to load series details - Status Code: ${response.statusCode}");
  }

// Rescomendations
  Future<MovieRecomendationModel> getRecomendedMovies(int movieId) async {
    endpoint = "movie/popular";
    final url = "$baseurl$endpoint$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Top rated success");
      return MovieRecomendationModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load recomendation");
  }
}
