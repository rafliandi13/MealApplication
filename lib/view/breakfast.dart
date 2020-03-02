import 'package:flutter/material.dart';
import 'package:submission_third/view/detail.dart';
import 'package:submission_third/model/ingredients.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Breakfast extends StatefulWidget{
  Breakfast({Key key}) : super(key :key);
  _BreakfastState createState() => _BreakfastState();
}
class _BreakfastState extends State<Breakfast>{
  List<Ingredients> ingredients = [];
  List<Container> foodCategory = [];
  void initState() {
    loadData();
    super.initState();
  }
  getBody(){
    if(ingredients.length == 0){
      return  new Center(child: CircularProgressIndicator());
    }else{
      return getGridView();
    }
  }
  GridView getGridView() =>  GridView.builder(
      itemCount: ingredients.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return getRow(index);
      });
  Widget getRow(int i) {
        return GestureDetector(
          child: Container(
            child: Card(
              elevation: 10.0,
              child: new Column(
                children: <Widget>[
                  Hero(
                    tag:ingredients[i].strIngredient,
                    child: Material(
                      child: InkWell(
                        onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder:
                            (BuildContext contex)=> DetailPage(ingredients: ingredients[i],))),
                        child: Image.network(
                          ingredients[i].strMealThumb,
                          fit: BoxFit.cover,
                          height: 150.0,
                          width: 200.0,),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(ingredients[i].strIngredient,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }
  Widget build(BuildContext context){
      return Scaffold(
        body: getBody(),
      );
  }
  loadData()async {
    String dataURL = "https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood";
    http.Response response = await http.get(dataURL);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        ingredients = (responseJson['meals'] as List)
            .map((p) => Ingredients.fromJson(p))
            .toList();
      });
    } else {
      throw Exception('Failed to load meals');
    }
  }
}