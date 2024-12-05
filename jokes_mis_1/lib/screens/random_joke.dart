import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/joke.dart';
import '../services/api_service.dart';


class RandomJoke extends StatefulWidget {
  const RandomJoke({super.key});

  @override
  State<RandomJoke> createState() => _RandomJokeState();
}

class _RandomJokeState extends State<RandomJoke> {

  Joke joke = new Joke(type: '',setup: '',punchline: '',id: 0);


  @override
  void initState() {
    super.initState();
    getRandomJokeFromAPI();
  }

  void getRandomJokeFromAPI() async {
    try {
      final response = await ApiService.getRandomJoke();

      if (response.statusCode == 200) {
        // Assuming the response is a JSON array of jokes
        var data = jsonDecode(response.body);



        // Parse the jokes from JSON and add to the jokes list
        setState(() {
           // Clear existing jokes
          joke = Joke.fromJson(data);
          // jokes.addAll(jokesJson.map((jokeJson) => Joke.fromJson(jokeJson)).toList());
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
        title: Text("Random Joke"),
      ),
      body: Card(
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
                joke.setup,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  joke.punchline,
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
          ),


    );
  }
}
