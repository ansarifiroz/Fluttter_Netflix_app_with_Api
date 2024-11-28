import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:netflix/common/utils.dart';
import 'package:netflix/models/movie_detail_model.dart';
import 'package:netflix/models/recomendation_modal.dart';
import 'package:netflix/models/tv_series_model.dart';
import 'package:netflix/services/api_services.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  ApiServices apiServices = ApiServices();

  late Future<MovieDetailedModel> movieDetail;
  late Future<MovieRecomendationModel> movieRecomendation;
  late Future<TvSeriesModel> seriesDetails;

  @override
  void initState() {
    fetchinitdata();
    super.initState();
  }

  fetchinitdata() {
    movieDetail = apiServices.getGetMovieDetail(widget.movieId);
    movieRecomendation = apiServices.getRecomendedMovies(widget.movieId);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("movie Id is- ${widget.movieId}");
    return Scaffold(
        body: SingleChildScrollView(
      child: FutureBuilder(
          future: movieDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final movie = snapshot.data;
              String genreText =
                  movie!.genres.map((genre) => genre.name).join(', ');

              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "$imageurl${movie.posterPath}"),
                                fit: BoxFit.fill)),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          movie.title,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "${movie.releaseDate.year}".toString(),
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 15),
                          ),
                          // const SizedBox(
                          //   width: 10,
                          // ),
                          Text(
                            genreText,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 15),
                          ),
                          // const SizedBox(
                          //   width: 10,
                          // ),
                          Container(
                            height: 16,
                            width: 60,
                            color: Colors.grey,
                            child: Center(
                              child: Text(
                                "IMDB-${movie.voteAverage}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                                // textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // Row(
                      //   children: [
                      //     const SizedBox(
                      //       width: 10,
                      //     ),
                      //     Image.asset("assets/logos/dolby.png"),
                      //     const SizedBox(
                      //       width: 10,
                      //     ),
                      //     Image.asset("assets/logos/hd.png"),
                      //     const SizedBox(
                      //       width: 10,
                      //     ),
                      //     Image.asset("assets/logos/ad.png")
                      //   ],
                      // ),
                      SizedBox(
                        width: double.infinity,
                        child: Image.asset(
                          "assets/logos/play.png",
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: Image.asset("assets/logos/donload.png")),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ExpandableText(
                          movie.overview,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 15),
                          expandText:
                              'See more', // Text to display when collapsed
                          collapseText:
                              'See less', // Text to display when expanded
                          maxLines:
                              5, // Number of lines to display when collapsed
                          linkColor:
                              Colors.white, // Color of the "See more" link
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FutureBuilder(
                        future: movieRecomendation,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final movieRecommendations = snapshot.data;
                            return movieRecommendations!.results.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("More like this"),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          height:
                                              250, // Set a fixed height for the ListView
                                          child: ListView.builder(
                                            scrollDirection: Axis
                                                .horizontal, // Horizontal scrolling
                                            itemCount: movieRecommendations
                                                .results.length,
                                            itemBuilder: (context, index) {
                                              final movie = movieRecommendations
                                                  .results[index];
                                              String imageUrl =
                                                  '$imageurl${movie.posterPath}'; // Full image URL

                                              // Debug print the URL
                                              print("Image URL: $imageUrl");

                                              // Check if the image URL is not null or empty

                                              return Container(
                                                margin: const EdgeInsets.only(
                                                    right:
                                                        10), // Optional margin
                                                width:
                                                    150, // Set the width for each item
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image:
                                                        NetworkImage(imageUrl),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                          } else {
                            return const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text("Something went wrong..."),
                            );
                          }
                        },
                      )
                    ],
                  )
                ],
              );
            } else {
              return const SizedBox();
            }
          }),
    ));
  }
}
