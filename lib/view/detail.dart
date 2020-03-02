import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:submission_third/model/ingredients.dart';
import 'package:submission_third/model/detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class DetailPage extends StatefulWidget {
  Ingredients ingredients;
  DetailPage({Key key,this.ingredients});
  StateDetailPage createState() => StateDetailPage();
}
class StateDetailPage extends State<DetailPage> with TickerProviderStateMixin{
  List<Detail> meal;
  @override
  void initState() {
    super.initState();
    _getMealId();
  }

  Future _getMealId() async {
    var foodService = DetailedResponse(meal);
    var response = await foodService.getMealid(widget.ingredients.idIngredient);
    if (!mounted) return;
    setState(() {
      meal = response;
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.ingredients.strIngredient),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 20.0),
                        child: Hero(
                          tag: widget.ingredients.strIngredient,
                          child: FadeInImage.assetNetwork(
                            placeholder: '',
                            image: widget.ingredients.strMealThumb,
                          ),
                        ),
                      ),
                      getBody()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }
  getBody() {
    if(meal == null){
        return Center(
          child: CircularProgressIndicator(),
        );
    }else{
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.only(top: 4.0),
                    child: Text(
                      'Ingredients: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: ingredients(meal[0].detailedStrIngredients),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.only(top: 4.0),
                    child: Text(
                      'Instructions: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: instruction(meal[0].detailedStrInstructions),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
List<Container> ingredients(List<String> listString) {
  List<Container> ingredientsText = List<Container>();

  // Check if member exist in List of String
  for (String string in listString) {
    ingredientsText.add(
      Container(
          child: Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text('=>' + string,style: TextStyle(color: Colors.blue),),
              ),
            ),
          )),
    );
  }
  return ingredientsText;
}
List<Container> instruction(List<String> listString) {
  List<Container> instructionText = List<Container>();

  // Check if member exist in List of String
  for (String string in listString) {
    instructionText.add(
      Container(
          child: Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text('=>' + string,style: TextStyle(color: Colors.blue),),
              ),
            ),
          )),
    );
  }
  return instructionText;
}
class DetailedResponse {
  List<Detail> detail;
  DetailedResponse(this.detail);
  DetailedResponse.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      detail = List<Detail>();
      json['meals'].forEach((p) {
        detail.add(Detail.fromJson(p));
      });
    }
  }
  getMealid(String id) async {
    String url = 'https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id';
    http.Response response = await http.get(url);
    var responseJson = json.decode(response.body);
    if(response.statusCode == 200){
      if(response.body == '{"meals":null'){
        return throw Exception('No Meals Avalaiable');
      } else{
        return (responseJson['meals'] as List)
            .map((p) => Detail.fromJson(p)).toList();
      }
    } else{
      throw Exception('Failed to load');
    }
  }
}
