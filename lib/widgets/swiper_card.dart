import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:show_peliculas/models/movie.dart';

class SwiperCard extends StatelessWidget {
  
  final List<Movie> movies;

  const SwiperCard({
    Key? key,
    required this.movies
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: (BuildContext context, int index) {

          final movie = movies[index];
         

          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/images/no_image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                fit: BoxFit.fill,
              ),
            ),
          );
        },
      ),
    );
  }
}
