import 'package:flutter/material.dart';
import 'package:osrm_map_part/screens/maps/map_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: MapScreen()),
    );
  }
}
