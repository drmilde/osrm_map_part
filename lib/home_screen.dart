import 'package:flutter/material.dart';
import 'package:osrm_map_part/screens/prototyp_dummies/osrm/osrm_list_screen.dart';
import 'package:osrm_map_part/screens/suche/harvest_screen.dart';
import 'package:osrm_map_part/screens/suche/map_correct_screen.dart';

import 'screens/maps/polyline_screen.dart';
import 'screens/suche/map_suche_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: Center(child: OsrmListScreen()),
      //body: Center(child: HarvestScreen()),
      body: Center(child: MapCorrectScreen()),
    );
  }
}
