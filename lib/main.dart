import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:show_peliculas/providers/movies_provider.dart';

import 'screens/screens.dart';

void main() => runApp(AppState());

//
class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
          lazy: false,
        )
      ],
      child: MyApp(),
    );
  }
}

//

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas App',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScreen(), 
        'details': (_) => DetailsScreen()},

      theme: ThemeData.light().copyWith(appBarTheme: AppBarTheme(color: Colors.black)),
    );
  }
}
