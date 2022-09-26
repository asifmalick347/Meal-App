import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/dummy_data.dart';
import 'package:flutter_complete_guide/models/meals.dart';
import 'package:flutter_complete_guide/screens/category_meals_screen.dart';
import 'package:flutter_complete_guide/screens/filters_screen.dart';
import 'package:flutter_complete_guide/screens/meal_detail_screen.dart';
import 'package:flutter_complete_guide/screens/tabs_screen.dart';
import 'screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<String,bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };
  List<Meals> _availableMeals = DUMMY_MEALS;

  void _setFilters( Map<String,bool> filterData){
    setState(() {
    _filters = filterData;
    // ignore: missing_return
    _availableMeals = DUMMY_MEALS.where((meal){
      if(_filters['gluten'] && !meal.isGlutenFree){
        return false;
      }
      if(_filters['lactose'] && !meal.isLactoseFree){
        return false;
      }
      if(_filters['vegan'] && !meal.isVegan){
        return false;
      }
      if(_filters['vegetarian'] && !meal.isVegetarian){
        return false;
      }
      return true;
    }).toList();
    });

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyMedium: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          bodySmall: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          titleLarge: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: TabsScreen(),
      
      //initialRoute: '/',  iitial route can also be changed//
      routes: {
        // used as initial route for home page //
        // '/':(context) => CategoriesScreen(),
        CategoryMeals.routName: (context) => CategoryMeals(_availableMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(),
        FiltersScreen.routeName: (context) => FiltersScreen(_filters,_setFilters),
      },
      onUnknownRoute: (settings){
        return MaterialPageRoute(builder: (context) => CategoriesScreen() );
      },
    );
  }
}