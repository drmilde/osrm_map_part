import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:osrm_map_part/config/app_constants.dart';

import '../../services/osrm/model/ortsnamen_mapping.dart';

class MapCorrectScreen extends StatefulWidget {
  bool showBackArrow = false;

  MapCorrectScreen({this.showBackArrow = false, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MapCorrectScreenState();
  }
}

class MapCorrectScreenState extends State<MapCorrectScreen> {
  AppConstants appConstants = AppConstants();
  double size = 160;
  late final _mapController;
  double zoom = 13;

  late LatLng homePosition;
  late Marker homeMarker;

  int ortsIndex = 0; // aktueller Ort
  String ortsName = "Ortsname";

  @override
  void initState() {
    _mapController = MapController();
    homePosition = appConstants.Hochschule_P3;

    homeMarker = Marker(
      width: 160,
      height: 160,
      point: homePosition,
      builder: (ctx) => const Icon(
        Icons.person_pin_circle_outlined,
        color: Colors.black,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(title: const Text("Wähle Startpunkt")),
        //drawer: buildDrawer(context, TapToAddPage.route),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Container(
                        width: 200,
                        child: Text(ortsName),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  GestureDetector(
                    onTap: () async {
                      // TODO save home position in UserConfig
                      ortsIndex = max(1, ortsIndex - 1);
                      setState(() {
                        ortsName = lookupOrtsnamen[ortsIndex].name;
                        _processLatLang(lookupOrtsnamen[ortsIndex].latlng);
                        // falls Karte, setzte den Punkt
                        if (_mapController != null) {
                          _mapController!
                              .move(lookupOrtsnamen[ortsIndex].latlng, 13);
                        }
                      });
                    },
                    child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.arrow_back_outlined)),
                  ),
                  SizedBox(width: 16),
                  GestureDetector(
                    onTap: () async {
                      // TODO save home position in UserConfig
                      ortsIndex =
                          min(lookupOrtsnamen.length - 1, ortsIndex + 1);
                      setState(() {
                        ortsName = lookupOrtsnamen[ortsIndex].name;
                        _processLatLang(lookupOrtsnamen[ortsIndex].latlng);
                        if (_mapController != null) {
                          _mapController!
                              .move(lookupOrtsnamen[ortsIndex].latlng, 13);
                        }
                      });
                    },
                    child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.arrow_forward_outlined)),
                  ),
                  SizedBox(width: 64),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Flexible(
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    center: homePosition,
                    zoom: 13,
                    maxZoom: 18,
                    onTap: _handleTap,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    ),
                    MarkerLayer(markers: [homeMarker]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleTap(TapPosition tapPosition, LatLng latlng) {
    _processClick(latlng);
  }

  void _processClick(LatLng latlng) {
    print(
        "Mapping(name: \"${ortsName} (NEU ${DateTime.now()})\", latlng: LatLng(${latlng.latitude}, ${latlng.longitude})),");
    _processLatLang(latlng);

  }

  void _processLatLang(LatLng latlng) {
    homeMarker = Marker(
      width: size,
      height: size,
      point: latlng,
      builder: (ctx) => const Icon(
        Icons.person_pin_circle_outlined,
        color: Colors.black,
      ),
    );

    homePosition = latlng;
    setState(() {});
  }

  void _savePosition(LatLng latlng) {
    // TODO setting home latlong
    print("TODO .. saving position");
  }

/* not allowed */
}
