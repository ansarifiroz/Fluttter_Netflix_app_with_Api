import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:netflix/common/utils.dart';

import 'package:netflix/models/tv_series_model.dart';
import 'package:netflix/screens/movie_detail_scree.dart';

class CustomerCarauselSlider extends StatelessWidget {
  final TvSeriesModel data;

  const CustomerCarauselSlider({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height / 2,
      child: CarouselSlider.builder(
        itemCount: data.results.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          // var url = data.results[index].backdropPath.toString();
          return GestureDetector(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    Get.to(MovieDetailScreen(
                      movieId: data.results[index].id,
                    ));
                  },
                  child: Image.network(
                      "$imageurl${data.results[index].posterPath}"),
                )),
          );
        },
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 1,
          enlargeCenterPage: true,
        ),
      ),
    );
  }
}
