import 'package:flutter/material.dart';
import 'package:show_peliculas/models/movie.dart';
import 'package:show_peliculas/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO: Cambiar luego por una instancia de movie

    
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
      slivers: [
        _CustomAppBar(movie),
        SliverList(
            delegate: SliverChildListDelegate([
          _PosterAndTitle(movie),
          _Overview(movie),
          _Overview(movie),
          _Overview(movie),
          CastingCards(movie.id)
        ])),
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  
  final Movie movie;

  const _CustomAppBar(this.movie);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          titlePadding: EdgeInsets.all(0),
          title: Container(
            alignment: Alignment.bottomCenter,
            width: double.infinity,
            padding: EdgeInsets.only(bottom: 10),
            color: Colors.black12,
            child: Text(
              movie.originalTitle,
              style: TextStyle(fontSize: 16, color: Color.fromRGBO(255, 191, 0, 1) ),
              textAlign: TextAlign.center,
            ),
          ),
          background: FadeInImage(
            placeholder: AssetImage('assets/images/loading.gif'),
            image: NetworkImage(movie.fullBackdropPath),
            fit: BoxFit.cover,
          )),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  final Movie movie;

  const _PosterAndTitle(this.movie);


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              height: 140,
              placeholder: AssetImage('assets/images/no_image.jpg'),
              image: NetworkImage(movie.fullPosterImg),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width-160),
                child: Text(
                movie.title,
                maxLines: 2,
                style: TextStyle(color: Color.fromRGBO(255, 191, 0, 1), fontSize: 22, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,

              ),
              ),

             

              

              
              
              Row(
                children: [
                  const Icon(Icons.star_outline, size: 15, color: Color.fromRGBO(255, 191, 0, 1)),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${movie.voteAverage}',
                    style: TextStyle(color: Color.fromRGBO(255, 191, 0, 1), fontSize: 11),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {

  final Movie movie;

  const _Overview(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(movie.overview,
        textAlign: TextAlign.justify,
        style: TextStyle(color: Color.fromRGBO(255, 191, 0, 1),),
      ),
    );
  }
}
