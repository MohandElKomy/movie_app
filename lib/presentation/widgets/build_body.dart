import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/model/movie.dart';
import 'package:movie_app/data/model/movies.dart';
import 'package:movie_app/domain/bloc/movie_bloc/movie_bloc.dart';

Widget BuildBody(BuildContext context) {
  return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: constraints.maxHeight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
              if (state is MovieLoading) {
                return Center(
                  child: Platform.isAndroid
                      ? CircularProgressIndicator()
                      : CupertinoActivityIndicator(),
                );
              } else if (state is MovieLoaded) {
                List<Results>? movies = state.movieList;
                print(movies!.length);
                return Column(children: [
                  CarouselSlider.builder(
                    itemCount: movies!.length,
                    itemBuilder:
                        (BuildContext context, int index, int pageIndex) {
                      Results movie = movies![index];
                      print(movie.backdropPath);
                      return Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          ClipRRect(
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://image.tmdb.org/t/p/original/${movie.backdropPath}",
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.width,
                              placeholder: (context, url) => Platform.isAndroid
                                  ? CircularProgressIndicator()
                                  : CupertinoActivityIndicator(),
                              errorWidget: (context, url, error) {
                                return Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/img_not_found.jpg',
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ],
                      );
                    },
                    options: CarouselOptions(
                      autoPlay: true,
                      enableInfiniteScroll: true,
                      autoPlayInterval: Duration(seconds: 5),
                      autoPlayAnimationDuration: Duration(microseconds: 800),
                      pauseAutoPlayOnTouch: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                    ),
                  )
                ]);
              } else {
                return Container(
                  child: Text('Something went wrong'),
                );
              }
            })
          ],
        ),
      ),
    );
  });
}
