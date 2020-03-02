import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:submission_third/model/detail.dart';
class DetailDes extends StatefulWidget{
  final List<Detail> detailedMeal;
  DetailDes({Key key, this.detailedMeal}) : super(key: key);
  StateDetailDes createState() => StateDetailDes();
}
class StateDetailDes extends State<DetailDes>{
  Widget build(BuildContext context) {
    return Scaffold(
        body: getBody());
  }
  getBody() {
    return new ListView(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                children: <Widget>[
                  Hero(
                    tag: widget.detailedMeal[0].detailedStrMeal,
                    child: Material(
                      child: InkWell(
                        child: Image.network(widget.detailedMeal[0].detailedStrMealThumb
                        ),
                      ),
                    ),
                  ),
                  Text(''),
                  Text(widget.detailedMeal[0].detailedStrMeal, style: TextStyle(color: Colors.blue, fontSize: 20),),
                  Text(''),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.only(top:4.0),
                      child: Text(
                        'Ingredients: ',
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                    ),
                  ),
                  Text(''),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.only(top:4.0),
                      child: Text(
                        'Instruction: ',
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                    ),
                  ),
                ]
            )
        )
      ],
    );
  }
}
