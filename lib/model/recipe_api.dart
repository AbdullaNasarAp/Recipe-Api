import 'dart:convert';

import 'package:api_1/model/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
  static Future<List<Recipe>?> getRecipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list', {
      "limit": "18",
      "start": "0",
      "tag": "list.recipe.popular",
    });
    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': '5e51bbaf96msh139a5d8843f2418p1d40a2jsn343ef27db81e',
      'X-RapidAPI-Host': 'yummly2.p.rapidapi.com',
      'useQueryString': 'true',
    });

    Map data = jsonDecode(response.body);
    List _temp = [];
    for (var i in data['feed']) {
      _temp.add(i['content']['details']);
    }
    return Recipe.recipesFromSnapShot(_temp);
  }
}
