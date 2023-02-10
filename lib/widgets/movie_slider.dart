import 'package:flutter/material.dart';
import 'package:show_peliculas/models/movie.dart';

class MovieSlider extends StatefulWidget {
  

  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider({super.key, required this.movies, this.title, required this.onNextPage});

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if( scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500){
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (this.widget.title != null )
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
              this.widget.title!, style: const TextStyle(color:  Color.fromRGBO(255, 191, 0, 1),fontSize: 20, fontWeight: FontWeight.bold),
            ),

          
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.movies.length,
                itemBuilder: (_, int index) {
                  return _MoviePoster(widget.movies[index]);
                }),
          )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  



  final Movie movie;

  const _MoviePoster(this.movie);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: FadeInImage(
                placeholder: AssetImage('assets/images/no_image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 0,
          ),
          Text(movie.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(color: Color.fromRGBO(255, 191, 0, 1)),
          )
        ],
      ),
    );
  }
}
