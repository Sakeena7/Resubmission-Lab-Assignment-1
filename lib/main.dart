import 'dart:convert'; 
import 'package:flutter/material.dart'; 
import 'package:http/http.dart' as http; 
import 'package:ndialog/ndialog.dart';
 
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Movie App', 
          style: TextStyle(color: Colors.white, 
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          )
          ),
        ),
        body: const HomePage(),
        
      ),
    );
  }
}
 
class HomePage extends StatefulWidget {
  const HomePage ({ Key? key }) : super(key: key);

    _HomePageState createState() => _HomePageState();
  }
 
class _HomePageState extends State<HomePage> { 
  var desc = ""; 
  String chooseMovie = ""; 
  TextEditingController textEditingController = TextEditingController(); 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 75, 25, 65),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 75, 25, 65),
        elevation: 0.0,
      ),
      body: SingleChildScrollView (
       child: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [ 
          const Text("Search Your Movie:", 
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)), 
          TextField( 
            controller: textEditingController, 
            // ignore: prefer_const_constructors 
            decoration: InputDecoration( 
              // ignore: prefer_const_constructors 
              border: OutlineInputBorder(), 
              labelText: 'Search Movie', 
              hintText: 'Type here', 
            ), 
            onChanged: (text) { 
              setState(() { 
                chooseMovie = text; 
              }); 
            }, 
          ), 
          ElevatedButton(onPressed: _getMovie, child: const Text("Search")), 
          Text(desc, 
              style: 
                  const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), 
        ], 
      ),
       )
      )
    ); 
  } 
 
  Future<void> _getMovie() async { 
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Progress"), title: const Text("Searching..."));
    progressDialog.show();
    var apiid = "c417bcd2"; 
    var url = Uri.parse('http://www.omdbapi.com/?t=$chooseMovie&apikey=$apiid'); 
    var response = await http.get(url); 
    var rescode = response.statusCode; 
    if (rescode == 200) { 
      var jsonData = response.body; 
      var parsedJson = json.decode(jsonData); 
      setState(() { 
        var title = parsedJson['Title']; 
        var year = parsedJson['Year']; 
        var rated = parsedJson['Rated']; 
        var released = parsedJson['Released']; 
        var runtime = parsedJson['Runtime']; 
        var genre = parsedJson['Genre']; 
        var director = parsedJson['Director']; 
        var actors = parsedJson['Actors']; 
        var language = parsedJson['Language']; 
        var country = parsedJson['Country']; 
 
        desc = 
            "Title: $title. \nYear: $year. \nRated: $rated. \nReleased: $released. \nRuntime: $runtime. \nGenre: $genre. \nDirector: $director. \nActors: $actors. \nLanguage: $language. \nCountry: $country. "; 
      }); 
    } else 
      setState(() { 
        desc = "No Record"; 
      }); 
      progressDialog.dismiss();
    } 
  } 