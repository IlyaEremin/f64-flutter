import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'colors.dart' as Theme;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'f64',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords>
    with TickerProviderStateMixin {

  final _biggerFont = const TextStyle(fontSize: 18.0);

  TabController _controller;
  int _tab = 0;

  @override
  void initState() {
    _controller = new TabController(length: 2, vsync: this);
    super.initState();
  }

  Widget _buildSuggestions() {
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.black,
          title: new TabBar(
            tabs: [
              new Tab(icon: new Icon(Icons.directions_car, color: Colors.white)),
              new Tab(icon: new Icon(Icons.directions_bike, color: Colors.white)),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: new TabBarView(
          children: [
            new ListView.builder(
                itemBuilder: (context, i) {
                  return _buildRow();
                }
            ),
            new ListView.builder(
                itemBuilder: (context, i) {
                  return _buildRow();
                }
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRow() {
    return
      new Column(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                    fit: BoxFit.fitWidth,
                    alignment: FractionalOffset.center,
                    image: new NetworkImage(
                        'https://www.dropbox.com/s/m33j376w3pat6h6/serveimage.jpeg?dl=1'),
                  )
              ),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 200.0,
            ),
            new Container(
              color: new Color(0xFFA1E4FA),
              height: 10.0,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
            ),
            new Container(
                margin: const EdgeInsets.all(8.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                        "FASHION",
                        style: new TextStyle(color: Theme.Colors.MAIN_INFO_TEXT)
                    ),
                    new Text(
                        "3 MINS. READ",
                        style: new TextStyle(
                            color: Theme.Colors.MAIN_INFO_TEXT)),
                  ],
                )
            ),
            new Container(
                margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: new Text(
                  "Новый кампэйн Gucci. Glen Luchford переосмысливает понятие моды.",
                  style: new TextStyle(fontSize: 20.0, color: Colors.black),
                )
            ),
          ]
      );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold (
      appBar: new AppBar(
        title: new Text('F', style: new TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: new TabBarView(
        controller: _controller,
        children: [
          new Container(child: _buildSuggestions()),
          new Container(color: Colors.black),
        ],
      ),
      bottomNavigationBar: new BottomNavigationBar(
        onTap: (int value) {
          _controller.animateTo(value);
          setState(() {
            _tab = value;
          });
        },
        currentIndex: _tab,
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('READ'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.notifications),
            title: new Text('WATCH'),
          ),
        ],
      ),
    );
  }

  Future<Post> fetchPost() async {
    final response = await http.get(
        'https://us-central1-f64-vk-parser.cloudfunctions.net/read');
    final json = JSON.decode(response.body);

    return new Post.fromJson(json);
  }
}

class Post {
  final int imageUrl;
  final String title;
  final String categoryColor;
  final String category;
  final String timeToRead;

  Post(
      {this.imageUrl, this.title, this.categoryColor, this.category, this.timeToRead});

  factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
        imageUrl: json['image_url'],
        title: json['title'],
        categoryColor: json['category_color'],
        category: json['category'],
        timeToRead: json['time_to_read']
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}
