import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
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

  Future<List<Polyline>> transfer() async {
    List<LatLng> points = List<LatLng>.empty(growable: true);
    print(widget.steps.length);
    for (osrm.Step step in widget.steps) {
      print(step.geometry);
      final polyline = decodePolyline(step.geometry);
      print(polyline);
      for (List<num> tuple in polyline) {
        double lat = tuple[0].toDouble() / 1.0;
        double long = tuple[1].toDouble() / 1.0;
        print("${long},${lat};");
        points.add(LatLng(lat, long));
      }
    }

    List<Polyline> polyLines = [
      Polyline(
        points: points,
        strokeWidth: 4,
        color: Color.fromARGB(120, 255, 32, 32),
      )
    ];

    await Future<void>.delayed(const Duration(seconds: 1));
    return polyLines;
  }

  @override
  void initState() {
    polylines = transfer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
