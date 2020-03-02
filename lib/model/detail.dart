class Detail {
  String detailedIdMeal,
      detailedStrMeal,
      detailedStrCategory,
      detailedStrMealThumb;
  List<String> detailedStrIngredients, detailedStrInstructions;

  Detail(
      {this.detailedIdMeal,
        this.detailedStrCategory,
        this.detailedStrIngredients,
        this.detailedStrInstructions,
        this.detailedStrMeal,
        this.detailedStrMealThumb});
  factory Detail.fromJson(Map<String, dynamic> json){
    List<String> ingredients = List<String>();
    for (int i=0; i < 20; i++){
      String ingredient = json['strIngredient$i'] as String;
      if(ingredient == null){
        ingredient = "";
      }
      ingredients.add(ingredient);
    }
    List<String> instructions = List<String>();
    String fullInstructions = json['strInstructions'] as String;

    instructions = fullInstructions.split("\r\n");


    return Detail(
        detailedIdMeal: json['idMeal'] as String,
        detailedStrMeal: json['strMeal'] as String,
        detailedStrCategory: json['strCategory'] as String,
        detailedStrMealThumb: json['strMealThumb'] as String,
        detailedStrIngredients: ingredients,
        detailedStrInstructions: instructions
    );
  }
}