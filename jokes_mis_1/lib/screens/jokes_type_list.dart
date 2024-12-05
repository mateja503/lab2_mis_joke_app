import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/joke.dart';
import '../services/api_service.dart';

class JokeTypeList extends StatefulWidget {


  @override
  State<JokeTypeList> createState() => _JokeTypeListState();
}

class _JokeTypeListState extends State<JokeTypeList> {
  String jokeType = '';
  final List<Joke>  jokes = [];


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    jokeType = arguments.toString();
    print("joke type: $jokeType");
    if (jokeType != ' ') {
      getJokeTypesFromAPI(jokeType);
    }


  }
  void getJokeTypesFromAPI(String type) async {
    try {
      final response = await ApiService.getTypeJokes(type);

      if (response.statusCode == 200) {
        // Assuming the response is a JSON array of jokes
        var data = jsonDecode(response.body);

        List<dynamic> jokesJson = data;

        // Parse the jokes from JSON and add to the jokes list
        setState(() {
          jokes.clear(); // Clear existing jokes
          jokes.addAll(jokesJson.map((jokeJson) => Joke.fromJson(jokeJson)).toList());
        });
      } else {
        print("Failed to load jokes: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${jokeType} Jokes"),
      ),
      body: jokes.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: jokes.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              leading: Icon(
                Icons.label_important_outlined,
                color: Colors.amber,
                size: 30,
              ),
              title: Text(
                jokes[index].setup,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  jokes[index].punchline,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          );
        },
      ),
    );
  }

}
