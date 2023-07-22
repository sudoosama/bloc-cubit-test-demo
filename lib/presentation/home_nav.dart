import 'package:demo_new/main.dart';
import 'package:demo_new/presentation/home_screen.dart';
import 'package:demo_new/utils/preference_utils.dart';
import 'package:flutter/material.dart';

import 'favourite_screen.dart';

class HomeBottomNav extends StatefulWidget {
  const HomeBottomNav({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeBottomNav> createState() => _HomeBottomNavState();
}

class _HomeBottomNavState extends State<HomeBottomNav> {
  @override
  void initState() {
    getUserToken();
    super.initState();
  }

  int _currentIndex = 0;

  final List<Widget> _pages = [
    const PokemonListViewScreen(),
    FavoritePokemonListScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Pokemon',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
        ],
      ),
    );
  }

  void getUserToken() async {
    USERTOKEN = await PreferenceUtils.getString(PrefKey.USERTOKEN);
  }
}
