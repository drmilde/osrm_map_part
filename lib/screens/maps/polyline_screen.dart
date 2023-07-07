import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../../services/osrm/model/osrm.dart' as osrm;

class PolylineScreen extends StatefulWidget {
  List<osrm.Step> steps = [];

  static const String route = 'polyline';

  PolylineScreen({required this.steps, Key? key}) : super(key: key);

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  late Future<List<Polyline>> polylines;

  /*
  Future<List<Polyline>> getPolylines() async {
    final polyLines = [
      Polyline(
        points: [
          LatLng(50.5, -0.09),
          LatLng(51.3498, -6.2603),
          LatLng(53.8566, 2.3522),
        ],
        strokeWidth: 4,
        color: Colors.amber,
      ),
    ];
    await Future<void>.delayed(const Duration(seconds: 3));
    return polyLines;
  }

   */

  Future<List<Polyline>> transfer() async {
    List<LatLng> points = List<LatLng>.empty(growable: true);
    for (osrm.Step step in widget.steps) {
      double lat = step.maneuver.location[1];
      double long = step.maneuver.location[0];
      print("${long},${lat};");

      points.add(LatLng(lat, long));
    }




    List<Polyline> polyLines = [
      Polyline(
        points: points,
        strokeWidth: 4,
        color: Colors.yellow,
      )
    ];

    await Future<void>.delayed(const Duration(seconds: 1));
    return polyLines;
  }

  @override
  void initState() {
    //polylines = getPolylines();
    polylines = transfer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*
    final points = <LatLng>[
      LatLng(51.5, -0.09),
      LatLng(53.3498, -6.2603),
      LatLng(48.8566, 2.3522),
    ];

    final pointsGradient = <LatLng>[
      LatLng(55.5, -0.09),
      LatLng(54.3498, -6.2603),
      LatLng(52.8566, 2.3522),
    ];

     */

    return Scaffold(
        appBar: AppBar(title: const Text('Polylines')),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: FutureBuilder<List<Polyline>>(
            future: polylines,
            builder:
                (BuildContext context, AsyncSnapshot<List<Polyline>> snapshot) {
              debugPrint('snapshot: ${snapshot.hasData}');
              if (snapshot.hasData) {
                return Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      child: Text('Polylines'),
                    ),
                    Flexible(
                      child: FlutterMap(
                        options: MapOptions(
                          center: LatLng(50.565624, 9.68478),
                          zoom: 10,
                          onTap: (tapPosition, point) {
                            setState(() {
                              debugPrint('onTap');
                              polylines = transfer();
                            });
                          },
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName:
                                'dev.fleaflet.flutter_map.example',
                          ),
                          /*
                          PolylineLayer(
                            polylines: [
                              Polyline(
                                  points: points,
                                  strokeWidth: 4,
                                  color: Colors.purple),
                            ],
                          ),
                          PolylineLayer(
                            polylines: [
                              Polyline(
                                points: pointsGradient,
                                strokeWidth: 4,
                                gradientColors: [
                                  const Color(0xffE40203),
                                  const Color(0xffFEED00),
                                  const Color(0xff007E2D),
                                ],
                              ),
                            ],
                          ),
                           */
                          PolylineLayer(
                            polylines: snapshot.data!,
                            polylineCulling: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return const Text(
                  'Getting map data...\n\nTap on map when complete to refresh map data.');
            },
          ),
        ));
  }
}
