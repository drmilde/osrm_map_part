import 'package:flutter/material.dart';

import '../../../../services/maps/nominatim.dart';
import '../../../../services/maps/remote_services.dart';
import '../../../../services/osrm/model/helper_generate_step_description.dart';
import '../../../../services/osrm/model/nominatim_cache.dart';
import '../../../../services/osrm/model/osrm.dart' as osrm;
import '../../../../services/osrm/model/osrm_service_provider.dart';
import '../../maps/polyline_screen.dart';
import '../../widgets/custom_round_button.dart';

class OsrmListScreen extends StatefulWidget {
  const OsrmListScreen({Key? key}) : super(key: key);

  @override
  _OsrmListScreenState createState() => _OsrmListScreenState();
}

class _OsrmListScreenState extends State<OsrmListScreen> {
  osrm.Osrm osrmRoute = osrm.Osrm.empty();
  String search = "9.41188,50.63475;9.68522,50.56611";
  HelperGenerateStepDescription _generate = HelperGenerateStepDescription();
  NominatimCache cache = NominatimCache();

  // Load to-do list from the server
  Future<bool> _loadOsrm() async {
    print(search);
    osrmRoute = await OSRMServiceProvider.getRoute(
      coordString: search,
      objectFromJson: osrm.osrmFromJson,
    );
    print("Distanz: ${osrmRoute.getDistance()}");

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("OSRMListe"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //_buildForm(context),
              CustomRoundButton(
                height: 24,
                text: ("karte"),
                callback: () {
                  List<osrm.Step> steps = osrmRoute.getSteps();
                  print(steps);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PolylineScreen(steps: steps),
                      ));
                },
              ),
              SizedBox(height: 8),
              FutureBuilder<bool>(
                future: _loadOsrm(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _buildListView(snapshot);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return CircularProgressIndicator();
                },
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListView(AsyncSnapshot<bool> snapshot) {
    List<osrm.Step> steps = osrmRoute.getSteps();
    print(osrmRoute.getDistance());
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: ListView.builder(
          itemCount: steps.length,
          itemBuilder: (context, index) {
            final step = steps[index];
            return _buildCard(step);
          },
        ),
      ),
    );
  }

  Widget _buildCard(osrm.Step step) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16),
      child: Stack(
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(255, 162, 219, 156),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(_generate.generate(step)),
                /*
                child: Text("${step.maneuver.type} ${step.maneuver.modifier} into ${step.name}${step.destinations}: "
                    "${step.maneuver.location[0]},${step.maneuver.location[1]} "
                    "${step.duration}s, ${step.distance}m"
                    "\n"
                    "Im Kreisverkehr nehmen Sie die Ausfahrt ${step.maneuver.exit}."),

                 */
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> _getCoordString(String sterm) async {
    double lat = 0;
    double lng = 0;

    sterm = sterm.toLowerCase().trim();
    sterm = sterm.replaceAll(",", " ");
    sterm = sterm.replaceAll(RegExp(r"\s+"), " ");

    String? similar = cache.getSimilar(sterm);
    if (similar != "") {
      return cache.lookup[similar];
    }

    List<Nominatim> liste = await RemoteServices.fetchCoordinates(sterm);
    if (liste.isNotEmpty) {
      print(liste[0].lat);
      print(liste[0].lon);

      lat = double.tryParse(liste[0].lat!) ?? 0;
      lng = double.tryParse(liste[0].lon!) ?? 0;
      print(lat);
      print(lng);
    }
    return ("${lng},${lat}");
  }
}
