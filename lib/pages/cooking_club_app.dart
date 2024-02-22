
import 'package:flutter/material.dart';
import 'sign_in_page.dart';
import 'recipe_list_page.dart';
import 'recipe_detail_page.dart';
import 'my_favorites_page.dart';

class CookingClubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cooking Club',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light, // Light theme
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark, // Dark theme
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SignInPage(),
        '/recipeList': (context) => RecipeListPage(),
        '/myFavorites': (context) => RecipeDetailPage(),
        '/myFavorites': (context) => MyFavoritesPage(),
      },
    );
  }
}
