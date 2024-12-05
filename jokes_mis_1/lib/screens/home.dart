import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jokes_mis/model/type.dart';
import '../widgets/type_card.dart';
import '../services/api_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //List<String> types = [];
  List<String> types = [];

  @override
  void initState() {
    super.initState();
    getJokeTypesFromAPI();
  }

  void getJokeTypesFromAPI() async {
    try {
      final response = await ApiService.getAllJokeTypes();

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data is List) {
          List<String> stringList = List<String>.from(data);
          print("String list: $stringList");
          setState(() {
            types = stringList;
          });
        } else {
          print("Expected a List of strings, but got something else");
        }
      } else {
        print("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[100],
        title: const Text("Joke App"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.shuffle),
          tooltip: "Random Joke",
          onPressed: () {
            Navigator.pushNamed(context, '/random');
          },
        ),
      ),
      body: TypeCard(types: types),
    );
  }


}
