import 'package:flutter/material.dart';
import 'package:flutter_application_4/http_helper.dart';


class Screen1 extends StatefulWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  late String result;
  late HttpHelper helper;
  String selectedCategory = 'now_playing';

  @override
  void initState() {
    super.initState();
    helper = HttpHelper();
    result = "";

    fetchMovies(selectedCategory);
  }

  Future<void> fetchMovies(String category) async {
    final String movieData = await helper.getMoviesByCategory(category);
    setState(() {
      result = movieData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Movie'),
      backgroundColor: Colors.blue,),
      body: Column(
        children: <Widget>[
          DropdownButton<String>(
  value: selectedCategory,
  items: [
    'latest',
    'now_playing',
    'popular',
    'top_rated',
    'upcoming',
  ].map((String category) {
    return DropdownMenuItem<String>(
      value: category,
      child: Text(category),
    );
  }).toList(),
  onChanged: (String? newValue) {
    if (newValue != null) {
      setState(() {
        selectedCategory = newValue;
      });
      fetchMovies(newValue);
    }
  },
),
         Expanded(
            child: SingleChildScrollView(
              child: Text("$result"),
            ),
          ),
        ],
      ),
    );
  }
}