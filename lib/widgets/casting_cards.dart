import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:show_peliculas/models/credits_response.dart';
import 'package:show_peliculas/providers/movies_provider.dart';

class CastingCards extends StatelessWidget {
  
  final int movieId;

  const CastingCards(this.movieId);

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {

        if (!snapshot.hasData){
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 180,
            child: CupertinoActivityIndicator(),
          );
        }

        final cast = snapshot.data!;
        return Container(
        margin: EdgeInsets.only(bottom: 20),
        width: double.infinity,
        height: 180,
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return CastCard(cast[index]);
          },
          itemCount:cast.length,
          scrollDirection: Axis.horizontal,
        )) ;
      },
    );

    ;
  }
}

class CastCard extends StatelessWidget {
  final Cast actor;

  const CastCard(this.actor);

  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: 100,
      height: 90,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/images/no_image.jpg'),
              image: NetworkImage(actor.fullProfilePath),
              width: 100,
              height: 134,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(color: Color.fromRGBO(255, 191, 0, 1) ,fontSize: 12),
          )
        ],
      ),
    );
  }
}
