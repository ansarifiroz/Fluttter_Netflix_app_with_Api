import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:netflix/common/utils.dart';
import 'package:netflix/models/recomendation_modal.dart';
import 'package:netflix/models/search_model.dart';
import 'package:netflix/screens/movie_detail_scree.dart';
import 'package:netflix/services/api_services.dart';

class SearchScreen extends StatefulWidget {
  final movieId;
  const SearchScreen({super.key, this.movieId});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  ApiServices apiServices = ApiServices();
  late Future<MovieRecomendationModel> future;

  SearchModel? searchModel;

  void search(String query) async {
    // Only update the widget tree if the widget is still mounted
    if (!mounted) return;
    await apiServices.getSearchMovie(query).then((results) {
      searchModel = results;
      if (mounted) {
        setState(() {}); // Safe to call setState here
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.movieId != null) {
      // Ensure the movieId is valid
      future = apiServices.getRecomendedMovies(widget.movieId);
    } else {
      future = Future.error("No movieId provided");
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CupertinoSearchTextField(
                  padding: const EdgeInsets.all(15),
                  controller: searchController,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  suffixIcon: const Icon(
                    Icons.cancel,
                    color: Colors.grey,
                  ),
                  style: const TextStyle(color: Colors.white),
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      search(value);
                    }
                  },
                ),
              ),
              searchController.text.isEmpty
                  ? Expanded(
                      child: FutureBuilder<MovieRecomendationModel>(
                        future: future,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.results.isEmpty) {
                            return const Center(
                                child: Text('No movies available'));
                          }

                          var data = snapshot.data!.results;
                          return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Get.to(MovieDetailScreen(
                                      movieId: data[index].id));
                                },
                                child: ListTile(
                                  leading: SizedBox(
                                    height: 100,
                                    width: 50,
                                    child: Image.network(
                                      "$imageurl${data[index].posterPath}",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  title: Text(
                                    data[index].title,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  trailing: Icon(Icons.play_circle_fill_sharp,
                                      size: 30),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    )
                  : Expanded(
                      child: searchModel == null
                          ? const SizedBox.shrink()
                          : ListView.builder(
                              itemCount: searchModel!.results.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: SizedBox(
                                    height: 100,
                                    width: 50,
                                    child: searchModel!
                                                .results[index].backdropPath ==
                                            null
                                        ? Image.asset("assets/logos/image.png")
                                        : Image.network(
                                            "$imageurl${searchModel!.results[index].backdropPath}",
                                            fit: BoxFit.fill,
                                          ),
                                  ),
                                  title: Text(
                                    searchModel!.results[index].title,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  trailing: const Icon(
                                    Icons.play_circle_outline_outlined,
                                    size: 30,
                                  ),
                                );
                              },
                            ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
