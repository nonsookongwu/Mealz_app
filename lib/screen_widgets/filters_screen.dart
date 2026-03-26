import 'package:flutter/material.dart';
// import 'package:meals_app/widgets/filter_switch.dart';

enum Filter { glutenFree, lactoseFree, vegeterian, vegan }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.initialFilterState});

  final Map<Filter, bool> initialFilterState;

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool glutenFreeFilterSet = false;
  bool lactoseFreeFilterSet = false;
  bool vegeterianFilterSet = false;
  bool veganFilterSet = false;

  @override
  void initState() {
    super.initState();
    glutenFreeFilterSet = widget.initialFilterState[Filter.glutenFree]!;
    lactoseFreeFilterSet = widget.initialFilterState[Filter.lactoseFree]!;
    vegeterianFilterSet = widget.initialFilterState[Filter.vegeterian]!;
    veganFilterSet = widget.initialFilterState[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Filters")),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.glutenFree: glutenFreeFilterSet,
            Filter.lactoseFree: lactoseFreeFilterSet,
            Filter.vegan: veganFilterSet,
            Filter.vegeterian: vegeterianFilterSet,
          });
        },
        child: Column(
          children: [
            // FilterSwitch(
            //   isPropertyChecked: glutenFreeFilterSet,
            //   title: "Gluten-free",
            //   subtitle: "Only include gluten-free meals",
            //   onChecked: _toggleFilter,
            // ),
            // FilterSwitch(
            //   isPropertyChecked: lactoseFreeFilterSet,
            //   title: "Lactose-free",
            //   subtitle: "Only include lactose-free meals",
            //   onChecked: _toggleFilter,
            // ),
            // FilterSwitch(
            //   isPropertyChecked: vegeterianFilterSet,
            //   title: "Vegeterian",
            //   subtitle: "Only include vegeterian meals",
            //   onChecked: _toggleFilter,
            // ),
            // FilterSwitch(
            //   isPropertyChecked: veganFilterSet,
            //   title: "Vegan",
            //   subtitle: "Only include vegan meals",
            //   onChecked: _toggleFilter,
            // ),
            SwitchListTile(
              value: glutenFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  glutenFreeFilterSet = isChecked;
                });
              },
              title: Text(
                "Gluten-free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ),
              subtitle: Text(
                "Only include gluten-free meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ),
              activeThumbColor: Theme.of(
                context,
              ).colorScheme.onPrimaryContainer,
            ),
            SwitchListTile(
              value: lactoseFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  lactoseFreeFilterSet = isChecked;
                });
              },
              title: Text(
                "Lactose-free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ),
              subtitle: Text(
                "Only include lactose-free meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ),
              activeThumbColor: Theme.of(
                context,
              ).colorScheme.onPrimaryContainer,
            ),
            SwitchListTile(
              value: vegeterianFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  vegeterianFilterSet = isChecked;
                });
              },
              title: Text(
                "Vegeterian",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ),
              subtitle: Text(
                "Only include vegeterian meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ),
              activeThumbColor: Theme.of(
                context,
              ).colorScheme.onPrimaryContainer,
            ),
            SwitchListTile(
              value: veganFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  veganFilterSet = isChecked;
                });
              },
              title: Text(
                "Vegan",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ),
              subtitle: Text(
                "Only include vegan meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ),
              activeThumbColor: Theme.of(
                context,
              ).colorScheme.onPrimaryContainer,
            ),
          ],
        ),
      ),
    );
  }
}
