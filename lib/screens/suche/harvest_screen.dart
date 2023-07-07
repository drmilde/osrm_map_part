import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../services/osrm/model/osrm.dart' as osrm;
import '../../../services/osrm/model/osrm_service_provider.dart';
import '../../services/osrm/model/ortschaften.dart';
import '../../services/osrm/model/ortsnamen_mapping.dart';
import '../../../services/maps/nominatim.dart';
import '../../../services/maps/remote_services.dart';
import '../widgets/custom_round_button.dart';

class HarvestScreen extends StatefulWidget {
  const HarvestScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HarvestScreenState();
  }
}

class HarvestScreenState extends State<HarvestScreen> {
  Ortschaften ortschaften = Ortschaften();
  LatLng P3 = LatLng(50.570037, 9.687154);
  double size = 160;
  late final _mapController;
  double zoom = 13;

  Marker homeMarker = Marker(
    width: 160,
    height: 160,
    point: LatLng(50.570037, 9.687154),
    builder: (ctx) => const Icon(
      Icons.person_pin_circle_outlined,
      color: Colors.black,
    ),
  );

  @override
  void initState() {
    _mapController = MapController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wähle Startpunkt")),
      //drawer: buildDrawer(context, TapToAddPage.route),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              height: 100,
              child: ListView.builder(
                itemCount: ortschaften.ortschaften.length,
                itemBuilder: (context, index) {
                  String startort = ortschaften.ortschaften[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        List<Nominatim> liste =
                            await RemoteServices.fetchCoordinates(startort);
                        if (liste.isNotEmpty) {
                          print(liste[0].lat);
                          print(liste[0].lon);

                          double lat =
                              double.tryParse(liste[0].lat!) ?? P3.latitude;
                          double lng =
                              double.tryParse(liste[0].lon!) ?? P3.longitude;

                          _processLatLang(LatLng(lat, lng));
                          _mapController.move(LatLng(lat, lng), zoom);
                        }
                      },
                      child: Text(
                        "${startort}",
                      ),
                    ),
                  );
                },
              ),
            ),
            Flexible(
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(center: P3, zoom: 13, onTap: _handleTap),
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
            Container(
              height: 40,
              color: Colors.yellow,
              child: CustomRoundButton(
                text: "harvest",
                callback: () {
                  //harvest();
                  harvest();
                },
              ),
            ),
            Container(
              height: 40,
              color: Colors.yellow,
              child: CustomRoundButton(
                text: "harvest2",
                callback: () {
                  //harvest();
                  harvest2();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleTap(TapPosition tapPosition, LatLng latlng) {
    _processLatLang(latlng);
  }

  void _processLatLang(LatLng latlng) {
    print(latlng);

    homeMarker = Marker(
      width: size,
      height: size,
      point: latlng,
      builder: (ctx) => const Icon(
        Icons.person_pin_circle_outlined,
        color: Colors.black,
      ),
    );

    setState(() {});
  }

  /* not allowed */

  void harvest2() {
    int index = 1078;
    Mapping startort = lookupOrtsnamen[index];
    final periodicTimer =
        Timer.periodic(const Duration(seconds: 6), (timer) async {
      Mapping startort = lookupOrtsnamen[index];
      double lat = startort.latlng.latitude;
      double lng = startort.latlng.longitude;
      _mapController.move(LatLng(lat, lng), zoom);
      String search = "${lng},${lat};9.685992,50.565074";
      await _loadOsrm(search!);
      print(
          "${index}: ${startort.name}, \"distance\": ${osrmRoute.getDistance()}");
      index++;
      if (index >= lookupOrtsnamen.length) {
        timer.cancel();
      }
    });
  }

  osrm.Osrm osrmRoute = osrm.Osrm.empty();

  Future<bool> _loadOsrm(String search) async {
    osrmRoute = await OSRMServiceProvider.getRoute(
      coordString: search,
      objectFromJson: osrm.osrmFromJson,
    );

    return true;
  }

  void harvest() {
    int index = 400;
    String startort = fehlende[index];
    final periodicTimer =
        Timer.periodic(const Duration(seconds: 15), (timer) async {
      startort = fehlende[index];
      List<Nominatim> liste = await RemoteServices.fetchCoordinates(startort);
      if (liste.isNotEmpty) {
        double lat = double.tryParse(liste[0].lat!) ?? P3.latitude;
        double lng = double.tryParse(liste[0].lon!) ?? P3.longitude;

        print("${index} ${startort}: ${lat}, ${lng}");
        print ("Mapping(name: \"${startort}\", latlng: LatLng(${lat}, ${lng})),");

        _mapController.move(LatLng(lat, lng), zoom);
      }
      index++;
      if (index >= fehlende.length) {
        timer.cancel();
      }
    });
  }
}
