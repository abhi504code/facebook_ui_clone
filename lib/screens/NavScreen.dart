import 'package:fb_responsive_ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../config/palette.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {


  final List<Widget> _screens = [
    HomeScreen(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];
  final List<IconData> _icons = [
    Icons.home,
    Icons.ondemand_video,
    MdiIcons.accountCircleOutline,
    MdiIcons.accountGroupOutline,
    MdiIcons.bellOutline,
    Icons.menu,
  ];
  int selectedIndex = 0;
  bool isBottomIndicator = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _icons.length, child: Scaffold(
        body: IndexedStack(
          index: selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: createCustomTabBar(
          icons: _icons,
          selectedIndex: selectedIndex,
          onTap: (index) => setState(() => selectedIndex = index),
        ),
    ));
  }

  createCustomTabBar({required List<IconData> icons, required int selectedIndex, required Function(int index) onTap}) {
    return TabBar(
      indicatorPadding: EdgeInsets.zero,
      indicator: BoxDecoration(
        border: isBottomIndicator
            ? const Border(
          bottom: BorderSide(
            color: Palette.facebookBlue,
            width: 3.0,
          ),
        )
            : const Border(
          top: BorderSide(
            color: Palette.facebookBlue,
            width: 3.0,
          ),
        ),
      ),
      tabs: icons
          .asMap()
          .map((i, e) => MapEntry(
        i,
        Tab(
          icon: Icon(
            e,
            color: i == selectedIndex
                ? Palette.facebookBlue
                : Colors.black45,
            size: 30.0,
          ),
        ),
      ))
          .values
          .toList(),
      onTap: onTap,
    );

  }
}
