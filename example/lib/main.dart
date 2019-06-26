import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tagging/flutter_tagging.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Tagging Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(title: 'Flutter Tagging Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = "";
  TextEditingController _serchQuery = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlutterTagging(
                textController: _serchQuery,
                textFieldDecoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Tags",
                    labelText: "Enter tags"),
                chipsColor: Colors.pinkAccent,
                chipsFontColor: Colors.white,
                deleteIcon: Icon(Icons.cancel,color: Colors.white),
                chipsPadding: EdgeInsets.all(2.0),
                chipsFontSize: 14.0,
                chipsSpacing: 5.0,
                chipsFontFamily: 'helvetica_nlight',
                suggestionsCallback: (pattern) async {
                  return await TagSearchService.getSuggestions(pattern);
                },
                onChanged: (result) {
                  setState(() {
                    text = result.toString();
                  });
                },


              ),
            ),
            SizedBox(
              height: 20.0,
            ),

          ],
        ),
      ),
    );
  }

}

class TagSearchService {

  static Future<List> getSuggestions(String query) async {
    await Future.delayed(Duration(milliseconds: 400), null);
    List<dynamic> tagList = <dynamic>[];
    tagList.add({'name': "Flutter", 'value': 1});
    tagList.add({'name': "HummingBird", 'value': 1});
    tagList.add({'name': "Dart", 'value': 1});
    tagList.add({'name': "asdasd", 'value': 1});
    tagList.add({'name': "fqwes", 'value': 1});
    tagList.add({'name': "qwerty", 'value': 1});
    List<dynamic> filteredTagList = <dynamic>[];

//    if (query.isNotEmpty) {
//      filteredTagList.add({'name': query, 'value': 0});
//    }

    for (var tag in tagList) {
      if (tag['name'].toLowerCase().contains(query)) {
        filteredTagList.add(tag);
      }
    }

    return filteredTagList;
  }
}

class EmptyService {

  static Future<List> getSuggestions(String query) async {
    List<dynamic> empty= <dynamic>[];
    return empty;
  }
}
