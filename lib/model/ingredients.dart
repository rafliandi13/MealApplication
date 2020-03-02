class Ingredients {

  final String idIngredient;
  final String strIngredient;
  final String strMealThumb;
  Ingredients(this.idIngredient, this.strIngredient, this.strMealThumb);
  factory Ingredients.fromJson(Map<String, dynamic> json) {
    return Ingredients(
        json['idMeal'],
        json['strMeal'],
        json['strMealThumb'],
    );
  }
}