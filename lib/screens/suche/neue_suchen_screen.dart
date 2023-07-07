import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:projects/sb/screens/suche/angebot_buchen_detail_screen.dart';
import 'package:projects/sb/widgets/buchungen/angebote_suche_card_widget.dart';
import 'package:projects/sb/widgets/suche/fahrt_richtung_auswahl_widget.dart';
import 'package:projects/services/controller/ug_state_controller.dart';
import 'package:projects/services/model/profil.dart';
import 'package:projects/services/persistence/data_cache.dart';

import '../../../services/model/angebot.dart';
import '../../../services/unigo_service.dart';
import '../../widgets/buchungen/extended_angebot_card_widget.dart';

class NeueSuchenScreen extends StatefulWidget {
  const NeueSuchenScreen({Key? key}) : super(key: key);

  @override
  State<NeueSuchenScreen> createState() => _NeueSuchenScreenState();
}

class _NeueSuchenScreenState extends State<NeueSuchenScreen> {
  UGStateController _controller = Get.find();
  UniGoService service = UniGoService();
  List<ExtendedAngebot> fahrten = [];
  List<ExtendedAngebot> fahrtenDatum = [];
  List<ExtendedAngebot> fahrtenDatumUhrzeit = [];
  bool istFahrer = true;
  bool isHinfahrt = true;
  bool filterDateTime = false;
  bool filterDate = false;
  late FahrtRichtungAuswahlWidget fraw;

  DateTime datetime = new DateTime.utc(
    2023,
    04,
    24,
    08,
  );
  //DateTime time = DateTime.parse('21:13:31.215251');

  // Load the list data from server
  Future<bool> _loadFahrten({String search = ""}) async {
    print(search);
    /*
    fahrten = await service.searchAngebotList(
      searchparams: {"search": search},
    );
     */
    print(fahrten.length);
    return true;
  }

  @override
  void initState() {
    // TODO lade die Fahrten aus dem AngebotCache
    LatLng home = LatLng(_controller.userConfig.profile!.lat,
        _controller.userConfig.profile!.lng);
    fahrten = _controller.dataCache.getHinfahrtenByDistance(home);
    fahrten.sort((a, b) {
      return (a.mehraufwnd_distance - b.mehraufwnd_distance).toInt();
    });

    for (int x = 0; x < fahrten.length; x++) {
      if ('${fahrten[x].angebot.datum.day}${fahrten[x].angebot.datum.month}${fahrten[x].angebot.datum.year}' ==
          '${datetime.day}${datetime.month}${datetime.year}') {
        fahrtenDatum.add(fahrten[x]);
      }
    }
    //print('fahrtenDatum length: ${fahrtenDatum.length}');

    var parsedtime;

    for (int y = 0; y < fahrtenDatum.length; y++) {
      parsedtime = DateTime.parse('1974-03-20 ${fahrtenDatum[y].angebot.uhrzeit}');
      if ('${parsedtime.hour}'==
          '${datetime.hour}') {
        fahrtenDatumUhrzeit.add(fahrtenDatum[y]);
      }
    }
    //print('fahrtenDatumUhrzeit length: ${fahrtenDatumUhrzeit.length}');

    /*print('angebot hour: ${fahrtenDatum[0].angebot.uhrzeit}');
    print('hour: ${datetime.hour}');

    print(fahrten.length);
    print('fahrt datum: ${fahrten[0].angebot.datum}');
    print('fahrt uhrzeit: ${fahrten[0].angebot.uhrzeit}');
    print('datetime: ${datetime}');
    print(fahrtenDatum[0].angebot.datum);*/
    //print(fahrtenDatumUhrzeit[0]);

    fraw = FahrtRichtungAuswahlWidget(onSelected: (value) {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: _controller.appConstants.white,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            _fahrtSuchen(),
            Expanded(
              child: Obx(
                () {
                  int _change = _controller.somethingChanged.value;
                  return _showList(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showList(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: _buildListView(),
    );
  }

  Widget _fahrtSuchen() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _controller.appConstants.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 4,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      //child: _oldForm(),
      child: Column(
        children: [
          //SizedBox(height: 20,),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Obx(() {
              var _ = _controller.somethingChanged.value;
              if (fraw.isHinfahrt) {
                return _ueberSchrift("Hinfahrt");
              } else {
                return _ueberSchrift("Rückfahrt");
              }
            }),
          ),
          Container(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: fraw,
            ),
          ),
        ],
      ),
    );
  }

  /// Hier die Liste der Angebote

  Widget _buildListView() {
    return RefreshIndicator(
      onRefresh: () async {
        await _controller.dataCache.reload();
        setState(() {});
      },
      child: ListView.builder(
        itemCount: filterDate == true
            ? filterDateTime == true
                ? fahrtenDatumUhrzeit.length
                    : fahrtenDatum.length
            : fahrten.length,
        itemBuilder: (context, index) {
          ExtendedAngebot fahrt = fahrten[index];
          if(filterDate == true){
            fahrt = fahrtenDatum[index];
          } else if(filterDateTime == true){
            fahrt = fahrtenDatumUhrzeit[index];
          }

          Profil p = Profil.empty();
          if (fahrt.angebot.hasprofile.isNotEmpty) {
            int profilid = fahrt.angebot.hasprofile[0];
            p = _controller.dataCache.getProfilByProfilId(profilid);
          }

          // TODO HIER GEHTS WEITER HEUTE
          return AngeboteSucheCardWidget(
            extendedAngebot: fahrt,
            profil: p,
          );
          return ExtendedAngebotCardWidget(
            extendedAngebot: fahrt,
            onDelete: () {},
            onDetail: () {},
            arrowColor: _controller.appConstants.dark_grey,
          );
        },
      ),
    );
  }

  Container _ueberSchrift(String text) {
    return Container(
      width: double.infinity,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        //textAlign: TextAlign.left,
      ),
    );
  }
}
