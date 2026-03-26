import 'package:flutter/material.dart';
import 'package:meals_app/models/meals.dart';
import 'package:meals_app/screen_widgets/categories.dart';
import 'package:meals_app/screen_widgets/filters_screen.dart';
import 'package:meals_app/screen_widgets/meals_widget.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInitialFilterResult = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegeterian: false,
};

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabScreen> {
  int _currentScreenIndex = 0;
  final List<Meal> favouriteMeals = [];
  late Map<Filter, bool> filterResult = kInitialFilterResult;

  void _handleSwitchScreen(int index) {
    setState(() {
      _currentScreenIndex = index;
    });
  }

  void _showSnackBar(Meal meal, int index) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Meal has been removed from favourite"),
        duration: Duration(seconds: 5),
        action: SnackBarAction(
          label: "undo",
          onPressed: () {
            setState(() {
              favouriteMeals.insert(index, meal);
            });
          },
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void handleFavoriteMeals(Meal meal) {
    final currentindex = favouriteMeals.indexOf(meal);
    setState(() {
      if (favouriteMeals.contains(meal)) {
        favouriteMeals.remove(meal);
        _showSnackBar(meal, currentindex);
      } else {
        favouriteMeals.add(meal);
      }
    });
  }

  void handleSetScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctx) => FiltersScreen(initialFilterState: filterResult,)),
      );
      // print("result is $result");
      // print("initial result is $initialFilterResult");
      setState(() {
        filterResult = result ?? kInitialFilterResult;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // print("filtered result is $filterResult");
    Widget currentContent = Categories(
      onSelectmeal: handleFavoriteMeals,
      filterResult: filterResult,
    );
    String currentTitle = "Pick your category";

    if (_currentScreenIndex == 1) {
      currentContent = MealsWidget(
        meals: favouriteMeals,
        onSelectmeal: handleFavoriteMeals,
      );
      currentTitle = "Your Favourites";
    }

    return Scaffold(
      appBar: AppBar(title: Text(currentTitle)),
      drawer: MainDrawer(onSetScreen: handleSetScreen),
      body: currentContent,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _handleSwitchScreen,
        currentIndex: _currentScreenIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Categories",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
        ],
      ),
    );
  }
}
