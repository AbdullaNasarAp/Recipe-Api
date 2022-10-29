import 'package:api_1/model/recipe.dart';
import 'package:api_1/model/recipe_api.dart';
import 'package:api_1/screen/product.dart';
import 'package:api_1/screen/widget/recipe_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Recipe>? _recipe;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getRecipe();
  }

  Future<void> getRecipe() async {
    _recipe = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
    print(_recipe);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.restaurant_menu),
            SizedBox(
              width: 10,
            ),
            Text(
              "Food Recipe",
            )
          ],
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductPage(recipee: _recipe![index])));
                  },
                  child: RecipeCard(
                    title: _recipe![index].name,
                    cookTime: _recipe![index].totalTime,
                    rating: _recipe![index].rating.toString(),
                    thumbnailUrl: _recipe![index].images,
                  ),
                );
              },
              itemCount: _recipe!.length,
            ),
    );
  }
}
