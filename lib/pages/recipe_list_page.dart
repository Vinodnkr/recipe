import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class RecipeListPage extends StatefulWidget {
  @override
  _RecipeListPageState createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  List<Map<String, dynamic>> _recipes = []; // Store recipes
  List<Map<String, dynamic>> _filteredRecipes = []; // Store filtered recipes
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadRecipes(); // Load recipes on page initialization
  }

  Future<void> _loadRecipes() async {
    // Load recipes from local storage
    final file = await _getLocalFile('recipes.json');
    String content = await file.readAsString();
    setState(() {
      _recipes = json.decode(content);
      _filteredRecipes = List.from(_recipes); // Initialize filtered recipes
    });
  }

  Future<File> _getLocalFile(String filename) async {
    // Get local file reference
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$filename');
  }

  void _searchRecipes(String query) {
    setState(() {
      _filteredRecipes = _recipes
          .where((recipe) =>
              recipe['title'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe List'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: RecipeSearchDelegate(_searchController, _searchRecipes),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _filteredRecipes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_filteredRecipes[index]['title']),
            // You can add more details like photos and categories here
            onTap: () {
              Navigator.pushNamed(context, '/recipeDetail',
                  arguments: _filteredRecipes[index]);
            },
          );
        },
      ),
    );
  }
}

class RecipeSearchDelegate extends SearchDelegate<String> {
  final TextEditingController searchController;
  final Function(String) searchRecipes;

  RecipeSearchDelegate(this.searchController, this.searchRecipes);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchRecipes(query);
    return Container(); // Build results in the RecipeListPage
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions can be implemented if needed
    return Container();
  }
}
