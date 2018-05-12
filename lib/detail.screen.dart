import 'package:f64_flutter/dimens.dart';
import 'package:f64_flutter/styles.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class DetailScreen extends StatelessWidget {
  final _titleImageUrl =
      'https://www.dropbox.com/s/kw8f621utbj83hv/main_image.png?dl=1';
  final _inTheMiddleOfArticleImageUrl =
      'https://www.dropbox.com/s/nccepkkrw6w6mly/in_the_middle_of_article.png?dl=1';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          _buildImage(context, _titleImageUrl),
          new Container(
              margin: const EdgeInsets.only(
                  left: 16.0, right: 8.0, top: 24.0, bottom: 12.0),
              child: new Text(
                "Новый кампэйн Gucci. Glen Luchford переосмысливает понятие моды.",
                style: Styles.TITLE,
              )),
          new Container(
            color: new Color(0xFFA69AFC),
            height: Dimens.TOPIC_COLOR_HEIGHT,
            width: getScreenWidth(context),
            margin: const EdgeInsets.only(left: 16.0),
          ),
          new Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 16.0, top: 8.0),
            child: new Text("3 MINS. READ", style: Styles.TIME_TO_READ),
          ),
          new Container(
            margin: const EdgeInsets.only(
                left: 16.0, right: 8.0, top: 16.0, bottom: 8.0),
            child: new Text(
                'Фотограф Мария Кожанова родилась и выросла в Калининграде, центре российского эксклава между Польшей и Литвой на Балтийском море. Сложная история города и региона - одна из ключевых тем, которую Кожанова преследует в своей художественной практике. Её серия "Прусская невеста" исследует мифы и визуальную иконографию места в поисках своей вневременной сущности.\n\nКалининград стоит на месте старого прусского поселения. Город, первоначально названный Кенигсбергом, был частью государства Тевтонского ордена, Польско-Литовсокго Содружества, Пруссии и Германии, до тех пор, пока в значительной степени разрушенный во Второй мировой войне, он стал частью Совесткого Союза в 1945 году. Прусский, немецкий и советские влияния смешиваются в атмосфрере и архитектуре города, а также в менталитете людей.'),
          ),
          _buildImage(context, _inTheMiddleOfArticleImageUrl),
          new Container(
            height: Dimens.TOPIC_COLOR_HEIGHT,
            child: new Container(
              color: new Color(0xFFA69AFC),
              width: min(getScreenWidth(context) / 5, 64.0),
            ),
            margin: const EdgeInsets.only(left: 16.0, top: 16.0),
            alignment: Alignment.centerLeft,
          ),
          new Container(
            margin: const EdgeInsets.only(left: 16.0, top: 8.0),
            child: buildTitleInfoBlock('AUTHOR', 'Hannah Kelley'),
          ),
          new Container(
              margin: const EdgeInsets.only(left: 16.0),
              child: buildTitleInfoBlock('LINKS, ETC', 'i-d.vice.com')),
          new Container(
            color: new Color(0xFFE8E8E8),
            height: 6.0,
            margin: const EdgeInsets.only(top: 80.0),
          ),
          new Container(
            margin: const EdgeInsets.only(left: 16.0, top: 16.0),
            child: new Text('RELATED', style: new TextStyle(color: new Color(0xFF000000), fontWeight: FontWeight.w900, fontSize: 22.0),),
          ),
          new Container(
            margin: const EdgeInsets.only(left: 10.0, top: 40.0),
            height: 144.0,
            child: _buildRelatedBlock(context),
          )
        ],
      ),
    );
  }

  double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  RichText buildTitleInfoBlock(title, info) {
    return new RichText(
      text: new TextSpan(
        children: <TextSpan>[
          new TextSpan(
              text: '${title}: ',
              style: new TextStyle(color: new Color(0xFFB5B2B2))),
          new TextSpan(
              text: info,
              style: new TextStyle(
                  color: new Color(0xFF000000),
                  letterSpacing: -1.0,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  Container _buildImage(BuildContext context, String url) {
    return new Container(
      decoration: new BoxDecoration(
          image: new DecorationImage(
        fit: BoxFit.fitWidth,
        alignment: FractionalOffset.center,
        image: new NetworkImage(url),
      )),
      width: getScreenWidth(context),
      height: 240.0,
    );
  }

  ListView _buildRelatedBlock(context) {
    return new ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        _buildRelatedItem(context),
        _buildRelatedItem(context),
        _buildRelatedItem(context),
      ],
    );
  }

  Column _buildRelatedItem(context) {
    return new Column(children: <Widget>[
      new Container(
        decoration: new BoxDecoration(
            image: new DecorationImage(
          fit: BoxFit.cover,
          alignment: FractionalOffset.center,
          image: new NetworkImage(
              'https://www.dropbox.com/s/m33j376w3pat6h6/serveimage.jpeg?dl=1'),
        )),
        width: getScreenWidth(context) / 3,
        height: 96.0,
      ),
      new Container(
        color: new Color(0xFFA1E4FA),
        height: 4.0,
        width: getScreenWidth(context) / 3,
      ),
      new Container(
          margin: const EdgeInsets.only(left: 6.0, right: 6.0),
          width: getScreenWidth(context) / 3,
          child: new Text(
            "Новый кампэйн Gucci. Glen Luchford переосмысливает понятие моды.",
            maxLines: 2,
            style: new TextStyle(fontSize: 12.0),
          )),
    ]);
  }
}
