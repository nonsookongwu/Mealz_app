import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:meals_app/models/meals.dart';
import 'package:meals_app/provider/favourites_provider.dart';
import 'package:meals_app/provider/filters_provider.dart';
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

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int _currentScreenIndex = 0;

  void _handleSwitchScreen(int index) {
    setState(() {
      _currentScreenIndex = index;
    });
  }

  // void _showSnackBar(Meal meal, int index, String message) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text("Meal $message favourite"),
  //       duration: Duration(seconds: 5),
  //       // action: SnackBarAction(
  //       //   label: "undo",
  //       //   onPressed: () {
  //       //     setState(() {
  //       //       favouriteMeals.insert(index, meal);
  //       //     });
  //       //   },
  //       // ),
  //       behavior: SnackBarBehavior.floating,
  //     ),
  //   );
  // }

  // void handleFavoriteMeals(Meal meal) {
  //   final currentindex = favouriteMeals.indexOf(meal);
  //   setState(() {
  //     if (favouriteMeals.contains(meal)) {
  //       favouriteMeals.remove(meal);
  //       _showSnackBar(meal, currentindex, "removed from");
  //     } else {
  //       favouriteMeals.add(meal);
  //       _showSnackBar(meal, currentindex, "added to");
  //     }
  //   });
  // }

  void handleSetScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(),
        ),
      );
      // setState(() {
      //   filterResult = result ?? kInitialFilterResult;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    // print("filtered result is $filterResult");
    Widget currentContent = Categories();
    String currentTitle = "Pick your category";

    if (_currentScreenIndex == 1) {
      final favouriteMeals = ref.watch(favouriteMealsProvider);
      currentContent = MealsWidget(
        meals: favouriteMeals,
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
