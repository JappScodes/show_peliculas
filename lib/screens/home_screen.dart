import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:show_peliculas/providers/movies_provider.dart';
import 'package:show_peliculas/search/movie_search_delegate.dart';
import 'package:show_peliculas/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    //print(moviesProvider.onDisplayMovies);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Peliculas On Demand', style: TextStyle(color: Color.fromRGBO(255, 191, 0, 1)),),
        elevation: 0,
        actions: [
          IconButton(onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()),
          color: Color.fromRGBO(255, 191, 0, 1), 
          icon: Icon(Icons.search_outlined)),
          
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //cards principales
            SwiperCard(movies: moviesProvider.onDisplayMovies),

            // Listado horizontal de peliculas
            MovieSlider(
              movies: moviesProvider.popularMovies,
              title: 'Populares', 
              onNextPage: () => moviesProvider.getPopularMovies()
                
              
              
            ),
              
          ],
        ),
      ),
    );
  }
}
