import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:osrm_map_part/config/app_constants.dart';

import '../../services/osrm/model/ortsnamen_mapping.dart';
import '../prototyp_dummies/widgets/custom_popup_widget.dart';
import '../prototyp_dummies/widgets/ortsnamen_textfield_widget.dart';

class MapSucheScreen extends StatefulWidget {
  bool showBackArrow = false;

  MapSucheScreen({this.showBackArrow = false, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MapSucheScreenState();
  }
}

class MapSucheScreenState extends State<MapSucheScreen> {
  AppConstants appConstants = AppConstants();
  double size = 160;
  late final _mapController;
  double zoom = 13;

  late LatLng homePosition;
  late Marker homeMarker;

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
                  widget.showBackArrow
                      ? GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 16,
                            ),
                            child: Icon(Icons.arrow_back_ios),
                          ),
                        )
                      : Container(),
                  Expanded(
                    child: Container(
                      width: 200,
                      child: OrtsnamenAutoCompleteWidget(
                        onSelected: (value) {},
                        mapController: _mapController,
                        setMarker: _processLatLang,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  GestureDetector(
                    onTap: () async {
                      // TODO save home position in UserConfig
                      print("save position");
                      _savePosition(homePosition);

                      CustomPopUp popup = CustomPopUp(
                        content: _buildPopupForm(),
                        title: "Ihr Abholort",
                        button1Text: "Speichern",
                      );
                      var _ = await popup.showCustomDialog(context);

                      Navigator.of(context).pop();
                    },
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.save)),
                  ),
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

  Widget _buildPopupForm() {
    return Container();
  }

  void _handleTap(TapPosition tapPosition, LatLng latlng) {
    _processLatLang(latlng);
  }

  void _processLatLang(LatLng latlng) {
    print(latlng);

    //_savePosition(latlng);

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

    // TODO gib Ort in der Nähe aus
    print(findNearest(homePosition).name);

    setState(() {});
  }

  void _savePosition(LatLng latlng) {
    // TODO setting home latlong
    print("TODO .. saving position");
  }

/* not allowed */
}
