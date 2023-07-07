import 'package:flutter/material.dart';

import 'screens/suche/map_suche_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: MapSucheScreen()),
    );
  }
}
