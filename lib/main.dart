import 'package:flutter/material.dart';
import 'package:movie_app_flutter/utils/text.dart';
import 'package:movie_app_flutter/widgets/toprated.dart';
import 'package:movie_app_flutter/widgets/trending.dart';
import 'package:movie_app_flutter/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.green),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String apikey = 'a26b5bd6136fbec90e4706d1db5b607c';
  final String readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhMjZiNWJkNjEzNmZiZWM5MGU0NzA2ZDFkYjViNjA3YyIsInN1YiI6IjY0MTQyYmQxOTkyNTljMDBmNjIzNTRkYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Qwu-SGS1JokBzFgcONhHEP2rgxPNhCPeueXz7ce0Ggk';
  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];

  @override
  void initState() {
    super.initState();
    loadmovies();
  }

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readaccesstoken),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvresult = await tmdbWithCustomLogs.v3.tv.getPouplar();
    print((trendingresult));
    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      tv = tvresult['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: modified_text(text: 'Flutter Movie App ❤️'),
          backgroundColor: Colors.transparent,
        ),
        body: ListView(
          children: [
            TV(tv: tv),
            TrendingMovies(
              trending: trendingmovies,
            ),
            TopRatedMovies(
              toprated: topratedmovies,
            ),
          ],
        ));
  }
}
