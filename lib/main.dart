import 'package:f64_flutter/Post.dart';
import 'package:f64_flutter/colors.dart';
import 'package:f64_flutter/detail.screen.dart';
import 'package:f64_flutter/styles.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

  Widget _buildTabs() {
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.black,
          title: new TabBar(
            tabs: [
              new Tab(
                  icon: new Icon(Icons.directions_car, color: Colors.white)),
              new Tab(
                  icon: new Icon(Icons.directions_bike, color: Colors.white)),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: new TabBarView(
          children: [
            new ListView.builder(itemBuilder: (context, i) {
              return _buildListItem();
            }),
            new ListView.builder(itemBuilder: (context, i) {
              return _buildListItem();
            })
          ],
        ),
      ),
    );
  }

  Widget _buildListItem() {
    var imageUrl =
        'https://sun9-5.userapi.com/c840327/v840327006/6093e/odrhYhf7i8w.jpg';
    return new InkWell(
      child: new Column(children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
            fit: BoxFit.fitWidth,
            alignment: FractionalOffset.center,
            image: new NetworkImage(imageUrl),
          )),
          width: MediaQuery.of(context).size.width,
          height: 200.0,
        ),
        new Container(
          color: new Color(0xFFA1E4FA),
          height: 10.0,
          width: MediaQuery.of(context).size.width,
        ),
        new Container(
            margin: const EdgeInsets.all(8.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text("FASHION",
                    style: new TextStyle(color: FColors.MAIN_INFO_TEXT)),
                new Text("3 MINS. READ", style: Styles.TIME_TO_READ),
              ],
            )),
        new Container(
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: new Text(
              "Новый кампэйн Gucci. Glen Luchford переосмысливает понятие моды.",
              style: Styles.TITLE,
            )),
      ]),
      onTap: () {
        Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => new DetailScreen()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var _applicationName = 'F';
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          _applicationName,
          style: new TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: new TabBarView(
        controller: _controller,
        children: [
          new Container(child: _buildTabs()),
          new Container(color: Colors.black),
        ],
      ),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
              canvasColor: Colors.black,
            ),
        child: new BottomNavigationBar(
          onTap: (int value) {
            _controller.animateTo(value);
            setState(() {
              _tab = value;
            });
          },
          currentIndex: _tab,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
              icon: _tab == 0
                  ? new Icon(Icons.home, color: Colors.white)
                  : new Icon(Icons.home, color: Colors.grey),
              title: _tab == 0
                  ? new Text('READ', style: new TextStyle(color: Colors.white))
                  : new Text('READ', style: new TextStyle(color: Colors.grey)),
            ),
            new BottomNavigationBarItem(
              icon: _tab == 1
                  ? new Icon(Icons.notifications, color: Colors.white)
                  : new Icon(Icons.notifications, color: Colors.grey),
              title: _tab == 1
                  ? new Text('WATCH', style: new TextStyle(color: Colors.white))
                  : new Text('WATCH', style: new TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }

  Future<Post> fetchPost() async {
    final response = await http
        .get('https://us-central1-f64-vk-parser.cloudfunctions.net/read');
    return new Post.fromJson(json.decode(response.body));
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}
