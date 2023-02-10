

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:show_peliculas/models/movie.dart';
import 'package:show_peliculas/models/now_playing_response.dart';
import 'package:show_peliculas/models/popular_response.dart';
import 'package:show_peliculas/models/search_response.dart';

import '../models/credits_response.dart';



class MoviesProvider extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = '48feaebe0973ebafd9f9971403fdbab2';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;


  MoviesProvider() {
    print('Movies Provider Inicializado');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsondata(String endPoint, [int page = 1 ]) async {
    final url = Uri.https(_baseUrl, endPoint,{
         'api_key': _apiKey, 
         'language': _language, 
         'page': "$page"
         });

    // Await the http get response , then decode the json - formatted response .
    final response = await http.get(url);
    return response.body;

  }


  getOnDisplayMovies() async {
    
    final jsonData = await this._getJsondata('3/movie/now_playing');

    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
   
   onDisplayMovies = nowPlayingResponse.results;
   notifyListeners();
  }


  getPopularMovies() async {

    _popularPage ++;

    final jsonData = await this._getJsondata('3/movie/popular', _popularPage);

    final popularResponse = PopularResponse.fromJson(jsonData);

   
   popularMovies = [...popularMovies,...popularResponse.results];
   notifyListeners();
   
  }

  Future<List<Cast>>getMovieCast(int movieId) async{
    

    if(moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    

    final jsonData = await this._getJsondata('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    return creditsResponse.cast;
  }





  Future<List<Movie>> searchMovie(String query)async{

    final url = Uri.https(_baseUrl, '3/search/movie',{
         'api_key': _apiKey, 
         'language': _language, 
         'query': query
    });


    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);
    
    return searchResponse.results;

  }
}
