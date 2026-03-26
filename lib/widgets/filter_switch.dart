import 'package:flutter/material.dart';

class FilterSwitch extends StatefulWidget {
  FilterSwitch({
    super.key,
    required this.isPropertyChecked,
    required this.title,
    required this.subtitle,
    required this.onChecked,
  });

  bool isPropertyChecked;
  final String title;
  final String subtitle;
  final void Function(bool ischecked, bool property) onChecked;

  @override
  State<FilterSwitch> createState() {
    return _FilterSwitchState();
  }
}

class _FilterSwitchState extends State<FilterSwitch> {
  // late bool islocalChecked;
  // @override
  // void initState() {
  //   super.initState();
  //   islocalChecked = widget.isPropertyChecked;
  // }

  @override
  Widget build(BuildContext context) {
    // print(islocalChecked);
    return SwitchListTile(
      value: widget.isPropertyChecked,
      onChanged: (isChecked) {
        // setState(() {
        //   widget.isPropertyChecked = isChecked;
        // });
        setState(() {
          
        widget.onChecked(isChecked, widget.isPropertyChecked);
        });
      },
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.inverseSurface,
        ),
      ),
      subtitle: Text(
        widget.subtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: Theme.of(context).colorScheme.inverseSurface,
        ),
      ),
      activeThumbColor: Theme.of(context).colorScheme.onPrimaryContainer,
    );
  }
}
