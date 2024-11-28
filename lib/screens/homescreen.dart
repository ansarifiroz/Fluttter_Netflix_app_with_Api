import 'package:flutter/material.dart';
import 'package:netflix/models/tv_series_model.dart';
import 'package:netflix/models/upcoming_movie_model.dart';
import 'package:netflix/services/api_services.dart';
import 'package:netflix/widgets/customer_carausel.dart';
import 'package:netflix/widgets/headericonwidget.dart';

import 'package:netflix/widgets/movie_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<UpcomingMovieModel> upcomingFuture;
  late Future<UpcomingMovieModel> nowPlayingFuture;
  late Future<TvSeriesModel> topRatedseries;

  ApiServices apiservices = ApiServices();

  @override
  void initState() {
    super.initState();
    upcomingFuture = apiservices.getUpcomingMovies();
    nowPlayingFuture = apiservices.getNowPlayingMovies();
    topRatedseries = apiservices.getTopRatedSeries();
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const HederIcon(),
          FutureBuilder<TvSeriesModel>(
            future: topRatedseries,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData && snapshot.data != null) {
                return CustomerCarauselSlider(data: snapshot.data!);
              } else {
                return const Text('No data available');
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: 250,
                  child: MovieCardWidget(
                      future: nowPlayingFuture, headLineText: "Now Playing"),
                ),
                SizedBox(
                  height: 250,
                  child: MovieCardWidget(
                      future: upcomingFuture, headLineText: "Upcoming Movies"),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
