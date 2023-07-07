import 'package:latlong2/latlong.dart';

import '../../../config/app_constants.dart';

class Mapping {
  final String name;
  late String searchName;
  final LatLng latlng;
  double luftlinie = 0;
  double fahrDistanz = 0;

  AppConstants appConstants = AppConstants();
  Distance dist = Distance();

  Mapping({
    required this.name,
    required this.latlng,
    this.luftlinie = 0,
    this.fahrDistanz = 0,
  }) {
    // TODO: implement Mapping
    searchName = name.toLowerCase();
    searchName = searchName.replaceAll(RegExp('[^a-zöäüß]'), ' ');
    searchName = searchName.replaceAll("  ", " ").trim();
    searchName = searchName.replaceAll("  ", " ").trim();
    searchName = searchName.replaceAll("  ", " ").trim();

    luftlinie = calculateLuftlinie(latlng);
    fahrDistanz = luftlinie;
  }

  @override
  String toString() {
    return "${name}";
  }

  double calculateLuftlinie(LatLng from) {
    return dist.as(LengthUnit.Meter, from, appConstants.Hochschule_P3);
  }
}

List<Mapping> filterLookup(String search) {
  var nsearch = normalizeSearchTerm(search);
  return lookupOrtsnamen.where((Mapping county) {
    return county.searchName.contains(nsearch);
  }).toList();
}

List<Mapping> generateOptionen(String search) {
  var optionen = lookupOrtsnamen
      .where((Mapping county) =>
          county.searchName.contains(normalizeSearchTerm(search)))
      .toList();
  var startsWith = optionen
      .where((Mapping county) =>
          county.searchName.startsWith(normalizeSearchTerm(search)))
      .toList();

  startsWith.forEach((element) {
    optionen.remove(element);
  });

  startsWith.sort((a, b) {
    return (a.name.length - b.name.length);
  });

  startsWith.addAll(optionen);

  return startsWith;
}

Mapping findNearest(LatLng home) {
  Distance dist = Distance();
  double minDistance = 100000;
  double abstand;
  Mapping result = lookupOrtsnamen[0];

  for (Mapping m in lookupOrtsnamen) {
    abstand = dist.as(LengthUnit.Meter, home, m.latlng);
    if (abstand < minDistance) {
      minDistance = abstand;
      result = m;
    }
  }

  return result;
}

String normalizeSearchTerm(String sterm) {
  return sterm
      .toLowerCase()
      .replaceAll(RegExp('[^a-zöäüß]'), ' ')
      .replaceAll("  ", " ")
      .replaceAll("  ", " ")
      .replaceAll("  ", " ")
      .trim();
}

List<Mapping> lookupOrtsnamen = [
  Mapping(
      name: "Hochschule Fulda", latlng: LatLng(50.5650744, 9.685991642142039)),
  Mapping(
      name: "Parkplatz P1: Hochschule Fulda",
      latlng: LatLng(50.569938, 9.687144)),
  Mapping(
      name: "Parkplatz P2: Hochschule Fulda",
      latlng: LatLng(50.565784, 9.683473)),
  Mapping(
      name: "Parkhaus: Hochschule Fulda", latlng: LatLng(50.565173, 9.682949)),
  Mapping(name: "Aarbergen", latlng: LatLng(50.2516294, 8.0801992)),
  Mapping(name: "Abterode, Meißner", latlng: LatLng(51.209679, 9.9374482)),
  Mapping(
      name: "Abtsroda, Poppenhausen", latlng: LatLng(50.5082902, 9.9242071)),
  Mapping(name: "Abtsteinach", latlng: LatLng(49.54333925, 8.788068874613355)),
  Mapping(
      name: "Achenbach, Breidenbach", latlng: LatLng(50.8622689, 8.3917477)),
  Mapping(
      name: "Adelshausen, Melsungen", latlng: LatLng(51.1093299, 9.5710048)),
  Mapping(
      name: "Adolfseck, Bad Schwalbach", latlng: LatLng(50.1606382, 8.0787522)),
  Mapping(name: "Adorf, Diemelsee", latlng: LatLng(51.3604209, 8.8057273)),
  Mapping(
      name: "Affhöllerbach, Brensbach",
      latlng: LatLng(49.750845299999995, 8.897624959738824)),
  Mapping(name: "Affoldern, Edertal", latlng: LatLng(51.166731, 9.0855488)),
  Mapping(
      name: "Affolterbach, Wald-Michelbach",
      latlng: LatLng(49.5976559, 8.8564245)),
  Mapping(name: "Ahausen, Weilburg", latlng: LatLng(50.4989024, 8.2741833)),
  Mapping(
      name: "Ahl, Bad Soden-Salmünster", latlng: LatLng(50.2930801, 9.3953549)),
  Mapping(
      name: "Ahlbach, Limburg an der Lahn",
      latlng: LatLng(50.4372851, 8.0851715)),
  Mapping(
      name: "Ahlersbach, Schlüchtern", latlng: LatLng(50.3269584, 9.5568651)),
  Mapping(name: "Ahnatal", latlng: LatLng(51.365326, 9.4051218)),
  Mapping(
      name: "Ahrdt, Hohenahr",
      latlng: LatLng(50.694241649999995, 8.473954904750052)),
  Mapping(
      name: "Ahrenberg, Bad Sooden-Allendorf",
      latlng: LatLng(51.2819922, 9.9499738)),
  Mapping(name: "Airlenbach, Oberzent", latlng: LatLng(49.5846027, 8.9333641)),
  Mapping(
      name: "Albach, Fernwald", latlng: LatLng(50.5568602, 8.803074358843272)),
  Mapping(name: "Alberode, Meißner", latlng: LatLng(51.1830944, 9.9383463)),
  Mapping(name: "Albersbach, Rimbach", latlng: LatLng(49.6261923, 8.7308911)),
  Mapping(
      name: "Albertshausen, Bad Wildungen",
      latlng: LatLng(51.1139335, 9.0551446)),
  Mapping(name: "Albshausen, Guxhagen", latlng: LatLng(51.2046795, 9.5127294)),
  Mapping(
      name: "Albshausen, Rauschenberg", latlng: LatLng(50.9111622, 8.9098619)),
  Mapping(
      name: "Albshausen, Solms", latlng: LatLng(50.5418619, 8.438117450779874)),
  Mapping(
      name: "Albshausen, Witzenhausen", latlng: LatLng(51.3763976, 9.8374414)),
  Mapping(name: "Albungen, Eschwege", latlng: LatLng(51.2294456, 9.9963014)),
  Mapping(name: "Algenroth, Heidenrod", latlng: LatLng(50.1683556, 7.8909137)),
  Mapping(name: "Alheim", latlng: LatLng(51.0333, 9.66667)),
  Mapping(name: "Allendorf (Eder)", latlng: LatLng(51.0477161, 8.6623895)),
  Mapping(name: "Allendorf (Lumda)", latlng: LatLng(50.6786638, 8.8229355)),
  Mapping(name: "Allendorf, Dautphetal", latlng: LatLng(50.847038, 8.5845922)),
  Mapping(
      name: "Allendorf, Frankenau",
      latlng: LatLng(51.0775666, 8.908305919809873)),
  Mapping(
      name: "Allendorf, Frielendorf", latlng: LatLng(50.9892935, 9.3350368)),
  Mapping(
      name: "Allendorf, Greifenstein",
      latlng: LatLng(50.5670984, 8.281918672166473)),
  Mapping(
      name: "Allendorf, Haiger", latlng: LatLng(50.7661294, 8.146805481293221)),
  Mapping(name: "Allendorf, Kirchheim", latlng: LatLng(50.8282565, 9.5272708)),
  Mapping(name: "Allendorf, Merenberg", latlng: LatLng(50.4969124, 8.1964562)),
  Mapping(
      name: "Allendorf, Schwalmstadt", latlng: LatLng(50.9469799, 9.2145825)),
  Mapping(name: "Allendorf", latlng: LatLng(50.2679502, 7.9982619)),
  Mapping(
      name: "Allendorf/Lahn, Gießen",
      latlng: LatLng(50.55199325, 8.617073236990723)),
  Mapping(
      name: "Alleringhausen, Korbach", latlng: LatLng(51.2651273, 8.763573)),
  Mapping(
      name: "Allertshausen, Rabenau",
      latlng: LatLng(50.65077205, 8.851057328465139)),
  Mapping(
      name: "Allertshofen, Modautal", latlng: LatLng(49.7455956, 8.7149724)),
  Mapping(
      name: "Allmendfeld, Gernsheim", latlng: LatLng(49.7724984, 8.5269538)),
  Mapping(name: "Allmenrod, Lauterbach", latlng: LatLng(50.6303136, 9.3279504)),
  Mapping(
      name: "Allmershausen, Bad Hersfeld",
      latlng: LatLng(50.8865132, 9.6617679)),
  Mapping(name: "Allmus, Hofbieber", latlng: LatLng(50.5955906, 9.8148393)),
  Mapping(
      name: "Allmuthshausen, Homberg (Efze)",
      latlng: LatLng(50.9757274, 9.4321248)),
  Mapping(
      name: "Allmuthshausen, Homberg", latlng: LatLng(50.9757274, 9.4321248)),
  Mapping(name: "Allna, Weimar", latlng: LatLng(50.7711942, 8.6518846)),
  Mapping(name: "Almendorf, Petersberg", latlng: LatLng(50.5766585, 9.7455504)),
  Mapping(name: "Alraft, Waldeck", latlng: LatLng(51.2417105, 8.9698847)),
  Mapping(name: "Alsbach-Hähnlein", latlng: LatLng(49.7383506, 8.5950049)),
  Mapping(
      name: "Alsbach, Alsbach-Hähnlein", latlng: LatLng(49.736864, 8.5713252)),
  Mapping(
      name: "Alsberg, Bad Soden-Salmünster",
      latlng: LatLng(50.2680529, 9.429103)),
  Mapping(name: "Alsfeld", latlng: LatLng(50.7523545, 9.268355)),
  Mapping(
      name: "Altefeld, Herleshausen", latlng: LatLng(51.0520366, 10.1211101)),
  Mapping(
      name: "Alten-Buseck, Buseck",
      latlng: LatLng(50.623721599999996, 8.753157481937569)),
  Mapping(name: "Altenbauna, Baunatal", latlng: LatLng(51.2597506, 9.4162672)),
  Mapping(
      name: "Altenberger Straße, Wetzlar",
      latlng: LatLng(50.5598542, 8.4838566)),
  Mapping(
      name: "Altenbrunslar, Felsberg", latlng: LatLng(51.1665667, 9.4459341)),
  Mapping(name: "Altenburg, Alsfeld", latlng: LatLng(50.7344311, 9.2810579)),
  Mapping(
      name: "Altenburg, Felsberg", latlng: LatLng(51.1191213, 9.405876405625)),
  Mapping(
      name: "Altenburschla, Wanfried", latlng: LatLng(51.1503699, 10.1765779)),
  Mapping(name: "Altendorf, Naumburg", latlng: LatLng(51.2146376, 9.2043852)),
  Mapping(
      name: "Altenfeld, Gersfeld (Rhön)",
      latlng: LatLng(50.4564978, 9.849424185399812)),
  Mapping(
      name: "Altenfeld, Gersfeld",
      latlng: LatLng(50.4564978, 9.849424185399812)),
  Mapping(name: "Altengronau, Sinntal", latlng: LatLng(50.2504302, 9.616564)),
  Mapping(
      name: "Altenhain, Bad Soden am Taunus",
      latlng: LatLng(50.15942285, 8.462535639743752)),
  Mapping(
      name: "Altenhain, Laubach",
      latlng: LatLng(50.5598187, 9.113312417872667)),
  Mapping(name: "Altenhaina", latlng: LatLng(51.0459732, 8.943524)),
  Mapping(
      name: "Altenhaßlau, Linsengericht",
      latlng: LatLng(50.1891276, 9.1985061)),
  Mapping(
      name: "Altenhasungen, Wolfhagen", latlng: LatLng(51.3397875, 9.2281079)),
  Mapping(
      name: "Altenkirchen, Braunfels", latlng: LatLng(50.4687413, 8.4077796)),
  Mapping(
      name: "Altenkirchen, Hohenahr",
      latlng: LatLng(50.6795298, 8.443616526828706)),
  Mapping(
      name: "Altenlotheim, Frankenau", latlng: LatLng(51.1293364, 8.9184478)),
  Mapping(
      name: "Altenmittlau, Freigericht", latlng: LatLng(50.1428053, 9.1419873)),
  Mapping(name: "Altenritte, Baunatal", latlng: LatLng(51.2615633, 9.3999379)),
  Mapping(
      name: "Altenschlirf, Herbstein", latlng: LatLng(50.5349582, 9.3864449)),
  Mapping(
      name: "Altenstadt (Kernstadt), Altenstadt",
      latlng: LatLng(50.9196787, 8.5257684)),
  Mapping(name: "Altenstädt, Naumburg", latlng: LatLng(51.2738993, 9.1922452)),
  Mapping(name: "Altenstadt", latlng: LatLng(47.823657, 10.8734632)),
  Mapping(name: "Altenstadt", latlng: LatLng(47.823657, 10.8734632)),
  Mapping(name: "Altenvers, Lohra", latlng: LatLng(50.7099872, 8.6194868)),
  Mapping(
      name: "Altheim, Münster (Hessen)", latlng: LatLng(49.9152232, 8.8915771)),
  Mapping(name: "Altheim, Münster", latlng: LatLng(49.9152232, 8.8915771)),
  Mapping(name: "Altlechtern", latlng: LatLng(49.6481396, 8.810558256862198)),
  Mapping(name: "Altmorschen, Morschen", latlng: LatLng(51.0692386, 9.6130275)),
  Mapping(
      name: "Altstadt, Frankfurt am Main",
      latlng: LatLng(50.1104436, 8.6823506)),
  Mapping(
      name: "Altweilnau, Weilrod",
      latlng: LatLng(50.31224455, 8.434543663274324)),
  Mapping(
      name: "Altwiedermus, Ronneburg", latlng: LatLng(50.2338397, 9.0522106)),
  Mapping(
      name: "Altwildungen, Bad Wildungen",
      latlng: LatLng(51.133650700000004, 9.113937220231474)),
  Mapping(
      name: "Amdorf, Herborn", latlng: LatLng(50.6822506, 8.258796665755181)),
  Mapping(name: "Amelose, Dautphetal", latlng: LatLng(50.8305697, 8.5416679)),
  Mapping(
      name: "Ammenhausen, Diemelstadt", latlng: LatLng(51.445295, 9.0492191)),
  Mapping(name: "Amönau, Wetter", latlng: LatLng(50.9082765, 8.6860662)),
  Mapping(name: "Amöneburg", latlng: LatLng(50.79946485, 8.941291794880504)),
  Mapping(name: "Amöneburg", latlng: LatLng(50.79946485, 8.941291794880504)),
  Mapping(name: "Angelburg", latlng: LatLng(50.809483, 8.4307783)),
  Mapping(name: "Angenrod, Alsfeld", latlng: LatLng(50.7621519, 9.2080923)),
  Mapping(
      name: "Angersbach, Wartenberg", latlng: LatLng(50.6271362, 9.4453587)),
  Mapping(
      name: "Annelsbach, Höchst i. Odw.",
      latlng: LatLng(49.7809374, 8.9601559)),
  Mapping(
      name: "Annerod, Fernwald",
      latlng: LatLng(50.577349749999996, 8.763864262945301)),
  Mapping(name: "Anraff, Edertal", latlng: LatLng(51.1443155, 9.1431817)),
  Mapping(name: "Anspach, Neu-Anspach", latlng: LatLng(50.3008026, 8.5147184)),
  Mapping(name: "Antrifttal", latlng: LatLng(50.7887424, 9.1951609)),
  Mapping(name: "Anzefahr, Kirchhain", latlng: LatLng(50.8443047, 8.8649499)),
  Mapping(name: "Appenfeld, Knüllwald", latlng: LatLng(50.9407624, 9.4816302)),
  Mapping(name: "Appenhain, Gilserberg", latlng: LatLng(50.9199496, 9.0791346)),
  Mapping(
      name: "Appenrod, Homberg (Ohm)", latlng: LatLng(50.7459528, 9.0450354)),
  Mapping(name: "Appenrod, Homberg", latlng: LatLng(50.7459528, 9.0450354)),
  Mapping(
      name: "Arborn, Greifenstein",
      latlng: LatLng(50.58588195, 8.170913441708095)),
  Mapping(
      name: "Archfeld, Herleshausen", latlng: LatLng(51.0415265, 10.1465485)),
  Mapping(
      name: "Arenborn, Wesertal",
      latlng: LatLng(51.600518300000005, 9.638888446725506)),
  Mapping(name: "Arfurt, Runkel", latlng: LatLng(50.4072606, 8.1996803)),
  Mapping(name: "Argenstein, Weimar", latlng: LatLng(50.7431654, 8.7342404)),
  Mapping(name: "Arheilgen, Darmstadt", latlng: LatLng(49.9113523, 8.6542479)),
  Mapping(name: "Armenhof, Dipperz", latlng: LatLng(50.5617554, 9.788393)),
  Mapping(
      name: "Armsfeld, Bad Wildungen", latlng: LatLng(51.0512033, 9.064115)),
  Mapping(
      name: "Arnoldshain, Schmitten im Taunus",
      latlng: LatLng(50.258213049999995, 8.464846195668951)),
  Mapping(
      name: "Arnsbach, Borken (Hessen)", latlng: LatLng(51.0539939, 9.2466849)),
  Mapping(name: "Arnsbach, Borken", latlng: LatLng(51.0539939, 9.2466849)),
  Mapping(name: "Arnshain, Kirtorf", latlng: LatLng(50.8068627, 9.1572487)),
  Mapping(
      name: "Arzell, Eiterfeld", latlng: LatLng(50.7644256, 9.781102601255233)),
  Mapping(name: "Asbach, Bad Hersfeld", latlng: LatLng(50.8341409, 9.6670057)),
  Mapping(name: "Asbach, Modautal", latlng: LatLng(49.776948, 8.7688939)),
  Mapping(
      name: "Aschbach, Wald-Michelbach", latlng: LatLng(49.5759043, 8.8529035)),
  Mapping(
      name: "Ascherode, Schwalmstadt", latlng: LatLng(50.9048904, 9.2125656)),
  Mapping(name: "Asel, Vöhl", latlng: LatLng(51.1953584, 8.9450919)),
  Mapping(name: "Asmushausen, Bebra", latlng: LatLng(51.0095949, 9.8184989)),
  Mapping(
      name: "Asselbrunn, Michelstadt", latlng: LatLng(49.6969037, 8.9979019)),
  Mapping(name: "Assenheim, Niddatal", latlng: LatLng(50.2965781, 8.8159574)),
  Mapping(name: "Aßlar", latlng: LatLng(50.5927946, 8.4649082)),
  Mapping(
      name: "Assmannshausen, Rüdesheim am Rhein",
      latlng: LatLng(49.9889929, 7.8651115)),
  Mapping(name: "Asterode, Neukirchen", latlng: LatLng(50.8544143, 9.3856502)),
  Mapping(name: "Astheim, Trebur", latlng: LatLng(49.9361351, 8.3821788)),
  Mapping(name: "Atzbach, Lahnau", latlng: LatLng(50.5779547, 8.5893463)),
  Mapping(
      name: "Atzelrode, Rotenburg an der Fulda",
      latlng: LatLng(50.9876118, 9.6856996)),
  Mapping(name: "Atzenhain, Mücke", latlng: LatLng(50.6363503, 8.9835726)),
  Mapping(name: "Aua, Neuenstein", latlng: LatLng(50.9157673, 9.5703331)),
  Mapping(
      name: "Audenschmiede, Weilmünster",
      latlng: LatLng(50.4102344, 8.3914574)),
  Mapping(name: "Aue, Wanfried", latlng: LatLng(51.17888, 10.1255383)),
  Mapping(name: "Auerbach, Bensheim", latlng: LatLng(49.7035106, 8.6198645)),
  Mapping(
      name: "Auf der Heide, Espenau", latlng: LatLng(51.4016912, 9.4933939)),
  Mapping(name: "Aufenau, Wächtersbach", latlng: LatLng(50.2533604, 9.3244531)),
  Mapping(name: "Aulendiebach, Büdingen", latlng: LatLng(50.3151896, 9.066947)),
  Mapping(
      name: "Aulenhausen, Weilmünster", latlng: LatLng(50.4329169, 8.3262922)),
  Mapping(
      name: "Aulhausen, Rüdesheim am Rhein",
      latlng: LatLng(50.018563, 7.876781611145786)),
  Mapping(name: "Aumenau, Villmar", latlng: LatLng(50.4037723, 8.2519392)),
  Mapping(name: "Auringen, Wiesbaden", latlng: LatLng(50.1221647, 8.3288827)),
  Mapping(name: "Ausbach, Hohenroda", latlng: LatLng(50.8447502, 9.9120245)),
  Mapping(name: "Babenhausen", latlng: LatLng(49.9562183, 8.9460279)),
  Mapping(name: "Babenhausen", latlng: LatLng(49.9562183, 8.9460279)),
  Mapping(name: "Babenhausen", latlng: LatLng(49.9562183, 8.9460279)),
  Mapping(name: "Bad Arolsen", latlng: LatLng(51.3816043, 9.0147661)),
  Mapping(name: "Bad Arolsen", latlng: LatLng(51.3816043, 9.0147661)),
  Mapping(
      name: "Bad Camberg (Kernstadt), Bad Camberg",
      latlng: LatLng(50.2964521, 8.2550751)),
  Mapping(name: "Bad Camberg", latlng: LatLng(50.299603, 8.2673122)),
  Mapping(name: "Bad Camberg", latlng: LatLng(50.299603, 8.2673122)),
  Mapping(name: "Bad Emstal", latlng: LatLng(51.2558597, 9.2493249)),
  Mapping(name: "Bad Endbach", latlng: LatLng(50.7517656, 8.4945003)),
  Mapping(
      name: "Bad Hersfeld (Kernstadt), Bad Hersfeld",
      latlng: LatLng(50.87209235, 9.703413020941213)),
  Mapping(name: "Bad Hersfeld", latlng: LatLng(50.8681341, 9.7068481)),
  Mapping(name: "Bad Hersfeld", latlng: LatLng(50.8681341, 9.7068481)),
  Mapping(name: "Bad Homburg v.d. Höhe", latlng: LatLng(50.2267699, 8.6169093)),
  Mapping(
      name: "Bad Homburg vor der Höhe", latlng: LatLng(50.2267699, 8.6169093)),
  Mapping(
      name: "Bad Homburg, Bad Homburg vor der Höhe",
      latlng: LatLng(50.2205135, 8.6212625)),
  Mapping(name: "Bad Karlshafen", latlng: LatLng(51.6425572, 9.4502277)),
  Mapping(name: "Bad Karlshafen", latlng: LatLng(51.6425572, 9.4502277)),
  Mapping(name: "Bad König", latlng: LatLng(49.7435067, 9.0262376)),
  Mapping(name: "Bad König", latlng: LatLng(49.7435067, 9.0262376)),
  Mapping(name: "Bad Nauheim", latlng: LatLng(50.3681107, 8.7473608)),
  Mapping(name: "Bad Nauheim", latlng: LatLng(50.3681107, 8.7473608)),
  Mapping(name: "Bad Orb, Bad Orb", latlng: LatLng(50.2295097, 9.3478611)),
  Mapping(name: "Bad Orb", latlng: LatLng(50.2276774, 9.3485142)),
  Mapping(name: "Bad Salzhausen, Nidda", latlng: LatLng(50.4158016, 8.9848348)),
  Mapping(
      name: "Bad Salzschlirf, Bad Salzschlirf",
      latlng: LatLng(50.6238209, 9.5061166)),
  Mapping(name: "Bad Salzschlirf", latlng: LatLng(50.6323557, 9.5003692)),
  Mapping(name: "Bad Schwalbach", latlng: LatLng(50.141688, 8.071992)),
  Mapping(name: "Bad Schwalbach", latlng: LatLng(50.141688, 8.071992)),
  Mapping(name: "Bad Soden am Taunus", latlng: LatLng(50.1429142, 8.5029259)),
  Mapping(name: "Bad Soden-Salmünster", latlng: LatLng(50.2801792, 9.3704249)),
  Mapping(
      name: "Bad Soden, Bad Soden am Taunus",
      latlng: LatLng(50.1431713, 8.5041132)),
  Mapping(
      name: "Bad Soden, Bad Soden-Salmünster",
      latlng: LatLng(50.2889894, 9.3655649)),
  Mapping(
      name: "Bad Sooden-Allendorf (Kernstadt)[2], Bad Sooden-Allendorf",
      latlng: LatLng(51.2695391, 9.9719975)),
  Mapping(name: "Bad Sooden-Allendorf", latlng: LatLng(51.2695391, 9.9719975)),
  Mapping(name: "Bad Sooden-Allendorf", latlng: LatLng(51.2695391, 9.9719975)),
  Mapping(
      name: "Bad Vilbel (Kernstadt), Bad Vilbel",
      latlng: LatLng(50.1886255, 8.7395439)),
  Mapping(name: "Bad Vilbel", latlng: LatLng(50.1804837, 8.7410776)),
  Mapping(name: "Bad Vilbel", latlng: LatLng(50.1804837, 8.7410776)),
  Mapping(
      name: "Bad Weilbach, Flörsheim am Main",
      latlng: LatLng(50.0340204, 8.429213456116669)),
  Mapping(
      name: "Bad Wildungen (Kernstadt), Bad Wildungen",
      latlng: LatLng(51.1196071, 9.1364632)),
  Mapping(name: "Bad Wildungen", latlng: LatLng(51.1202493, 9.1252933)),
  Mapping(name: "Bad Wildungen", latlng: LatLng(51.1202493, 9.1252933)),
  Mapping(
      name: "Bad Wilhelmshöhe, Kassel", latlng: LatLng(51.3095515, 9.4299997)),
  Mapping(name: "Bad Zwesten", latlng: LatLng(51.0408015, 9.1624486)),
  Mapping(name: "Bad Zwesten", latlng: LatLng(51.0408015, 9.1624486)),
  Mapping(name: "Bahnhof Ottrau", latlng: LatLng(50.8158103, 9.4096842)),
  Mapping(
      name: "Bahnhofsviertel, Frankfurt am Main",
      latlng: LatLng(50.1084107, 8.6681512)),
  Mapping(
      name: "Baiersröderhof, Hammersbach",
      latlng: LatLng(50.229313, 8.9490694)),
  Mapping(name: "Balhorn, Bad Emstal", latlng: LatLng(51.2739857, 9.234728)),
  Mapping(
      name: "Balkhausen, Seeheim-Jugenheim",
      latlng: LatLng(49.7313562, 8.6595589)),
  Mapping(
      name: "Ballersbach, Mittenaar",
      latlng: LatLng(50.67065015, 8.364291720089655)),
  Mapping(name: "Bannerod, Grebenhain", latlng: LatLng(50.5017123, 9.387531)),
  Mapping(
      name: "Barig-Selbenhausen, Merenberg",
      latlng: LatLng(50.5212765, 8.2019096)),
  Mapping(
      name: "Bärstadt, Schlangenbad", latlng: LatLng(50.1023196, 8.0733307)),
  Mapping(name: "Basdorf, Vöhl", latlng: LatLng(51.2062304, 8.9775849)),
  Mapping(name: "Batten, Hilders", latlng: LatLng(50.5551386, 10.0105626)),
  Mapping(name: "Battenberg (Eder)", latlng: LatLng(51.0323524, 8.6112782)),
  Mapping(name: "Battenberg", latlng: LatLng(51.0323524, 8.6112782)),
  Mapping(
      name: "Battenfeld, Allendorf (Eder)",
      latlng: LatLng(51.0200867, 8.6780933)),
  Mapping(name: "Battenfeld, Allendorf", latlng: LatLng(51.0188885, 8.6600949)),
  Mapping(
      name: "Battenhausen, Haina (Kloster)",
      latlng: LatLng(51.0321723, 9.0250732)),
  Mapping(name: "Battenhausen, Haina", latlng: LatLng(51.0321723, 9.0250732)),
  Mapping(
      name: "Bauerbach, Marburg",
      latlng: LatLng(50.81612815, 8.825804381394287)),
  Mapping(name: "Bauernheim, Friedberg", latlng: LatLng(50.3386817, 8.8061207)),
  Mapping(
      name: "Bauhaus, Nentershausen", latlng: LatLng(50.9945821, 9.9433274)),
  Mapping(name: "Baumbach, Alheim", latlng: LatLng(51.0242409, 9.6687772)),
  Mapping(name: "Baunatal", latlng: LatLng(51.2550775, 9.4119007)),
  Mapping(
      name: "Bauschheim, Rüsselsheim am Main",
      latlng: LatLng(49.9614831, 8.3776225)),
  Mapping(name: "Beberbeck, Hofgeismar", latlng: LatLng(51.5345413, 9.4762543)),
  Mapping(
      name: "Bebra (Kernstadt), Bebra",
      latlng: LatLng(50.96947575, 9.790883688239205)),
  Mapping(name: "Bebra", latlng: LatLng(50.9835038, 9.8388054)),
  Mapping(name: "Bebra", latlng: LatLng(50.9835038, 9.8388054)),
  Mapping(
      name: "Bechlingen, Aßlar",
      latlng: LatLng(50.62396185, 8.446447017294657)),
  Mapping(name: "Bechtheim, Hünstetten", latlng: LatLng(50.274178, 8.1875652)),
  Mapping(
      name: "Beedenkirchen, Lautertal", latlng: LatLng(49.7338578, 8.7066162)),
  Mapping(name: "Beenhausen, Ludwigsau", latlng: LatLng(50.9654682, 9.6300962)),
  Mapping(
      name: "Beerfelden, Oberzent",
      latlng: LatLng(49.555931799999996, 8.952727509818992)),
  Mapping(
      name: "Beerfurth, Reichelsheim (Odenwald)",
      latlng: LatLng(49.720497, 8.8673614)),
  Mapping(
      name: "Beerfurth, Reichelsheim", latlng: LatLng(49.720497, 8.8673614)),
  Mapping(
      name: "Beienheim, Reichelsheim (Wetterau)",
      latlng: LatLng(50.3580243, 8.8744648)),
  Mapping(
      name: "Beienheim, Reichelsheim",
      latlng: LatLng(50.35986495, 8.815387805177181)),
  Mapping(
      name: "Beiershausen, Bad Hersfeld",
      latlng: LatLng(50.8251861, 9.6501597)),
  Mapping(
      name: "Beilstein, Greifenstein",
      latlng: LatLng(50.6137032, 8.253557371296303)),
  Mapping(name: "Beiseförth, Malsfeld", latlng: LatLng(51.0802436, 9.5474844)),
  Mapping(
      name: "Bellersdorf, Mittenaar",
      latlng: LatLng(50.6686614, 8.422742719396517)),
  Mapping(
      name: "Bellersheim, Hungen",
      latlng: LatLng(50.4586602, 8.837015767729927)),
  Mapping(
      name: "Bellings, Steinau an der Straße",
      latlng: LatLng(50.307019, 9.5051555)),
  Mapping(name: "Bellmuth, Ranstadt", latlng: LatLng(50.3657743, 9.0149513)),
  Mapping(
      name: "Bellnhausen, Fronhausen",
      latlng: LatLng(50.70796485, 8.725661057980679)),
  Mapping(
      name: "Bellnhausen, Gilserberg", latlng: LatLng(50.9220615, 9.0610009)),
  Mapping(
      name: "Bellnhausen, Gladenbach", latlng: LatLng(50.7965155, 8.5746587)),
  Mapping(
      name: "Beltershain, Grünberg",
      latlng: LatLng(50.624591249999995, 8.933323060201989)),
  Mapping(
      name: "Beltershausen-Frauenberg, Ebsdorfergrund",
      latlng: LatLng(50.7621565, 8.8028797)),
  Mapping(name: "Bengendorf, Heringen", latlng: LatLng(50.8907236, 9.9785795)),
  Mapping(name: "Benkhausen, Diemelsee", latlng: LatLng(51.3328932, 8.7896309)),
  Mapping(
      name: "Bensheim-Mitte, Bensheim",
      latlng: LatLng(49.6761865, 8.624602133522135)),
  Mapping(
      name: "Bensheim-West, Bensheim",
      latlng: LatLng(49.67711065, 8.601578398604062)),
  Mapping(name: "Bensheim", latlng: LatLng(49.6810158, 8.6227577)),
  Mapping(name: "Berfa, Alsfeld", latlng: LatLng(50.7744675, 9.3587365)),
  Mapping(name: "Berge, Homberg (Efze)", latlng: LatLng(51.0564888, 9.3793032)),
  Mapping(name: "Berge, Homberg", latlng: LatLng(51.0564888, 9.3793032)),
  Mapping(name: "Berge, Neu-Eichenberg", latlng: LatLng(51.3851149, 9.8955939)),
  Mapping(
      name: "Bergen-Enkheim, Frankfurt am Main",
      latlng: LatLng(50.1580742, 8.761889801442825)),
  Mapping(
      name: "Bergfreiheit, Bad Wildungen",
      latlng: LatLng(51.0505537, 9.0934686)),
  Mapping(
      name: "Berghausen, Aßlar", latlng: LatLng(50.5834079, 8.420083730794197)),
  Mapping(name: "Bergheim, Edertal", latlng: LatLng(51.1688916, 9.1364477)),
  Mapping(name: "Bergheim, Ortenberg", latlng: LatLng(50.346563, 9.0863375)),
  Mapping(name: "Bergheim, Spangenberg", latlng: LatLng(51.1068409, 9.6431963)),
  Mapping(
      name: "Berghofen, Battenberg (Eder)",
      latlng: LatLng(51.004476, 8.6724545)),
  Mapping(name: "Berghofen, Battenberg", latlng: LatLng(51.004476, 8.6724545)),
  Mapping(
      name: "Bergshausen, Fuldabrück", latlng: LatLng(51.2684595, 9.5007979)),
  Mapping(name: "Berkach, Groß-Gerau", latlng: LatLng(49.8992326, 8.4834158)),
  Mapping(name: "Berkatal", latlng: LatLng(51.2333, 9.91667)),
  Mapping(
      name: "Berkersheim, Frankfurt am Main",
      latlng: LatLng(50.1732889, 8.6973119)),
  Mapping(
      name: "Berlepsch-Ellerode-Hübenthal[5], Witzenhausen",
      latlng: LatLng(51.394868, 9.8285633)),
  Mapping(
      name: "Bermbach, Waldems", latlng: LatLng(50.2320233, 8.311114711801917)),
  Mapping(
      name: "Bermbach, Weilburg",
      latlng: LatLng(50.48758545, 8.350294365977629)),
  Mapping(
      name: "Bermoll, Aßlar", latlng: LatLng(50.65870515, 8.447107519353478)),
  Mapping(
      name: "Bermuthshain, Grebenhain", latlng: LatLng(50.4735534, 9.312237)),
  Mapping(name: "Bernbach, Freigericht", latlng: LatLng(50.1550637, 9.145584)),
  Mapping(name: "Berndorf, Twistetal", latlng: LatLng(51.3095502, 8.9055901)),
  Mapping(
      name: "Berndshausen, Knüllwald", latlng: LatLng(51.0433908, 9.4810241)),
  Mapping(name: "Berneburg, Sontra", latlng: LatLng(51.0586237, 9.885082)),
  Mapping(
      name: "Bernhards, Fulda", latlng: LatLng(50.601551, 9.72268510714921)),
  Mapping(name: "Bernsburg, Antrifttal", latlng: LatLng(50.8251321, 9.1755691)),
  Mapping(name: "Bernsdorf, Cölbe", latlng: LatLng(50.8611105, 8.804778)),
  Mapping(name: "Bernsfeld, Mücke", latlng: LatLng(50.6686109, 8.9908951)),
  Mapping(name: "Bernshausen, Schlitz", latlng: LatLng(50.6545998, 9.5360824)),
  Mapping(
      name: "Bersrod, Reiskirchen",
      latlng: LatLng(50.62058985, 8.856943707628012)),
  Mapping(name: "Berstadt, Wölfersheim", latlng: LatLng(50.4259441, 8.864818)),
  Mapping(name: "Beselich", latlng: LatLng(50.4633914, 8.14569181789609)),
  Mapping(name: "Besges, Fulda", latlng: LatLng(50.5496245, 9.586760525184541)),
  Mapping(name: "Besse, Edermünde", latlng: LatLng(51.2222322, 9.3877075)),
  Mapping(name: "Bessungen, Darmstadt", latlng: LatLng(49.8593692, 8.6515408)),
  Mapping(
      name: "Bettenbach, Mörlenbach", latlng: LatLng(49.5905109, 8.7242646)),
  Mapping(name: "Bettenhausen, Kassel", latlng: LatLng(51.3049957, 9.5312414)),
  Mapping(
      name: "Bettenhausen, Lich",
      latlng: LatLng(50.471822700000004, 8.836358518232279)),
  Mapping(
      name: "Betzenrod, Eiterfeld",
      latlng: LatLng(50.7330957, 9.770441430240064)),
  Mapping(name: "Betzenrod, Schotten", latlng: LatLng(50.5181735, 9.1215971)),
  Mapping(
      name: "Betziesdorf, Kirchhain", latlng: LatLng(50.8609185, 8.8455131)),
  Mapping(
      name: "Betzigerode, Bad Zwesten", latlng: LatLng(51.0718533, 9.188902)),
  Mapping(name: "Beuerbach, Hünstetten", latlng: LatLng(50.2818059, 8.2095493)),
  Mapping(
      name: "Beuern, Buseck", latlng: LatLng(50.63053395, 8.831379409464295)),
  Mapping(name: "Beuern, Felsberg", latlng: LatLng(51.1171482, 9.4665348)),
  Mapping(name: "Biblis", latlng: LatLng(49.6879986, 8.4534916)),
  Mapping(name: "Biblis", latlng: LatLng(49.6879986, 8.4534916)),
  Mapping(
      name: "Bicken, Mittenaar",
      latlng: LatLng(50.692040399999996, 8.380563531089333)),
  Mapping(
      name: "Bickenbach, Bickenbach", latlng: LatLng(49.7604953, 8.6036351)),
  Mapping(name: "Bickenbach", latlng: LatLng(50.1264152, 7.5266937)),
  Mapping(name: "Bieben, Grebenau", latlng: LatLng(50.7543367, 9.4377169)),
  Mapping(name: "Bieber, Biebergemünd", latlng: LatLng(50.1613025, 9.3282055)),
  Mapping(
      name: "Bieber, Offenbach am Main", latlng: LatLng(50.0880374, 8.8062219)),
  Mapping(name: "Biebergemünd", latlng: LatLng(50.1801457, 9.2918379)),
  Mapping(name: "Biebertal", latlng: LatLng(50.617047, 8.6046132)),
  Mapping(
      name: "Biebesheim am Rhein, Biebesheim am Rhein",
      latlng: LatLng(49.7818406, 8.4740161)),
  Mapping(name: "Biebesheim am Rhein", latlng: LatLng(49.7815684, 8.4660576)),
  Mapping(
      name: "Biebighausen, Hatzfeld (Eder)",
      latlng: LatLng(51.0141545, 8.5673989)),
  Mapping(
      name: "Biebighausen, Hatzfeld", latlng: LatLng(51.0141545, 8.5673989)),
  Mapping(name: "Biebrich, Wiesbaden", latlng: LatLng(50.0397547, 8.2339039)),
  Mapping(name: "Biedebach, Ludwigsau", latlng: LatLng(50.9212607, 9.6746295)),
  Mapping(
      name: "Biedenkopf (Kernstadt), Biedenkopf",
      latlng: LatLng(50.9087451, 8.5305743)),
  Mapping(name: "Biedenkopf", latlng: LatLng(50.9158122, 8.5270214)),
  Mapping(name: "Biedenkopf", latlng: LatLng(50.9158122, 8.5270214)),
  Mapping(name: "Bierstadt, Wiesbaden", latlng: LatLng(50.0855871, 8.2775925)),
  Mapping(
      name: "Billertshausen, Alsfeld", latlng: LatLng(50.7476957, 9.1995003)),
  Mapping(
      name: "Billings, Fischbachtal", latlng: LatLng(49.7551825, 8.7950515)),
  Mapping(name: "Bimbach, Großenlüder", latlng: LatLng(50.5741235, 9.570155)),
  Mapping(name: "Bindsachsen, Kefenrod", latlng: LatLng(50.3533652, 9.1674252)),
  Mapping(name: "Bingenheim, Echzell", latlng: LatLng(50.3727999, 8.8966408)),
  Mapping(name: "Binsförth, Morschen", latlng: LatLng(51.0725079, 9.5709295)),
  Mapping(name: "Birkenau", latlng: LatLng(49.5625034, 8.7069344)),
  Mapping(name: "Birkenau", latlng: LatLng(49.5625034, 8.7069344)),
  Mapping(
      name: "Birkenbringhausen, Burgwald",
      latlng: LatLng(51.0223428, 8.732712)),
  Mapping(name: "Birkert, Brombachtal", latlng: LatLng(49.7514377, 8.9426422)),
  Mapping(name: "Birklar, Lich", latlng: LatLng(50.4981194, 8.818713212624399)),
  Mapping(name: "Birstein", latlng: LatLng(50.3923, 9.30438)),
  Mapping(name: "Birstein", latlng: LatLng(50.3923, 9.30438)),
  Mapping(name: "Bischhausen, Neuental", latlng: LatLng(51.0117952, 9.201871)),
  Mapping(
      name: "Bischhausen, Waldkappel", latlng: LatLng(51.1381422, 9.9376153)),
  Mapping(
      name: "Bischoffen, Bischoffen",
      latlng: LatLng(50.719746400000005, 8.448925905057777)),
  Mapping(name: "Bischoffen", latlng: LatLng(50.7074729, 8.4476626)),
  Mapping(
      name: "Bischofferode, Spangenberg", latlng: LatLng(51.122263, 9.758256)),
  Mapping(
      name: "Bischofsheim, Bischofsheim",
      latlng: LatLng(50.0332769, 10.6367643)),
  Mapping(name: "Bischofsheim, Maintal", latlng: LatLng(50.1482175, 8.8023159)),
  Mapping(name: "Bischofsheim", latlng: LatLng(48.4876657, 7.4901898)),
  Mapping(
      name: "Biskirchen, Leun", latlng: LatLng(50.53964515, 8.299760030153706)),
  Mapping(
      name: "Bissenberg, Leun",
      latlng: LatLng(50.556756050000004, 8.300889844186425)),
  Mapping(name: "Bisses, Echzell", latlng: LatLng(50.3967392, 8.904651)),
  Mapping(name: "Blankenau, Hosenfeld", latlng: LatLng(50.5431042, 9.471313)),
  Mapping(name: "Blankenbach, Sontra", latlng: LatLng(51.0098024, 10.0053693)),
  Mapping(name: "Blankenheim, Bebra", latlng: LatLng(50.9395986, 9.7755697)),
  Mapping(
      name: "Blasbach, Wetzlar",
      latlng: LatLng(50.616069800000005, 8.505902218764092)),
  Mapping(
      name: "Bleichenbach, Ortenberg", latlng: LatLng(50.3269046, 9.0486592)),
  Mapping(
      name: "Bleidenrod, Homberg (Ohm)", latlng: LatLng(50.6903966, 9.020549)),
  Mapping(name: "Bleidenrod, Homberg", latlng: LatLng(50.6903966, 9.020549)),
  Mapping(
      name: "Bleidenstadt, Taunusstein", latlng: LatLng(50.1375329, 8.1385042)),
  Mapping(name: "Blessenbach, Weinbach", latlng: LatLng(50.4126339, 8.3019047)),
  Mapping(
      name: "Blickershausen, Witzenhausen",
      latlng: LatLng(51.3821569, 9.7932246)),
  Mapping(
      name: "Blitzenrod, Lauterbach", latlng: LatLng(50.6210381, 9.3931123)),
  Mapping(name: "Blofeld, Reichelsheim", latlng: LatLng(50.3633338, 8.9239162)),
  Mapping(
      name: "Bobenhausen I, Ranstadt", latlng: LatLng(50.3708127, 9.0378732)),
  Mapping(
      name: "Bobenhausen II, Ulrichstein",
      latlng: LatLng(50.5807151, 9.1352835)),
  Mapping(name: "Bobstadt, Bürstadt", latlng: LatLng(49.6632906, 8.4451267)),
  Mapping(name: "Böckels, Petersberg", latlng: LatLng(50.5524225, 9.7599192)),
  Mapping(
      name: "Bockendorf, Haina (Kloster)",
      latlng: LatLng(51.0208166, 8.9404649)),
  Mapping(name: "Bockendorf, Haina", latlng: LatLng(51.0208166, 8.9404649)),
  Mapping(
      name: "Bockenheim, Frankfurt am Main",
      latlng: LatLng(50.1233115, 8.6460563)),
  Mapping(
      name: "Bockenrod, Reichelsheim (Odenwald)",
      latlng: LatLng(49.7082901, 8.8640623)),
  Mapping(
      name: "Bockenrod, Reichelsheim", latlng: LatLng(49.7082901, 8.8640623)),
  Mapping(name: "Böddiger, Felsberg", latlng: LatLng(51.151719, 9.4160513)),
  Mapping(
      name: "Bodenhausen, Habichtswald", latlng: LatLng(51.3374892, 9.3033062)),
  Mapping(name: "Bodenrod, Butzbach", latlng: LatLng(50.4008972, 8.5542978)),
  Mapping(name: "Bodes, Hauneck", latlng: LatLng(50.8057419, 9.7448273)),
  Mapping(name: "Böhne, Edertal", latlng: LatLng(51.1971751, 9.129097)),
  Mapping(name: "Böllstein, Brombachtal", latlng: LatLng(49.739446, 8.9170824)),
  Mapping(
      name: "Bömighausen, Willingen (Upland)",
      latlng: LatLng(51.2835588, 8.7585605)),
  Mapping(
      name: "Bömighausen, Willingen", latlng: LatLng(51.2835588, 8.7585605)),
  Mapping(
      name: "Bommersheim, Oberursel (Taunus)",
      latlng: LatLng(50.1977027, 8.5964221)),
  Mapping(
      name: "Bommersheim, Oberursel", latlng: LatLng(50.1977027, 8.5964221)),
  Mapping(
      name: "Bonames, Frankfurt am Main",
      latlng: LatLng(50.1813474, 8.6633305)),
  Mapping(
      name: "Bonbaden, Braunfels",
      latlng: LatLng(50.49944365, 8.431792961626865)),
  Mapping(name: "Bönstadt, Niddatal", latlng: LatLng(50.2868313, 8.8465198)),
  Mapping(name: "Bonsweiher, Mörlenbach", latlng: LatLng(49.615196, 8.715971)),
  Mapping(name: "Borken (Hessen)", latlng: LatLng(51.0494874, 9.281857)),
  Mapping(name: "Borken", latlng: LatLng(51.8443183, 6.8582247)),
  Mapping(name: "Born, Hohenstein", latlng: LatLng(50.1593826, 8.1036463)),
  Mapping(
      name: "Bornheim, Frankfurt am Main",
      latlng: LatLng(50.1297313, 8.7106117)),
  Mapping(name: "Borsdorf, Nidda", latlng: LatLng(50.4322391, 8.974681)),
  Mapping(name: "Bortshausen, Marburg", latlng: LatLng(50.750489, 8.7748048)),
  Mapping(name: "Bösgesäß, Birstein", latlng: LatLng(50.3787815, 9.2721867)),
  Mapping(name: "Böß-Gesäß, Birstein", latlng: LatLng(50.3770036, 9.2661527)),
  Mapping(name: "Bosserode, Wildeck", latlng: LatLng(50.9500342, 9.9920981)),
  Mapping(name: "Bottendorf, Burgwald", latlng: LatLng(51.028821, 8.8145945)),
  Mapping(
      name: "Bottenhorn, Bad Endbach", latlng: LatLng(50.793594, 8.4802707)),
  Mapping(
      name: "Braach, Rotenburg an der Fulda",
      latlng: LatLng(51.0018878, 9.689994)),
  Mapping(name: "Bracht, Rauschenberg", latlng: LatLng(50.9196133, 8.8478237)),
  Mapping(name: "Brachttal", latlng: LatLng(50.3122931, 9.2965788)),
  Mapping(
      name: "Brand, Hilders", latlng: LatLng(50.53015005, 9.953413900983234)),
  Mapping(name: "Brandau, Modautal", latlng: LatLng(49.7354365, 8.7380026)),
  Mapping(name: "Brandlos, Hosenfeld", latlng: LatLng(50.4835507, 9.4815422)),
  Mapping(
      name: "Brandoberndorf, Waldsolms",
      latlng: LatLng(50.425462350000004, 8.511492773042935)),
  Mapping(name: "Brasselsberg, Kassel", latlng: LatLng(51.2918764, 9.4156635)),
  Mapping(
      name: "Brauerschwend, Schwalmtal", latlng: LatLng(50.69738, 9.3253299)),
  Mapping(name: "Braunau, Bad Wildungen", latlng: LatLng(51.0805107, 9.124979)),
  Mapping(name: "Braunfels", latlng: LatLng(50.5152452, 8.390132)),
  Mapping(name: "Braunfels", latlng: LatLng(50.5152452, 8.390132)),
  Mapping(name: "Braunhausen, Bebra", latlng: LatLng(51.003842, 9.832206)),
  Mapping(name: "Braunsen, Bad Arolsen", latlng: LatLng(51.3501456, 9.0385776)),
  Mapping(
      name: "Braunshardt, Weiterstadt", latlng: LatLng(49.9139755, 8.5687566)),
  Mapping(name: "Brechen", latlng: LatLng(50.3598587, 8.1774487)),
  Mapping(
      name: "Breckenheim, Wiesbaden", latlng: LatLng(50.0786726, 8.3713027)),
  Mapping(name: "Breidenbach", latlng: LatLng(50.8869544, 8.4544327)),
  Mapping(name: "Breidenbach", latlng: LatLng(50.8869544, 8.4544327)),
  Mapping(
      name: "Breidenstein, Biedenkopf", latlng: LatLng(50.914033, 8.4689236)),
  Mapping(name: "Breitau, Sontra", latlng: LatLng(51.0680833, 9.9996569)),
  Mapping(
      name: "Breitefeld, Münster (Hessen)",
      latlng: LatLng(49.93047545, 8.829819618154438)),
  Mapping(
      name: "Breitefeld, Münster",
      latlng: LatLng(49.93047545, 8.829819618154438)),
  Mapping(name: "Breitenau, Guxhagen", latlng: LatLng(51.2033911, 9.4763126)),
  Mapping(
      name: "Breitenbach a. Herzberg", latlng: LatLng(50.7823862, 9.4992057)),
  Mapping(
      name: "Breitenbach am Herzberg", latlng: LatLng(50.7823862, 9.4992057)),
  Mapping(name: "Breitenbach, Bebra", latlng: LatLng(50.9562741, 9.7827955)),
  Mapping(
      name: "Breitenbach, Ehringshausen",
      latlng: LatLng(50.630024399999996, 8.41731680647686)),
  Mapping(
      name: "Breitenbach, Schauenburg", latlng: LatLng(51.2836083, 9.3128648)),
  Mapping(
      name: "Breitenbach, Schlüchtern", latlng: LatLng(50.3698099, 9.4854686)),
  Mapping(
      name: "Breitenborn, Biebergemünd", latlng: LatLng(50.1654158, 9.2583311)),
  Mapping(name: "Breitenborn, Gründau", latlng: LatLng(50.2635408, 9.1842009)),
  Mapping(
      name: "Breitenborn, Lützel, Biebergemünd",
      latlng: LatLng(50.15475395, 9.266021420614862)),
  Mapping(
      name: "Breitenbrunn, Lützelbach", latlng: LatLng(49.7665036, 9.0682638)),
  Mapping(name: "Breitenwiesen", latlng: LatLng(48.3648262, 11.4203728)),
  Mapping(
      name: "Breithardt, Hohenstein", latlng: LatLng(50.1954173, 8.0976528)),
  Mapping(name: "Breitscheid", latlng: LatLng(50.0561106, 7.7092259)),
  Mapping(name: "Breitscheid", latlng: LatLng(50.0561106, 7.7092259)),
  Mapping(
      name: "Breitzbach, Herleshausen", latlng: LatLng(51.0222537, 10.0961786)),
  Mapping(name: "Bremhof, Michelstadt", latlng: LatLng(49.7327147, 9.1104394)),
  Mapping(name: "Bremthal, Eppstein", latlng: LatLng(50.1402161, 8.3587681)),
  Mapping(name: "Brensbach", latlng: LatLng(49.7744431, 8.8806968)),
  Mapping(name: "Brensbach", latlng: LatLng(49.7744431, 8.8806968)),
  Mapping(name: "Breuberg", latlng: LatLng(49.8237774, 9.0297787)),
  Mapping(name: "Breuna", latlng: LatLng(51.4437219, 9.1966537)),
  Mapping(name: "Breuna", latlng: LatLng(51.4437219, 9.1966537)),
  Mapping(
      name: "Breungeshain, Schotten", latlng: LatLng(50.5076569, 9.2062582)),
  Mapping(name: "Breunings, Sinntal", latlng: LatLng(50.2918349, 9.6016962)),
  Mapping(name: "Bringhausen, Edertal", latlng: LatLng(51.173169, 8.9933302)),
  Mapping(name: "Brombach, Fürth", latlng: LatLng(49.6670279, 8.8104809)),
  Mapping(
      name: "Brombach, Schmitten im Taunus",
      latlng: LatLng(50.2892497, 8.461883378875998)),
  Mapping(name: "Brombachtal", latlng: LatLng(49.7325, 8.96222)),
  Mapping(
      name: "Bromskirchen, Allendorf (Eder)",
      latlng: LatLng(51.0946316, 8.625767)),
  Mapping(
      name: "Bromskirchen, Allendorf", latlng: LatLng(51.0946316, 8.625767)),
  Mapping(
      name: "Bronnzell, Fulda", latlng: LatLng(50.5106672, 9.681675683287622)),
  Mapping(
      name: "Bruchenbrücken, Friedberg", latlng: LatLng(50.3013587, 8.7930354)),
  Mapping(name: "Bruchköbel", latlng: LatLng(50.1845, 8.9369)),
  Mapping(name: "Bruchköbel", latlng: LatLng(50.1845, 8.9369)),
  Mapping(name: "Brünchenhain, Jesberg", latlng: LatLng(51.0060457, 9.1148013)),
  Mapping(name: "Bründersen, Wolfhagen", latlng: LatLng(51.2946459, 9.1879454)),
  Mapping(
      name: "Brungershausen, Lahntal", latlng: LatLng(50.8663348, 8.6353298)),
  Mapping(
      name: "Brunnthal, Michelstadt", latlng: LatLng(49.7463108, 9.1352525)),
  Mapping(
      name: "Büblingshausen, Wetzlar", latlng: LatLng(50.5455058, 8.5365205)),
  Mapping(
      name: "Büchelbach, Biebergemünd", latlng: LatLng(50.1670118, 9.3367507)),
  Mapping(name: "Buchenau, Dautphetal", latlng: LatLng(50.8736222, 8.5982284)),
  Mapping(
      name: "Buchenau, Eiterfeld",
      latlng: LatLng(50.78471385, 9.755081699211983)),
  Mapping(
      name: "Büchenberg, Eichenzell", latlng: LatLng(50.4361416, 9.7119198)),
  Mapping(name: "Buchenberg, Vöhl", latlng: LatLng(51.1581442, 8.8710678)),
  Mapping(
      name: "Buchenrod, Flieden",
      latlng: LatLng(50.44841795, 9.502894706371368)),
  Mapping(name: "Büchenwerra, Guxhagen", latlng: LatLng(51.1795093, 9.4805713)),
  Mapping(name: "Büches, Büdingen", latlng: LatLng(50.2967294, 9.071207)),
  Mapping(name: "Buchklingen, Birkenau", latlng: LatLng(49.5453918, 8.7319458)),
  Mapping(name: "Buchschlag, Dreieich", latlng: LatLng(50.0218342, 8.6683279)),
  Mapping(name: "Büdesheim, Schöneck", latlng: LatLng(50.2170536, 8.8352569)),
  Mapping(name: "Büdingen", latlng: LatLng(49.334193, 6.3227721)),
  Mapping(name: "Büdingen", latlng: LatLng(49.334193, 6.3227721)),
  Mapping(name: "Bühle, Bad Arolsen", latlng: LatLng(51.3190253, 9.1092943)),
  Mapping(name: "Buhlen, Edertal", latlng: LatLng(51.1877432, 9.0834863)),
  Mapping(name: "Bulau, Rödermark", latlng: LatLng(49.9792842, 8.7788187)),
  Mapping(name: "Bullau, Erbach", latlng: LatLng(49.6111362, 9.0497087)),
  Mapping(
      name: "Bullauer Eutergrund, Erbach",
      latlng: LatLng(49.6189026, 9.0625029)),
  Mapping(
      name: "Burg-Gemünden, Gemünden (Felda)",
      latlng: LatLng(50.6812238, 9.036866)),
  Mapping(name: "Burg-Gemünden", latlng: LatLng(50.6812238, 9.036866)),
  Mapping(
      name: "Burg-Gräfenrode, Karben", latlng: LatLng(50.2582725, 8.7970503)),
  Mapping(
      name: "Burg-Hohenstein, Hohenstein",
      latlng: LatLng(49.586672500000006, 11.422401810022649)),
  Mapping(name: "Burg, Herborn", latlng: LatLng(50.7013252, 8.301434555897623)),
  Mapping(name: "Burgbracht, Kefenrod", latlng: LatLng(50.366656, 9.258265)),
  Mapping(
      name: "Bürgel, Offenbach am Main", latlng: LatLng(50.1177024, 8.7840035)),
  Mapping(name: "Bürgeln, Cölbe", latlng: LatLng(50.8540398, 8.8235448)),
  Mapping(
      name: "Burghasungen, Zierenberg", latlng: LatLng(51.3245762, 9.2777409)),
  Mapping(name: "Burghaun", latlng: LatLng(50.7068434, 9.7027201)),
  Mapping(name: "Burghaun", latlng: LatLng(50.7068434, 9.7027201)),
  Mapping(name: "Burghofen, Waldkappel", latlng: LatLng(51.1197389, 9.8335282)),
  Mapping(name: "Burgholz, Kirchhain", latlng: LatLng(50.8730857, 8.9505108)),
  Mapping(
      name: "Burgholzhausen vor der Höhe, Friedrichsdorf",
      latlng: LatLng(50.2533636, 8.6772309)),
  Mapping(name: "Burgjoß, Jossgrund", latlng: LatLng(50.2038011, 9.4804892)),
  Mapping(
      name: "Burgsolms, Solms", latlng: LatLng(50.53727325, 8.408233517058258)),
  Mapping(
      name: "Burguffeln, Grebenstein", latlng: LatLng(51.4257543, 9.4318723)),
  Mapping(name: "Burgwald", latlng: LatLng(51.0137126, 8.7918543)),
  Mapping(name: "Burgwald", latlng: LatLng(51.0137126, 8.7918543)),
  Mapping(name: "Burkhards, Schotten", latlng: LatLng(50.4620903, 9.2023911)),
  Mapping(
      name: "Burkhardsfelden, Reiskirchen",
      latlng: LatLng(50.570324400000004, 8.821724911896101)),
  Mapping(name: "Bürstadt", latlng: LatLng(49.6416146, 8.4549068)),
  Mapping(name: "Bürstadt", latlng: LatLng(49.6416146, 8.4549068)),
  Mapping(name: "Buseck", latlng: LatLng(50.6178665, 8.7759513)),
  Mapping(name: "Busenborn, Schotten", latlng: LatLng(50.5007901, 9.1838)),
  Mapping(name: "Büßfeld, Homberg (Ohm)", latlng: LatLng(50.694747, 8.9991475)),
  Mapping(name: "Büßfeld, Homberg", latlng: LatLng(50.694747, 8.9991475)),
  Mapping(name: "Büttelborn", latlng: LatLng(49.9031693, 8.5143517)),
  Mapping(name: "Büttelborn", latlng: LatLng(49.9031693, 8.5143517)),
  Mapping(
      name: "Butterstadt, Bruchköbel", latlng: LatLng(50.2112343, 8.9366499)),
  Mapping(name: "Butzbach", latlng: LatLng(50.4340422, 8.6711184)),
  Mapping(name: "Butzbach", latlng: LatLng(50.4340422, 8.6711184)),
  Mapping(name: "Calbach, Büdingen", latlng: LatLng(50.2748849, 9.0516215)),
  Mapping(name: "Calden", latlng: LatLng(51.3965572, 9.3642196)),
  Mapping(name: "Calden", latlng: LatLng(51.3965572, 9.3642196)),
  Mapping(name: "Caldern, Lahntal", latlng: LatLng(50.8448685, 8.6636491)),
  Mapping(name: "Cappel, Fritzlar", latlng: LatLng(51.1281727, 9.3398074)),
  Mapping(name: "Cappel, Marburg", latlng: LatLng(50.7785895, 8.7669521)),
  Mapping(name: "Carlsdorf, Hofgeismar", latlng: LatLng(51.4885068, 9.4294234)),
  Mapping(name: "Carlshütte, Dautphetal", latlng: LatLng(50.8625456, 8.584782)),
  Mapping(
      name: "Caßdorf, Homberg (Efze)", latlng: LatLng(51.0220035, 9.366184)),
  Mapping(name: "Caßdorf, Homberg", latlng: LatLng(51.0220035, 9.366184)),
  Mapping(
      name: "Christerode, Neukirchen", latlng: LatLng(50.876404, 9.3943868)),
  Mapping(name: "Cleeberg, Langgöns", latlng: LatLng(50.4473175, 8.5609029)),
  Mapping(
      name: "Climbach, Allendorf (Lumda)",
      latlng: LatLng(50.666165500000005, 8.824162663520408)),
  Mapping(
      name: "Climbach, Allendorf",
      latlng: LatLng(50.6557324, 8.81535733256958)),
  Mapping(name: "Cölbe", latlng: LatLng(50.8498838, 8.7864025)),
  Mapping(name: "Cölbe", latlng: LatLng(50.8498838, 8.7864025)),
  Mapping(name: "Cornberg", latlng: LatLng(51.0514432, 9.8315589)),
  Mapping(name: "Cornberg", latlng: LatLng(51.0514432, 9.8315589)),
  Mapping(name: "Crainfeld, Grebenhain", latlng: LatLng(50.485173, 9.3499327)),
  Mapping(
      name: "Cratzenbach, Weilrod",
      latlng: LatLng(50.32115925, 8.379942727318296)),
  Mapping(name: "Crumbach, Lohfelden", latlng: LatLng(51.2714962, 9.539055)),
  Mapping(name: "Crumstadt, Riedstadt", latlng: LatLng(49.8111363, 8.5114143)),
  Mapping(name: "Cyriaxweimar, Marburg", latlng: LatLng(50.7842657, 8.7158828)),
  Mapping(
      name: "Dachsloch, Allendorf (Eder)",
      latlng: LatLng(51.0789694, 8.5383354)),
  Mapping(name: "Dachsloch, Allendorf", latlng: LatLng(51.0789694, 8.5383354)),
  Mapping(
      name: "Dagobertshausen, Malsfeld", latlng: LatLng(51.0807763, 9.5082348)),
  Mapping(
      name: "Dagobertshausen, Marburg", latlng: LatLng(50.8221304, 8.7024071)),
  Mapping(name: "Dainrode, Frankenau", latlng: LatLng(51.0679682, 8.909312)),
  Mapping(name: "Daisbach, Aarbergen", latlng: LatLng(50.2491298, 8.1073219)),
  Mapping(name: "Dalheim, Wetzlar", latlng: LatLng(50.5649582, 8.473816)),
  Mapping(
      name: "Dalherda, Gersfeld (Rhön)", latlng: LatLng(50.4183132, 9.8278151)),
  Mapping(name: "Dalherda, Gersfeld", latlng: LatLng(50.4183132, 9.8278151)),
  Mapping(
      name: "Dalwigksthal, Lichtenfels (Hessen)",
      latlng: LatLng(51.1507955, 8.7911287)),
  Mapping(
      name: "Dalwigksthal, Lichtenfels", latlng: LatLng(51.1507955, 8.7911287)),
  Mapping(name: "Damm, Lohra", latlng: LatLng(50.7265399, 8.6462574)),
  Mapping(
      name: "Dammersbach, Hünfeld",
      latlng: LatLng(50.6174697, 9.775268231481716)),
  Mapping(name: "Damshausen, Dautphetal", latlng: LatLng(50.83109, 8.6115671)),
  Mapping(
      name: "Dankerode, Rotenburg an der Fulda",
      latlng: LatLng(51.0679475, 9.7777084)),
  Mapping(
      name: "Dannenrod, Homberg (Ohm)",
      latlng: LatLng(50.7468578, 9.019702256658992)),
  Mapping(name: "Dannenrod, Homberg", latlng: LatLng(50.7601183, 9.025613)),
  Mapping(
      name: "Danzwiesen, Hofbieber",
      latlng: LatLng(50.542774249999994, 9.902017523345894)),
  Mapping(
      name: "Darmstadt-Mitte, Darmstadt",
      latlng: LatLng(49.8727478, 8.6511983)),
  Mapping(
      name: "Darmstadt-Nord, Darmstadt", latlng: LatLng(49.883176, 8.6507225)),
  Mapping(
      name: "Darmstadt-Ost, Darmstadt", latlng: LatLng(49.8735755, 8.672461)),
  Mapping(
      name: "Darmstadt-West, Darmstadt", latlng: LatLng(49.8590836, 8.6371938)),
  Mapping(
      name: "Darsberg, Neckarsteinach",
      latlng: LatLng(49.419972349999995, 8.854365243078608)),
  Mapping(
      name: "Dasbach, Idstein", latlng: LatLng(50.20198295, 8.297205086642608)),
  Mapping(
      name: "Dassen, Künzell", latlng: LatLng(50.50976615, 9.772736978162998)),
  Mapping(name: "Datterode, Ringgau", latlng: LatLng(51.1198816, 10.0250195)),
  Mapping(
      name: "Daubhausen, Ehringshausen",
      latlng: LatLng(50.60187555, 8.342281565082441)),
  Mapping(name: "Dauborn, Hünfelden", latlng: LatLng(50.3293649, 8.1791646)),
  Mapping(
      name: "Daubringen, Staufenberg", latlng: LatLng(50.6616049, 8.7299749)),
  Mapping(name: "Dauernheim, Ranstadt", latlng: LatLng(50.3626158, 8.9549245)),
  Mapping(name: "Dautphe, Dautphetal", latlng: LatLng(50.8578399, 8.5418911)),
  Mapping(
      name: "Deckenbach, Homberg (Ohm)", latlng: LatLng(50.7158011, 8.9496348)),
  Mapping(name: "Deckenbach, Homberg", latlng: LatLng(50.7158011, 8.9496348)),
  Mapping(name: "Dehausen, Diemelstadt", latlng: LatLng(51.4564792, 9.0437593)),
  Mapping(
      name: "Dehringhausen, Waldeck", latlng: LatLng(51.2971503, 9.0329979)),
  Mapping(name: "Dehrn, Runkel", latlng: LatLng(50.4189901, 8.0978802)),
  Mapping(name: "Deisel, Trendelburg", latlng: LatLng(51.5932317, 9.408747)),
  Mapping(name: "Deisfeld, Diemelsee", latlng: LatLng(51.3147902, 8.7308067)),
  Mapping(name: "Delkenheim, Wiesbaden", latlng: LatLng(50.0475038, 8.3616375)),
  Mapping(
      name: "Dennhausen, Fuldabrück", latlng: LatLng(51.2507118, 9.4904175)),
  Mapping(name: "Dens, Nentershausen", latlng: LatLng(51.0225285, 9.905076)),
  Mapping(name: "Densberg, Jesberg", latlng: LatLng(50.9930671, 9.0938407)),
  Mapping(name: "Dernbach, Bad Endbach", latlng: LatLng(50.781538, 8.5053587)),
  Mapping(name: "Deute, Gudensberg", latlng: LatLng(51.1780884, 9.4119413)),
  Mapping(
      name: "Deutsche Bank Park",
      latlng: LatLng(50.06859935, 8.645462952099116)),
  Mapping(name: "Dexbach, Biedenkopf", latlng: LatLng(50.9373115, 8.5882367)),
  Mapping(
      name: "Dickershausen, Homberg (Efze)",
      latlng: LatLng(51.0566375, 9.4663242)),
  Mapping(
      name: "Dickershausen, Homberg", latlng: LatLng(51.0566375, 9.4663242)),
  Mapping(name: "Dickschied, Heidenrod", latlng: LatLng(50.1251467, 7.9473077)),
  Mapping(
      name: "Diebach am Haag, Büdingen", latlng: LatLng(50.256056, 9.0738343)),
  Mapping(name: "Dieburg, Dieburg", latlng: LatLng(49.8949312, 8.8368946)),
  Mapping(name: "Dieburg", latlng: LatLng(49.8949312, 8.8368946)),
  Mapping(
      name: "Diedenbergen, Hofheim am Taunus",
      latlng: LatLng(50.0615267, 8.4189822)),
  Mapping(
      name: "Diedenshausen, Gladenbach", latlng: LatLng(50.8187234, 8.6115925)),
  Mapping(name: "Diemelsee", latlng: LatLng(51.3439822, 8.7829507)),
  Mapping(name: "Diemelstadt", latlng: LatLng(51.4813132, 8.992125)),
  Mapping(name: "Diemerode, Sontra", latlng: LatLng(51.0792337, 9.8528166)),
  Mapping(
      name: "Dietenhausen, Weilmünster", latlng: LatLng(50.4233715, 8.4288828)),
  Mapping(
      name: "Dietershan, Fulda",
      latlng: LatLng(50.60482495, 9.695377554371852)),
  Mapping(
      name: "Dietershausen, Künzell",
      latlng: LatLng(50.50720925, 9.804613401308417)),
  Mapping(
      name: "Dietesheim, Mühlheim am Main",
      latlng: LatLng(50.1227008, 8.8576984)),
  Mapping(
      name: "Dietges, Hilders", latlng: LatLng(50.52885715, 9.928397629533501)),
  Mapping(
      name: "Dietgeshof",
      latlng: LatLng(50.650590199999996, 10.036990051535994)),
  Mapping(
      name: "Dietkirchen, Limburg an der Lahn",
      latlng: LatLng(50.4032435, 8.0914189)),
  Mapping(
      name: "Dietzenbach, Dietzenbach", latlng: LatLng(50.0171926, 8.784277)),
  Mapping(name: "Dietzenbach", latlng: LatLng(50.0171926, 8.784277)),
  Mapping(name: "Dietzhölztal", latlng: LatLng(50.8459867, 8.3029731)),
  Mapping(
      name: "Dillbrecht, Haiger",
      latlng: LatLng(50.817521299999996, 8.19224657330434)),
  Mapping(name: "Dillenburg", latlng: LatLng(50.7404535, 8.2874957)),
  Mapping(name: "Dillenburg", latlng: LatLng(50.7404535, 8.2874957)),
  Mapping(name: "Dillfeld, Wetzlar", latlng: LatLng(50.5688995, 8.4843233)),
  Mapping(
      name: "Dillhausen, Mengerskirchen",
      latlng: LatLng(50.5487141, 8.216751969227012)),
  Mapping(
      name: "Dillheim, Ehringshausen",
      latlng: LatLng(50.60591325, 8.370233157200499)),
  Mapping(
      name: "Dillich, Borken (Hessen)", latlng: LatLng(50.998424, 9.2861641)),
  Mapping(name: "Dillich, Borken", latlng: LatLng(50.998424, 9.2861641)),
  Mapping(
      name: "Dillingen, Friedrichsdorf", latlng: LatLng(50.2522774, 8.6444244)),
  Mapping(name: "Dilschhausen, Marburg", latlng: LatLng(50.8171949, 8.6573989)),
  Mapping(
      name: "Dinkelrode, Schenklengsfeld",
      latlng: LatLng(50.8427111, 9.8075513)),
  Mapping(name: "Dipperz", latlng: LatLng(50.5316185, 9.8175609)),
  Mapping(name: "Dipperz", latlng: LatLng(50.5316185, 9.8175609)),
  Mapping(
      name: "Dirlammen, Lautertal (Vogelsberg)",
      latlng: LatLng(50.6059775, 9.3031882)),
  Mapping(name: "Dirlammen, Lautertal", latlng: LatLng(50.6059775, 9.3031882)),
  Mapping(
      name: "Dirlos, Künzell", latlng: LatLng(50.521566, 9.755696185970162)),
  Mapping(name: "Dissen, Gudensberg", latlng: LatLng(51.1948886, 9.4061266)),
  Mapping(
      name: "Dittershausen, Fuldabrück", latlng: LatLng(51.2520316, 9.4746176)),
  Mapping(
      name: "Dittershausen, Schwalmstadt",
      latlng: LatLng(50.9348059, 9.1933325)),
  Mapping(
      name: "Dittlofrod, Eiterfeld",
      latlng: LatLng(50.7543218, 9.74146365375153)),
  Mapping(
      name: "Dodenau, Battenberg (Eder)",
      latlng: LatLng(51.0249342, 8.5976145)),
  Mapping(name: "Dodenau, Battenberg", latlng: LatLng(51.0249342, 8.5976145)),
  Mapping(
      name: "Dodenhausen, Haina (Kloster)", latlng: LatLng(51.01123, 9.051375)),
  Mapping(name: "Dodenhausen, Haina", latlng: LatLng(51.01123, 9.051375)),
  Mapping(
      name: "Dohrenbach, Witzenhausen", latlng: LatLng(51.3104695, 9.8352822)),
  Mapping(name: "Döllbach, Eichenzell", latlng: LatLng(50.439118, 9.7333118)),
  Mapping(name: "Dombach, Bad Camberg", latlng: LatLng(50.3058684, 8.3223313)),
  Mapping(name: "Döngesmühle, Flieden", latlng: LatLng(50.4302493, 9.5467443)),
  Mapping(
      name: "Donsbach, Dillenburg",
      latlng: LatLng(50.7206896, 8.236756305558309)),
  Mapping(name: "Dorchheim, Elbtal", latlng: LatLng(50.5049471, 8.0650733)),
  Mapping(name: "Dorf-Erbach", latlng: LatLng(49.6609334, 9.0089071)),
  Mapping(
      name: "Dorf-Güll, Pohlheim",
      latlng: LatLng(50.5042541, 8.75662478905768)),
  Mapping(name: "Dorfborn, Neuhof", latlng: LatLng(50.4660576, 9.6297794)),
  Mapping(name: "Dorfitter, Vöhl", latlng: LatLng(51.2373888, 8.8925503)),
  Mapping(
      name: "Dorfweil, Schmitten im Taunus",
      latlng: LatLng(50.278205, 8.453107910534786)),
  Mapping(name: "Dorheim, Friedberg", latlng: LatLng(50.3501432, 8.7891472)),
  Mapping(name: "Dorheim, Neuental", latlng: LatLng(50.9778159, 9.2308995)),
  Mapping(name: "Dorla, Gudensberg", latlng: LatLng(51.1697953, 9.3188297)),
  Mapping(name: "Dorlar, Lahnau", latlng: LatLng(50.5768506, 8.5633477)),
  Mapping(
      name: "Dörmbach, Dipperz", latlng: LatLng(50.5132083, 9.83287236385754)),
  Mapping(
      name: "Dörmbach, Hilders", latlng: LatLng(50.5705016, 9.927785066578764)),
  Mapping(
      name: "Dorn-Assenheim, Reichelsheim (Wetterau)",
      latlng: LatLng(50.3400889, 8.8416197)),
  Mapping(
      name: "Dorn-Assenheim, Reichelsheim",
      latlng: LatLng(50.3378334, 8.842161)),
  Mapping(name: "Dornberg, Groß-Gerau", latlng: LatLng(49.9081276, 8.487083)),
  Mapping(
      name: "Dörnberg, Habichtswald", latlng: LatLng(51.3426724, 9.3432901)),
  Mapping(name: "Dornburg", latlng: LatLng(50.508773, 8.0156671)),
  Mapping(
      name: "Dornbusch, Frankfurt am Main",
      latlng: LatLng(50.1390457, 8.6752715)),
  Mapping(
      name: "Dorndiel, Groß-Umstadt", latlng: LatLng(49.8658848, 9.0155642)),
  Mapping(name: "Dorndorf, Dornburg", latlng: LatLng(50.5051015, 8.002439)),
  Mapping(name: "Dörnhagen, Fuldabrück", latlng: LatLng(51.2271926, 9.4966964)),
  Mapping(name: "Dornheim, Groß-Gerau", latlng: LatLng(49.8778896, 8.4825134)),
  Mapping(
      name: "Dornholzhausen, Bad Homburg vor der Höhe",
      latlng: LatLng(50.2414037, 8.5844175)),
  Mapping(
      name: "Dörnholzhausen, Frankenberg (Eder)",
      latlng: LatLng(51.0571266, 8.8741289)),
  Mapping(
      name: "Dörnholzhausen, Frankenberg",
      latlng: LatLng(51.0571266, 8.8741289)),
  Mapping(
      name: "Dornholzhausen, Langgöns",
      latlng: LatLng(50.48848235, 8.578305866920335)),
  Mapping(name: "Dörnigheim, Maintal", latlng: LatLng(50.1334166, 8.8393158)),
  Mapping(
      name: "Dortelweil, Bad Vilbel", latlng: LatLng(50.2083609, 8.7472201)),
  Mapping(name: "Dotzheim, Wiesbaden", latlng: LatLng(50.0712374, 8.1956722)),
  Mapping(
      name: "Drasenberg, Schlüchtern", latlng: LatLng(50.3759334, 9.5389294)),
  Mapping(name: "Dreieich", latlng: LatLng(50.011974, 8.7123912)),
  Mapping(
      name: "Dreieichenhain, Dreieich", latlng: LatLng(50.0030445, 8.7101086)),
  Mapping(
      name: "Dreihausen, Ebsdorfergrund",
      latlng: LatLng(50.7287581, 8.8581817)),
  Mapping(
      name: "Dreisbach, Ehringshausen",
      latlng: LatLng(50.6543143, 8.388160265506716)),
  Mapping(name: "Driedorf", latlng: LatLng(50.6332005, 8.183302)),
  Mapping(name: "Driedorf", latlng: LatLng(50.6332005, 8.183302)),
  Mapping(
      name: "Drommershausen, Weilburg",
      latlng: LatLng(50.5010367, 8.305714925646015)),
  Mapping(name: "Düdelsheim, Büdingen", latlng: LatLng(50.2910422, 9.031049)),
  Mapping(name: "Dudenhofen, Rodgau", latlng: LatLng(50.0093228, 8.8888013)),
  Mapping(name: "Dudenrod, Büdingen", latlng: LatLng(50.3221938, 9.1106458)),
  Mapping(
      name: "Dudenrode, Bad Sooden-Allendorf",
      latlng: LatLng(51.2544398, 9.8693131)),
  Mapping(
      name: "Dusenbach, Höchst i. Odw.", latlng: LatLng(49.8053197, 9.0097907)),
  Mapping(
      name: "Dutenhofen, Wetzlar",
      latlng: LatLng(50.5618935, 8.593327578921565)),
  Mapping(
      name: "Eberbach, Reichelsheim (Odenwald)",
      latlng: LatLng(49.7243415, 8.8291582)),
  Mapping(
      name: "Eberbach, Reichelsheim", latlng: LatLng(49.7243415, 8.8291582)),
  Mapping(
      name: "Ebersberg, Ebersburg",
      latlng: LatLng(50.4754479, 9.825325575719681)),
  Mapping(name: "Ebersberg[7], Erbach", latlng: LatLng(49.6137911, 8.9950975)),
  Mapping(name: "Ebersburg", latlng: LatLng(50.4627165, 9.7920865)),
  Mapping(
      name: "Eberschütz, Trendelburg", latlng: LatLng(51.5399798, 9.3627254)),
  Mapping(name: "Ebersgöns, Butzbach", latlng: LatLng(50.4534729, 8.6107109)),
  Mapping(name: "Eberstadt, Darmstadt", latlng: LatLng(49.8167904, 8.6436991)),
  Mapping(
      name: "Eberstadt, Lich", latlng: LatLng(50.4797322, 8.760000100061273)),
  Mapping(
      name: "Ebsdorf, Ebsdorfergrund", latlng: LatLng(50.7336409, 8.8119908)),
  Mapping(name: "Ebsdorfergrund", latlng: LatLng(50.7340548, 8.8336271)),
  Mapping(name: "Echzell", latlng: LatLng(50.3813094, 8.8825014)),
  Mapping(name: "Echzell", latlng: LatLng(50.3813094, 8.8825014)),
  Mapping(
      name: "Eckardroth, Bad Soden-Salmünster",
      latlng: LatLng(50.3213416, 9.3717036)),
  Mapping(
      name: "Eckartsborn, Ortenberg", latlng: LatLng(50.3691313, 9.0633776)),
  Mapping(
      name: "Eckartshausen, Büdingen", latlng: LatLng(50.2540708, 9.0261965)),
  Mapping(
      name: "Eckelshausen, Biedenkopf", latlng: LatLng(50.8842461, 8.543468)),
  Mapping(
      name: "Eckenheim, Frankfurt am Main",
      latlng: LatLng(50.1517101, 8.6797459)),
  Mapping(name: "Eckweisbach, Hilders", latlng: LatLng(50.5724361, 9.9571752)),
  Mapping(
      name: "Eddersheim, Hattersheim am Main",
      latlng: LatLng(50.036632850000004, 8.46253167770509)),
  Mapping(name: "Edelsberg, Weinbach", latlng: LatLng(50.4610673, 8.3158875)),
  Mapping(
      name: "Edelzell, Fulda", latlng: LatLng(50.52386465, 9.705144357410951)),
  Mapping(name: "Ederbringhausen, Vöhl", latlng: LatLng(51.1293679, 8.8681002)),
  Mapping(name: "Edermünde", latlng: LatLng(51.2143386, 9.4033047)),
  Mapping(name: "Edertal", latlng: LatLng(51.1629857, 9.0887282)),
  Mapping(
      name: "Edingen, Sinn", latlng: LatLng(50.63160175, 8.314759185447114)),
  Mapping(
      name: "Effolderbach, Ortenberg", latlng: LatLng(50.341353, 9.0090776)),
  Mapping(
      name: "Egelsbach, Egelsbach",
      latlng: LatLng(49.669459450000005, 10.682245818839124)),
  Mapping(name: "Egelsbach", latlng: LatLng(49.9668352, 8.6659289)),
  Mapping(name: "Egenroth, Heidenrod", latlng: LatLng(50.1886612, 7.9509141)),
  Mapping(name: "Ehlen, Habichtswald", latlng: LatLng(51.3233249, 9.3103277)),
  Mapping(name: "Ehlhalten, Eppstein", latlng: LatLng(50.1749871, 8.3683465)),
  Mapping(
      name: "Ehrenbach, Idstein", latlng: LatLng(50.2049669, 8.21893829092496)),
  Mapping(name: "Ehrenberg (Rhön)", latlng: LatLng(50.5065364, 10.0045593)),
  Mapping(name: "Ehrenberg", latlng: LatLng(50.5065364, 10.0045593)),
  Mapping(name: "Ehringen, Volkmarsen", latlng: LatLng(51.3812982, 9.1491494)),
  Mapping(
      name: "Ehringshausen, Gemünden (Felda)",
      latlng: LatLng(50.7058111, 9.1160395)),
  Mapping(
      name: "Ehringshausen, Gemünden", latlng: LatLng(50.7058111, 9.1160395)),
  Mapping(name: "Ehringshausen", latlng: LatLng(50.6008477, 8.3825518)),
  Mapping(name: "Ehringshausen", latlng: LatLng(50.6008477, 8.3825518)),
  Mapping(name: "Ehrsten, Calden", latlng: LatLng(51.394019, 9.3480684)),
  Mapping(
      name: "Eibach, Dillenburg",
      latlng: LatLng(50.749096249999994, 8.339112539348879)),
  Mapping(
      name: "Eibelshausen, Eschenburg",
      latlng: LatLng(50.8154124, 8.335677720624194)),
  Mapping(
      name: "Eibingen, Rüdesheim am Rhein",
      latlng: LatLng(50.020566349999996, 7.915493602656994)),
  Mapping(name: "Eich, Pfungstadt", latlng: LatLng(49.8036079, 8.5611889)),
  Mapping(
      name: "Eichelhain, Lautertal (Vogelsberg)",
      latlng: LatLng(50.5693008, 9.2784833)),
  Mapping(name: "Eichelhain, Lautertal", latlng: LatLng(50.5693008, 9.2784833)),
  Mapping(
      name: "Eichelsachsen, Schotten", latlng: LatLng(50.4581219, 9.1244878)),
  Mapping(name: "Eichelsdorf, Nidda", latlng: LatLng(50.4532602, 9.0486235)),
  Mapping(name: "Eichen, Nidderau", latlng: LatLng(50.258257, 8.9070731)),
  Mapping(name: "Eichenau, Großenlüder", latlng: LatLng(50.6112238, 9.5213185)),
  Mapping(
      name: "Eichenberg, Neu-Eichenberg",
      latlng: LatLng(51.3738369, 9.9125914)),
  Mapping(
      name: "Eichenried, Kalbach",
      latlng: LatLng(50.3928637, 9.650806420952714)),
  Mapping(
      name: "Eichenrod, Lautertal (Vogelsberg)",
      latlng: LatLng(50.5785085, 9.2993043)),
  Mapping(name: "Eichenrod, Lautertal", latlng: LatLng(50.5785085, 9.2993043)),
  Mapping(name: "Eichenzell", latlng: LatLng(50.4847226, 9.7050101)),
  Mapping(name: "Eichenzell", latlng: LatLng(50.4847226, 9.7050101)),
  Mapping(name: "Eichhof, Bad Hersfeld", latlng: LatLng(50.8648897, 9.7027917)),
  Mapping(
      name: "Eidengesäß, Linsengericht", latlng: LatLng(50.1803838, 9.2323318)),
  Mapping(
      name: "Eiershausen, Eschenburg",
      latlng: LatLng(50.79633235, 8.357643263605233)),
  Mapping(name: "Eifa, Alsfeld", latlng: LatLng(50.7502033, 9.3448093)),
  Mapping(
      name: "Eifa, Hatzfeld (Eder)",
      latlng: LatLng(50.96703355, 8.578026296489252)),
  Mapping(
      name: "Eifa, Hatzfeld", latlng: LatLng(50.96703355, 8.578026296489252)),
  Mapping(
      name: "Eimelrod, Willingen (Upland)",
      latlng: LatLng(51.3005957, 8.7007917)),
  Mapping(name: "Eimelrod, Willingen", latlng: LatLng(51.3005957, 8.7007917)),
  Mapping(
      name: "Einartshausen, Schotten", latlng: LatLng(50.5027074, 9.0712689)),
  Mapping(name: "Einhausen", latlng: LatLng(50.5301473, 10.4633497)),
  Mapping(
      name: "Eisemroth, Siegbach",
      latlng: LatLng(50.7333699, 8.406920296903401)),
  Mapping(
      name: "Eisenbach, Selters (Taunus)",
      latlng: LatLng(50.3396947, 8.2558267)),
  Mapping(name: "Eisenbach, Selters", latlng: LatLng(50.3396947, 8.2558267)),
  Mapping(name: "Eiterfeld", latlng: LatLng(50.7703444, 9.8385732)),
  Mapping(name: "Eiterfeld", latlng: LatLng(50.7703444, 9.8385732)),
  Mapping(name: "Eiterhagen, Söhrewald", latlng: LatLng(51.1901904, 9.590206)),
  Mapping(name: "Eitra, Hauneck", latlng: LatLng(50.8126732, 9.7396907)),
  Mapping(name: "Elbenberg, Naumburg", latlng: LatLng(51.2314319, 9.2055524)),
  Mapping(name: "Elbenrod, Alsfeld", latlng: LatLng(50.7801663, 9.3329873)),
  Mapping(
      name: "Elbersdorf, Spangenberg",
      latlng: LatLng(51.12911205, 9.650524245437172)),
  Mapping(name: "Elbgrund, Elbtal", latlng: LatLng(50.5119916, 8.0630664)),
  Mapping(name: "Elbtal", latlng: LatLng(50.505896, 8.0595923)),
  Mapping(name: "Elfershausen, Malsfeld", latlng: LatLng(51.095837, 9.5031339)),
  Mapping(
      name: "Elgershausen, Schauenburg", latlng: LatLng(51.2752467, 9.3758012)),
  Mapping(name: "Elkerhausen, Weinbach", latlng: LatLng(50.4169772, 8.2827438)),
  Mapping(name: "Ellar, Waldbrunn", latlng: LatLng(50.5068855, 8.0919954)),
  Mapping(
      name: "Ellenbach, Fürth (Odenwald)",
      latlng: LatLng(49.6678717, 8.7664998)),
  Mapping(name: "Ellenbach, Fürth", latlng: LatLng(49.6660641, 8.7676945)),
  Mapping(name: "Ellenberg, Guxhagen", latlng: LatLng(51.1853777, 9.4670983)),
  Mapping(
      name: "Elleringhausen, Twistetal",
      latlng: LatLng(51.3285063, 9.01522956854465)),
  Mapping(name: "Ellers, Neuhof", latlng: LatLng(50.4590439, 9.6099487)),
  Mapping(
      name: "Ellershausen, Bad Sooden-Allendorf",
      latlng: LatLng(51.3007353, 9.9626834)),
  Mapping(
      name: "Ellershausen, Frankenau", latlng: LatLng(51.0809539, 8.8913173)),
  Mapping(
      name: "Ellingerode, Witzenhausen", latlng: LatLng(51.3298664, 9.8199481)),
  Mapping(
      name: "Ellingshausen, Knüllwald", latlng: LatLng(50.9563744, 9.5220323)),
  Mapping(
      name: "Ellnrode, Gemünden (Wohra)",
      latlng: LatLng(50.9920744, 8.9763233)),
  Mapping(name: "Ellnrode, Gemünden", latlng: LatLng(50.9920744, 8.9763233)),
  Mapping(name: "Elm, Schlüchtern", latlng: LatLng(50.3611612, 9.5582959)),
  Mapping(name: "Elmarshausen, Wolfhagen", latlng: LatLng(51.3443211, 9.18164)),
  Mapping(
      name: "Elmshagen, Schauenburg", latlng: LatLng(51.2609984, 9.3177898)),
  Mapping(
      name: "Elmshausen, Dautphetal", latlng: LatLng(50.8590398, 8.6142577)),
  Mapping(
      name: "Elmshausen, Lautertal (Odenwald)",
      latlng: LatLng(49.70161105, 8.66949441615248)),
  Mapping(name: "Elmshausen, Lautertal", latlng: LatLng(49.7018372, 8.6700312)),
  Mapping(name: "Elnhausen, Marburg", latlng: LatLng(50.811665, 8.6905069)),
  Mapping(
      name: "Elnrode-Strang, Jesberg",
      latlng: LatLng(50.9615886, 9.16592561980638)),
  Mapping(
      name: "Elpenrod, Gemünden (Felda)",
      latlng: LatLng(50.6651529, 9.0832225)),
  Mapping(name: "Elpenrod, Gemünden", latlng: LatLng(50.6651529, 9.0832225)),
  Mapping(name: "Elsbach[7], Erbach", latlng: LatLng(49.652751, 8.9654089)),
  Mapping(name: "Elters, Hofbieber", latlng: LatLng(50.580279, 9.8814571)),
  Mapping(
      name: "Eltmannsee, Waldkappel", latlng: LatLng(51.0952616, 9.8289388)),
  Mapping(
      name: "Eltmannshausen, Eschwege", latlng: LatLng(51.185224, 9.9898048)),
  Mapping(name: "Eltville am Rhein", latlng: LatLng(50.0275441, 8.1189741)),
  Mapping(
      name: "Eltville, Eltville am Rhein",
      latlng: LatLng(50.05598255, 8.089147388160399)),
  Mapping(name: "Elz", latlng: LatLng(50.41348, 8.0363899)),
  Mapping(name: "Elz", latlng: LatLng(50.41348, 8.0363899)),
  Mapping(
      name: "Emmershausen, Weilrod",
      latlng: LatLng(50.3676548, 8.36616057602778)),
  Mapping(name: "Empfershausen, Körle", latlng: LatLng(51.1819869, 9.5518607)),
  Mapping(name: "Emsdorf, Kirchhain", latlng: LatLng(50.8670706, 8.9854002)),
  Mapping(
      name: "Endbach, Bad Endbach",
      latlng: LatLng(50.74828005, 8.487335662126021)),
  Mapping(name: "Engelbach, Biedenkopf", latlng: LatLng(50.9242969, 8.6082954)),
  Mapping(
      name: "Engelhelms, Künzell",
      latlng: LatLng(50.51456135, 9.71285039080507)),
  Mapping(
      name: "Engelrod, Lautertal (Vogelsberg)",
      latlng: LatLng(50.5783958, 9.2623682)),
  Mapping(name: "Engelrod, Lautertal", latlng: LatLng(50.5783958, 9.2623682)),
  Mapping(
      name: "Engenhahn, Niedernhausen",
      latlng: LatLng(50.16455775, 8.259409425881978)),
  Mapping(name: "Ennerich, Runkel", latlng: LatLng(50.3940196, 8.1250735)),
  Mapping(name: "Enzheim, Altenstadt", latlng: LatLng(50.2981811, 8.9895503)),
  Mapping(name: "Eppe, Korbach", latlng: LatLng(51.2364251, 8.7720749)),
  Mapping(
      name: "Eppenhain, Kelkheim (Taunus)",
      latlng: LatLng(50.1698512, 8.38632960618424)),
  Mapping(
      name: "Eppenhain, Kelkheim",
      latlng: LatLng(50.1698512, 8.38632960618424)),
  Mapping(
      name: "Eppertshausen, Eppertshausen",
      latlng: LatLng(49.9455348, 8.8422419)),
  Mapping(name: "Eppertshausen", latlng: LatLng(49.9490921, 8.8473667)),
  Mapping(name: "Eppstein", latlng: LatLng(50.1401917, 8.3921142)),
  Mapping(name: "Eppstein", latlng: LatLng(50.1401917, 8.3921142)),
  Mapping(
      name: "Epterode, Großalmerode", latlng: LatLng(51.2443253, 9.7901063)),
  Mapping(
      name: "Erbach (Rheingau), Eltville am Rhein",
      latlng: LatLng(50.0235139, 8.0953457)),
  Mapping(name: "Erbach, Bad Camberg", latlng: LatLng(50.3028798, 8.234595)),
  Mapping(
      name: "Erbach, Eltville am Rhein",
      latlng: LatLng(50.04416055, 8.056593960432386)),
  Mapping(name: "Erbach, Heppenheim", latlng: LatLng(49.6387544, 8.6672644)),
  Mapping(name: "Erbach", latlng: LatLng(48.3274603, 9.8913803)),
  Mapping(name: "Erbach", latlng: LatLng(48.3274603, 9.8913803)),
  Mapping(
      name: "Erbenhausen, Fronhausen",
      latlng: LatLng(50.7096957, 8.75915472335232)),
  Mapping(
      name: "Erbenhausen, Homberg (Ohm)", latlng: LatLng(50.7567098, 9.066955)),
  Mapping(name: "Erbenhausen, Homberg", latlng: LatLng(50.7567098, 9.066955)),
  Mapping(name: "Erbenheim, Wiesbaden", latlng: LatLng(50.0560203, 8.2967151)),
  Mapping(name: "Erbstadt, Nidderau", latlng: LatLng(50.2706216, 8.863447)),
  Mapping(name: "Erbuch, Erbach", latlng: LatLng(49.6408435, 9.0450214)),
  Mapping(
      name: "Erda, Hohenahr",
      latlng: LatLng(50.674004749999995, 8.52279915239573)),
  Mapping(
      name: "Erdbach, Breitscheid",
      latlng: LatLng(50.685055399999996, 8.227099759517944)),
  Mapping(name: "Erdhausen, Gladenbach", latlng: LatLng(50.7501622, 8.5650177)),
  Mapping(
      name: "Erdmannrode, Schenklengsfeld",
      latlng: LatLng(50.8116772, 9.7859493)),
  Mapping(name: "Erdpenhausen, Alheim", latlng: LatLng(51.0386276, 9.7035747)),
  Mapping(name: "Erfelden, Riedstadt", latlng: LatLng(49.8350252, 8.4691028)),
  Mapping(
      name: "Erfurtshausen, Amöneburg", latlng: LatLng(50.7471865, 8.9405489)),
  Mapping(
      name: "Erksdorf, Stadtallendorf", latlng: LatLng(50.8584013, 9.0227352)),
  Mapping(
      name: "Erkshausen, Rotenburg an der Fulda",
      latlng: LatLng(51.0342156, 9.7673185)),
  Mapping(name: "Erlenbach, Fürth", latlng: LatLng(49.6672974, 8.7455637)),
  Mapping(name: "Erlenbach[7], Erbach", latlng: LatLng(49.6461338, 9.0110168)),
  Mapping(name: "Erlensee", latlng: LatLng(50.1624394, 8.9846455)),
  Mapping(name: "Ermenrod, Feldatal", latlng: LatLng(50.6531404, 9.1380509)),
  Mapping(
      name: "Ermetheis, Niedenstein", latlng: LatLng(51.2318171, 9.3302306)),
  Mapping(
      name: "Ermschwerd, Witzenhausen", latlng: LatLng(51.3565522, 9.8182091)),
  Mapping(name: "Ernsbach, Erbach", latlng: LatLng(49.6634582, 9.0558111)),
  Mapping(name: "Ernsthausen, Burgwald", latlng: LatLng(50.9837866, 8.7340389)),
  Mapping(
      name: "Ernsthausen, Rauschenberg", latlng: LatLng(50.8963994, 8.9554433)),
  Mapping(
      name: "Ernsthausen, Weilmünster",
      latlng: LatLng(50.453136900000004, 8.354686773895924)),
  Mapping(name: "Ernsthofen, Modautal", latlng: LatLng(49.7716679, 8.7404949)),
  Mapping(name: "Ersen, Liebenau", latlng: LatLng(51.4674287, 9.2487572)),
  Mapping(
      name: "Ersheim, Hirschhorn (Neckar)",
      latlng: LatLng(49.4493037, 8.9065068)),
  Mapping(name: "Ersheim, Hirschhorn", latlng: LatLng(49.4493037, 8.9065068)),
  Mapping(name: "Ersrode, Ludwigsau", latlng: LatLng(50.9767214, 9.5870476)),
  Mapping(
      name: "Erzbach, Reichelsheim (Odenwald)",
      latlng: LatLng(49.6734168, 8.8658044)),
  Mapping(name: "Erzbach, Reichelsheim", latlng: LatLng(49.6734168, 8.8658044)),
  Mapping(
      name: "Erzhausen, Erzhausen",
      latlng: LatLng(49.95196895, 8.63925194132099)),
  Mapping(name: "Erzhausen", latlng: LatLng(49.9524332, 8.6389953)),
  Mapping(
      name: "Esch, Waldems",
      latlng: LatLng(50.247503699999996, 8.325287632303237)),
  Mapping(
      name: "Eschbach, Usingen",
      latlng: LatLng(50.369542550000006, 8.52342334177894)),
  Mapping(name: "Eschborn", latlng: LatLng(50.1426423, 8.5716274)),
  Mapping(name: "Eschborn", latlng: LatLng(50.1426423, 8.5716274)),
  Mapping(name: "Escheberg, Zierenberg", latlng: LatLng(51.3971329, 9.2489713)),
  Mapping(name: "Eschenau, Runkel", latlng: LatLng(50.4374402, 8.1733216)),
  Mapping(name: "Eschenburg", latlng: LatLng(50.814301, 8.3403065)),
  Mapping(
      name: "Eschenhahn, Idstein",
      latlng: LatLng(50.1896541, 8.239959682951294)),
  Mapping(name: "Eschenrod, Schotten", latlng: LatLng(50.4777054, 9.1572423)),
  Mapping(name: "Eschenstruth, Helsa", latlng: LatLng(51.2272585, 9.6669415)),
  Mapping(
      name: "Eschersheim, Frankfurt am Main",
      latlng: LatLng(50.1582027, 8.6562116)),
  Mapping(
      name: "Eschhofen, Limburg an der Lahn",
      latlng: LatLng(50.3915701, 8.1022599)),
  Mapping(
      name: "Eschollbrücken, Pfungstadt",
      latlng: LatLng(49.8108059, 8.5661928)),
  Mapping(name: "Eschwege", latlng: LatLng(51.186867, 10.0575056)),
  Mapping(name: "Eschwege", latlng: LatLng(51.186867, 10.0575056)),
  Mapping(
      name: "Espa, Langgöns",
      latlng: LatLng(50.426570549999994, 8.594557459171398)),
  Mapping(name: "Espenau", latlng: LatLng(51.3913412, 9.4582002)),
  Mapping(name: "Espenschied, Lorch", latlng: LatLng(50.1123882, 7.9042955)),
  Mapping(
      name: "Essershausen, Weilmünster", latlng: LatLng(50.4580559, 8.3253449)),
  Mapping(
      name: "Ettingshausen, Reiskirchen",
      latlng: LatLng(50.56088665, 8.889472284824567)),
  Mapping(name: "Etzean, Oberzent", latlng: LatLng(49.5886977, 8.9671752)),
  Mapping(
      name: "Etzen-Gesäß, Bad König", latlng: LatLng(49.7588169, 8.9991821)),
  Mapping(name: "Eubach, Morschen", latlng: LatLng(51.0930745, 9.6330434)),
  Mapping(name: "Eudorf, Alsfeld", latlng: LatLng(50.766344, 9.2903504)),
  Mapping(name: "Eulbach, Michelstadt", latlng: LatLng(49.6792831, 9.0760127)),
  Mapping(name: "Eulersdorf, Grebenau", latlng: LatLng(50.7359961, 9.4492895)),
  Mapping(name: "Eulsbach, Lindenfels", latlng: LatLng(49.6762411, 8.7643502)),
  Mapping(
      name: "Ewersbach, Dietzhölztal", latlng: LatLng(50.8320168, 8.3153832)),
  Mapping(
      name: "Fahrenbach, Fürth (Odenwald)",
      latlng: LatLng(49.6484006, 8.7804585)),
  Mapping(name: "Fahrenbach, Fürth", latlng: LatLng(49.6374391, 8.7684524)),
  Mapping(name: "Falken-Gesäß, Oberzent", latlng: LatLng(49.565175, 8.9370132)),
  Mapping(name: "Falkenbach, Villmar", latlng: LatLng(50.4356423, 8.2468057)),
  Mapping(name: "Falkenberg, Wabern", latlng: LatLng(51.0713267, 9.397689)),
  Mapping(
      name: "Falkenstein, Königstein im Taunus",
      latlng: LatLng(50.2074343, 8.467311798469186)),
  Mapping(name: "Fasanenhof, Kassel", latlng: LatLng(51.3327593, 9.5129982)),
  Mapping(name: "Fauerbach, Nidda", latlng: LatLng(50.4052575, 9.0644297)),
  Mapping(
      name: "Faulbach, Hadamar", latlng: LatLng(50.4469467, 8.063761246700324)),
  Mapping(
      name: "Fechenheim, Frankfurt am Main",
      latlng: LatLng(50.123015, 8.7693856)),
  Mapping(name: "Federwisch, Flieden", latlng: LatLng(50.4265331, 9.526214)),
  Mapping(name: "Fehlheim, Bensheim", latlng: LatLng(49.7048641, 8.5715908)),
  Mapping(name: "Feldatal", latlng: LatLng(50.6391564, 9.1811688)),
  Mapping(
      name: "Feldkrücken, Ulrichstein", latlng: LatLng(50.551498, 9.1869071)),
  Mapping(
      name: "Fellerdilln, Haiger",
      latlng: LatLng(50.79318145, 8.200014747023367)),
  Mapping(
      name: "Fellingshausen, Biebertal",
      latlng: LatLng(50.64344165, 8.590780298683928)),
  Mapping(name: "Felsberg", latlng: LatLng(51.1502197, 9.451222)),
  Mapping(name: "Felsberg", latlng: LatLng(51.1502197, 9.451222)),
  Mapping(name: "Fernwald", latlng: LatLng(50.5673903, 8.7770992)),
  Mapping(name: "Findlos, Hilders", latlng: LatLng(50.551512, 10.000539)),
  Mapping(name: "Finkenbach, Oberzent", latlng: LatLng(49.517244, 8.9068883)),
  Mapping(name: "Finkenhain, Dipperz", latlng: LatLng(50.5335145, 9.8361343)),
  Mapping(
      name: "Finsternthal, Weilrod",
      latlng: LatLng(50.29256195, 8.414572959903733)),
  Mapping(
      name: "Fischbach (Taunus), Kelkheim (Taunus)",
      latlng: LatLng(50.152256, 8.422921993978207)),
  Mapping(name: "Fischbach, Alsfeld", latlng: LatLng(50.8179463, 9.2161887)),
  Mapping(
      name: "Fischbach, Bad Schwalbach", latlng: LatLng(50.1064996, 8.0300715)),
  Mapping(name: "Fischbach, Hauneck", latlng: LatLng(50.8131785, 9.772107)),
  Mapping(name: "Fischbach", latlng: LatLng(49.7462374, 6.1866614)),
  Mapping(name: "Fischbachtal", latlng: LatLng(49.7673565, 8.8097032)),
  Mapping(name: "Fischborn, Birstein", latlng: LatLng(50.3826404, 9.2982986)),
  Mapping(
      name: "Flammersbach, Haiger",
      latlng: LatLng(50.72133975, 8.166510338101913)),
  Mapping(name: "Flechtdorf, Diemelsee", latlng: LatLng(51.3273068, 8.8259453)),
  Mapping(
      name: "Fleisbach, Sinn", latlng: LatLng(50.64046185, 8.303524044178491)),
  Mapping(name: "Flensungen, Mücke", latlng: LatLng(50.6097827, 9.0260223)),
  Mapping(
      name: "Fleschenbach, Freiensteinau",
      latlng: LatLng(50.4041545, 9.3946753)),
  Mapping(name: "Flieden", latlng: LatLng(50.4164633, 9.5467301)),
  Mapping(name: "Flieden", latlng: LatLng(50.4164633, 9.5467301)),
  Mapping(
      name: "Flörsbach, Flörsbachtal", latlng: LatLng(50.1314481, 9.4128175)),
  Mapping(name: "Flörsbachtal", latlng: LatLng(50.1208, 9.4375)),
  Mapping(
      name: "Florshain, Schwalmstadt", latlng: LatLng(50.9119295, 9.1349966)),
  Mapping(name: "Flörsheim am Main", latlng: LatLng(50.0167244, 8.4236983)),
  Mapping(
      name: "Flörsheim, Flörsheim am Main",
      latlng: LatLng(50.0172412, 8.4309242)),
  Mapping(name: "Florstadt", latlng: LatLng(50.3173479, 8.8653526)),
  Mapping(
      name: "Flughafen, Frankfurt am Main",
      latlng: LatLng(50.02294325, 8.524937254258731)),
  Mapping(
      name: "Forstel, Höchst i. Odw.", latlng: LatLng(49.7735058, 8.9594408)),
  Mapping(name: "Forstfeld, Kassel", latlng: LatLng(51.2923614, 9.5404671)),
  Mapping(name: "Frankenau", latlng: LatLng(51.1068994, 8.9274787)),
  Mapping(name: "Frankenau", latlng: LatLng(51.1068994, 8.9274787)),
  Mapping(
      name: "Frankenbach, Biebertal",
      latlng: LatLng(50.6748592, 8.569558305282996)),
  Mapping(name: "Frankenberg (Eder)", latlng: LatLng(51.0771933, 8.7908312)),
  Mapping(name: "Frankenberg", latlng: LatLng(50.9110365, 13.0331023)),
  Mapping(name: "Frankenhain, Berkatal", latlng: LatLng(51.2405461, 9.8952815)),
  Mapping(
      name: "Frankenhain, Schwalmstadt", latlng: LatLng(50.9250517, 9.1565586)),
  Mapping(
      name: "Frankenhausen, Mühltal", latlng: LatLng(49.7872998, 8.7075653)),
  Mapping(
      name: "Frankershausen, Berkatal", latlng: LatLng(51.2360688, 9.9223995)),
  Mapping(name: "Frankfurt am Main", latlng: LatLng(50.1106444, 8.6820917)),
  Mapping(
      name: "Frankfurter Berg, Frankfurt am Main",
      latlng: LatLng(50.1680209, 8.6756884)),
  Mapping(
      name: "Fränkisch-Crumbach, Fränkisch-Crumbach",
      latlng: LatLng(49.7451903, 8.860648)),
  Mapping(name: "Fränkisch-Crumbach", latlng: LatLng(49.7451903, 8.860648)),
  Mapping(
      name: "Frau-Nauses, Groß-Umstadt", latlng: LatLng(49.8231688, 8.9629877)),
  Mapping(
      name: "Frauenborn, Herleshausen", latlng: LatLng(51.0294235, 10.1510298)),
  Mapping(
      name: "Frauenstein, Wiesbaden", latlng: LatLng(50.0659931, 8.1548544)),
  Mapping(name: "Fraurombach, Schlitz", latlng: LatLng(50.6747724, 9.6120525)),
  Mapping(
      name: "Frebershausen, Bad Wildungen",
      latlng: LatLng(51.1090421, 8.9822182)),
  Mapping(
      name: "Frechenhausen, Angelburg",
      latlng: LatLng(50.80581805, 8.439702468776975)),
  Mapping(name: "Freienfels, Weinbach", latlng: LatLng(50.4567256, 8.2956013)),
  Mapping(
      name: "Freienhagen, Waldeck (Stadt)",
      latlng: LatLng(51.2813782, 9.063048035706725)),
  Mapping(name: "Freienhagen, Waldeck", latlng: LatLng(51.2786572, 9.0662946)),
  Mapping(
      name: "Freienseen, Laubach",
      latlng: LatLng(50.55838085, 9.066892836172627)),
  Mapping(name: "Freiensteinau", latlng: LatLng(50.43972, 9.39245)),
  Mapping(name: "Freiensteinau", latlng: LatLng(50.43972, 9.39245)),
  Mapping(name: "Freiensteinau", latlng: LatLng(50.43972, 9.39245)),
  Mapping(name: "Freigericht", latlng: LatLng(50.134197, 9.1453389)),
  Mapping(
      name: "Freudenthal, Borken (Hessen)",
      latlng: LatLng(51.0248809, 9.3269849)),
  Mapping(name: "Frickhofen, Dornburg", latlng: LatLng(50.5040438, 8.0237068)),
  Mapping(
      name: "Friebertshausen, Gladenbach",
      latlng: LatLng(50.7748633, 8.6418264)),
  Mapping(name: "Frieda, Meinhard", latlng: LatLng(51.1906946, 10.1258204)),
  Mapping(name: "Friedberg (Hessen)", latlng: LatLng(50.3352682, 8.7539306)),
  Mapping(
      name: "Friedberg (Kernstadt), Friedberg",
      latlng: LatLng(50.3250972, 8.7575508)),
  Mapping(name: "Friedberg", latlng: LatLng(50.3352682, 8.7539306)),
  Mapping(
      name: "Friedensdorf, Dautphetal", latlng: LatLng(50.8530097, 8.5658331)),
  Mapping(name: "Friedewald", latlng: LatLng(50.709415, 7.9587491)),
  Mapping(name: "Friedewald", latlng: LatLng(50.709415, 7.9587491)),
  Mapping(
      name: "Friedigerode, Oberaula", latlng: LatLng(50.8785042, 9.4678717)),
  Mapping(name: "Friedlos, Ludwigsau", latlng: LatLng(50.8990196, 9.743333)),
  Mapping(
      name: "Friedrichsaue, Zierenberg", latlng: LatLng(51.3798197, 9.2757783)),
  Mapping(
      name: "Friedrichsbrück, Hessisch Lichtenau",
      latlng: LatLng(51.2225703, 9.7431404)),
  Mapping(
      name: "Friedrichsdorf, Hofgeismar", latlng: LatLng(51.490042, 9.3290227)),
  Mapping(name: "Friedrichsdorf", latlng: LatLng(50.2556672, 8.6511395)),
  Mapping(name: "Friedrichsdorf", latlng: LatLng(50.2556672, 8.6511395)),
  Mapping(
      name: "Friedrichsfeld, Trendelburg",
      latlng: LatLng(51.573449, 9.4608273)),
  Mapping(
      name: "Friedrichshausen, Frankenberg (Eder)",
      latlng: LatLng(51.0469624, 8.8570485)),
  Mapping(
      name: "Friedrichshausen, Frankenberg",
      latlng: LatLng(51.0469624, 8.8570485)),
  Mapping(
      name: "Friedrichstein, Zierenberg",
      latlng: LatLng(51.3542747, 9.3376753)),
  Mapping(
      name: "Friedrichsthal, Grebenstein",
      latlng: LatLng(51.444197, 9.3654028)),
  Mapping(
      name: "Friedrichsthal, Wehrheim", latlng: LatLng(50.3422607, 8.6149002)),
  Mapping(name: "Frielendorf", latlng: LatLng(50.9477718, 9.3257673)),
  Mapping(name: "Frielendorf", latlng: LatLng(50.9477718, 9.3257673)),
  Mapping(name: "Frielingen, Kirchheim", latlng: LatLng(50.8550606, 9.5318876)),
  Mapping(name: "Friemen, Waldkappel", latlng: LatLng(51.1239619, 9.8506386)),
  Mapping(
      name: "Friesenhausen, Dipperz", latlng: LatLng(50.5243504, 9.8276507)),
  Mapping(
      name: "Frischborn, Lauterbach", latlng: LatLng(50.6102438, 9.3663731)),
  Mapping(name: "Fritzlar", latlng: LatLng(51.131196, 9.2748504)),
  Mapping(name: "Fritzlar", latlng: LatLng(51.131196, 9.2748504)),
  Mapping(
      name: "Frohnhausen, Battenberg (Eder)",
      latlng: LatLng(50.9662701, 8.6232484)),
  Mapping(
      name: "Frohnhausen, Battenberg", latlng: LatLng(50.9662701, 8.6232484)),
  Mapping(
      name: "Frohnhausen, Dillenburg",
      latlng: LatLng(50.784226000000004, 8.294179495331608)),
  Mapping(
      name: "Frohnhausen, Gladenbach", latlng: LatLng(50.7838563, 8.6189711)),
  Mapping(
      name: "Frohnhofen, Reichelsheim (Odenwald)",
      latlng: LatLng(49.705416, 8.8547959)),
  Mapping(
      name: "Frohnhofen, Reichelsheim", latlng: LatLng(49.705416, 8.8547959)),
  Mapping(
      name: "Frommershausen, Vellmar", latlng: LatLng(51.365435, 9.4744985)),
  Mapping(
      name: "Fronhausen, Fronhausen", latlng: LatLng(50.7027934, 8.6945193)),
  Mapping(name: "Fronhausen", latlng: LatLng(50.7027934, 8.6945193)),
  Mapping(
      name: "Froschhausen, Seligenstadt", latlng: LatLng(50.0534361, 8.935797)),
  Mapping(name: "Fulda", latlng: LatLng(50.5542328, 9.6770448)),
  Mapping(name: "Fulda", latlng: LatLng(50.5542328, 9.6770448)),
  Mapping(name: "Fulda", latlng: LatLng(50.5542328, 9.6770448)),
  Mapping(name: "Fuldabrück", latlng: LatLng(51.2434433, 9.494343)),
  Mapping(name: "Fuldatal", latlng: LatLng(51.3781639, 9.533699)),
  Mapping(name: "Fürfurt, Weinbach", latlng: LatLng(50.430073, 8.2549544)),
  Mapping(
      name: "Fürstenberg, Lichtenfels (Hessen)",
      latlng: LatLng(51.1719228, 8.8340576)),
  Mapping(
      name: "Fürstenberg, Lichtenfels", latlng: LatLng(51.1719228, 8.8340576)),
  Mapping(
      name: "Fürstengrund, Bad König", latlng: LatLng(49.7586063, 9.0321275)),
  Mapping(
      name: "Fürstenhagen, Hessisch Lichtenau",
      latlng: LatLng(51.2112346, 9.69066)),
  Mapping(name: "Fürstenwald, Calden", latlng: LatLng(51.3833589, 9.3645901)),
  Mapping(name: "Fürth", latlng: LatLng(49.4772475, 10.9893626)),
  Mapping(name: "Fürth", latlng: LatLng(49.4772475, 10.9893626)),
  Mapping(name: "Fussingen, Waldbrunn", latlng: LatLng(50.5221764, 8.1191078)),
  Mapping(
      name: "Gackenhof, Poppenhausen", latlng: LatLng(50.4760839, 9.8707383)),
  Mapping(
      name: "Gadern, Wald-Michelbach", latlng: LatLng(49.5868447, 8.8142055)),
  Mapping(
      name: "Gadernheim, Lautertal (Odenwald)",
      latlng: LatLng(49.7122997, 8.736815048468397)),
  Mapping(name: "Gadernheim, Lautertal", latlng: LatLng(49.7161144, 8.7424253)),
  Mapping(
      name: "Gallus, Frankfurt am Main", latlng: LatLng(50.1038405, 8.6431009)),
  Mapping(name: "Gambach, Münzenberg", latlng: LatLng(50.461371, 8.729535)),
  Mapping(name: "Gammelsbach, Oberzent", latlng: LatLng(49.5265475, 8.9644873)),
  Mapping(
      name: "Garbenheim, Wetzlar",
      latlng: LatLng(50.56282215, 8.535702992891542)),
  Mapping(
      name: "Garbenteich, Pohlheim",
      latlng: LatLng(50.53316785, 8.758270796990589)),
  Mapping(name: "Gassen, Biebergemünd", latlng: LatLng(50.1618686, 9.3435987)),
  Mapping(name: "Gasterfeld, Wolfhagen", latlng: LatLng(51.3419105, 9.1330676)),
  Mapping(name: "Gaudernbach, Weilburg", latlng: LatLng(50.4655067, 8.2018751)),
  Mapping(
      name: "Gebersdorf, Frielendorf", latlng: LatLng(50.9602916, 9.3025797)),
  Mapping(name: "Gedern", latlng: LatLng(50.4051, 9.2135)),
  Mapping(name: "Gedern", latlng: LatLng(50.4051, 9.2135)),
  Mapping(
      name: "Gehau, Breitenbach am Herzberg",
      latlng: LatLng(50.7796776, 9.4775165)),
  Mapping(name: "Gehau, Waldkappel", latlng: LatLng(51.0971516, 9.8117806)),
  Mapping(
      name: "Geilshausen, Rabenau",
      latlng: LatLng(50.64317345, 8.878681174811575)),
  Mapping(
      name: "Geisenbach, Mörlenbach", latlng: LatLng(49.5642787, 8.7604608)),
  Mapping(name: "Geisenheim", latlng: LatLng(49.9863945, 7.96852)),
  Mapping(name: "Geisenheim", latlng: LatLng(49.9863945, 7.96852)),
  Mapping(
      name: "Geislitz, Linsengericht", latlng: LatLng(50.172198, 9.2155463)),
  Mapping(
      name: "Geismar, Frankenberg (Eder)",
      latlng: LatLng(51.0749716, 8.8626272)),
  Mapping(name: "Geismar, Frankenberg", latlng: LatLng(51.0749716, 8.8626272)),
  Mapping(name: "Geismar, Fritzlar", latlng: LatLng(51.1401864, 9.2481052)),
  Mapping(name: "Geiß-Nidda, Nidda", latlng: LatLng(50.4037968, 8.9688941)),
  Mapping(
      name: "Gellershausen, Edertal", latlng: LatLng(51.1294641, 9.0133957)),
  Mapping(name: "Gelnhaar, Ortenberg", latlng: LatLng(50.3636992, 9.146576)),
  Mapping(name: "Gelnhausen", latlng: LatLng(50.2028622, 9.190486)),
  Mapping(name: "Gembeck, Twistetal", latlng: LatLng(51.3535408, 8.8985949)),
  Mapping(name: "Gemünden (Felda)", latlng: LatLng(50.6776697, 9.0762084)),
  Mapping(name: "Gemünden (Wohra)", latlng: LatLng(50.9934023, 8.9675885)),
  Mapping(
      name: "Gemünden, Weilrod",
      latlng: LatLng(50.35692295, 8.393205160763465)),
  Mapping(name: "Gemünden", latlng: LatLng(50.5599325, 8.0176918)),
  Mapping(name: "Gensungen, Felsberg", latlng: LatLng(51.1308619, 9.4353788)),
  Mapping(
      name: "Georgenborn, Schlangenbad", latlng: LatLng(50.0873753, 8.1210846)),
  Mapping(
      name: "Georgenhausen, Reinheim",
      latlng: LatLng(49.845889549999995, 8.806116510909348)),
  Mapping(name: "Germerode, Meißner", latlng: LatLng(51.1963229, 9.9052964)),
  Mapping(name: "Gernsheim", latlng: LatLng(49.7505186, 8.4861853)),
  Mapping(name: "Gernsheim", latlng: LatLng(49.7505186, 8.4861853)),
  Mapping(name: "Gernsheim", latlng: LatLng(49.7505186, 8.4861853)),
  Mapping(
      name: "Geroldstein, Heidenrod",
      latlng: LatLng(50.10680895, 7.938199862925503)),
  Mapping(name: "Gersdorf, Kirchheim", latlng: LatLng(50.8560359, 9.5166097)),
  Mapping(name: "Gersfeld (Rhön)", latlng: LatLng(50.4497667, 9.8943709)),
  Mapping(name: "Gersfeld", latlng: LatLng(50.4497667, 9.8943709)),
  Mapping(name: "Gershausen, Kirchheim", latlng: LatLng(50.8304215, 9.5558096)),
  Mapping(
      name: "Gersprenz, Reichelsheim (Odenwald)",
      latlng: LatLng(49.7313998, 8.8719543)),
  Mapping(
      name: "Gersprenz, Reichelsheim", latlng: LatLng(49.7313998, 8.8719543)),
  Mapping(name: "Gersrod, Hosenfeld", latlng: LatLng(50.5266295, 9.4884934)),
  Mapping(
      name: "Gertenbach, Witzenhausen", latlng: LatLng(51.3784218, 9.8021548)),
  Mapping(name: "Gerterode, Ludwigsau", latlng: LatLng(50.9334869, 9.6819958)),
  Mapping(
      name: "Gethsemane, Philippsthal", latlng: LatLng(50.856553, 9.9226059)),
  Mapping(name: "Gettenau, Echzell", latlng: LatLng(50.3813094, 8.8825014)),
  Mapping(name: "Gettenbach, Gründau", latlng: LatLng(50.2371262, 9.1578546)),
  Mapping(name: "Gewissenruh, Wesertal", latlng: LatLng(51.6271549, 9.5349522)),
  Mapping(
      name: "Gichenbach, Gersfeld (Rhön)",
      latlng: LatLng(50.42923785, 9.854799313781486)),
  Mapping(
      name: "Gichenbach, Gersfeld",
      latlng: LatLng(50.42923785, 9.854799313781486)),
  Mapping(
      name: "Giebringhausen, Diemelsee", latlng: LatLng(51.3393725, 8.7349251)),
  Mapping(name: "Giesel, Neuhof", latlng: LatLng(50.5040697, 9.5668425)),
  Mapping(name: "Gieselwerder, Wesertal", latlng: LatLng(51.5983388, 9.550225)),
  Mapping(
      name: "Giesenhain, Eiterfeld",
      latlng: LatLng(50.765223, 9.743752611178248)),
  Mapping(name: "Gießen", latlng: LatLng(50.5862066, 8.6742306)),
  Mapping(name: "Gießen", latlng: LatLng(50.5862066, 8.6742306)),
  Mapping(name: "Giflitz, Edertal", latlng: LatLng(51.1558438, 9.1215993)),
  Mapping(name: "Gilfershausen, Bebra", latlng: LatLng(50.9885182, 9.8315117)),
  Mapping(name: "Gilsa, Neuental", latlng: LatLng(51.0131621, 9.1913501)),
  Mapping(name: "Gilserberg", latlng: LatLng(50.9403331, 9.0766867)),
  Mapping(name: "Gilserberg", latlng: LatLng(50.9403331, 9.0766867)),
  Mapping(
      name: "Ginnheim, Frankfurt am Main",
      latlng: LatLng(50.143081, 8.6498558)),
  Mapping(name: "Ginseldorf, Marburg", latlng: LatLng(50.8397762, 8.8188573)),
  Mapping(name: "Ginsheim-Gustavsburg", latlng: LatLng(49.9845346, 8.3254964)),
  Mapping(
      name: "Ginsheim, Ginsheim-Gustavsburg",
      latlng: LatLng(49.9794903, 8.3317364)),
  Mapping(name: "Gisselberg, Marburg", latlng: LatLng(50.7728388, 8.7487946)),
  Mapping(
      name: "Gittersdorf, Neuenstein", latlng: LatLng(50.889754, 9.6474188)),
  Mapping(name: "Glaam, Hohenroda", latlng: LatLng(50.8137646, 9.9388189)),
  Mapping(name: "Gladenbach", latlng: LatLng(50.7689363, 8.5819848)),
  Mapping(name: "Gladenbach", latlng: LatLng(50.7689363, 8.5819848)),
  Mapping(
      name: "Gläserzell, Fulda",
      latlng: LatLng(50.58254875, 9.645172684170634)),
  Mapping(
      name: "Glashütten, Hirzenhain", latlng: LatLng(50.4181138, 9.1347118)),
  Mapping(name: "Glashütten", latlng: LatLng(49.8896527, 11.4491309)),
  Mapping(name: "Glashütten", latlng: LatLng(49.8896527, 11.4491309)),
  Mapping(name: "Glattbach, Lindenfels", latlng: LatLng(49.6941591, 8.7504726)),
  Mapping(name: "Glauberg, Glauburg", latlng: LatLng(50.311502, 9.0152586)),
  Mapping(name: "Glauburg", latlng: LatLng(50.3217415, 9.0023933)),
  Mapping(name: "Gleichen, Gudensberg", latlng: LatLng(51.1902696, 9.3162454)),
  Mapping(name: "Gleimenhain, Kirtorf", latlng: LatLng(50.8237808, 9.1174517)),
  Mapping(
      name: "Göbelnrod, Grünberg",
      latlng: LatLng(50.59910705, 8.921586178287601)),
  Mapping(name: "Goddelau, Riedstadt", latlng: LatLng(49.8354483, 8.4956919)),
  Mapping(
      name: "Goddelsheim, Lichtenfels (Hessen)",
      latlng: LatLng(51.2018766, 8.8061608)),
  Mapping(
      name: "Goddelsheim, Lichtenfels", latlng: LatLng(51.2018766, 8.8061608)),
  Mapping(name: "Goldhausen, Korbach", latlng: LatLng(51.2484407, 8.8196091)),
  Mapping(
      name: "Gombeth, Borken (Hessen)", latlng: LatLng(51.0657625, 9.2904529)),
  Mapping(name: "Gombeth, Borken", latlng: LatLng(51.0657625, 9.2904529)),
  Mapping(name: "Gomfritz, Schlüchtern", latlng: LatLng(50.3848194, 9.5386165)),
  Mapping(name: "Gondsroth, Hasselroth", latlng: LatLng(50.1534351, 9.1041426)),
  Mapping(
      name: "Gönnern, Angelburg",
      latlng: LatLng(50.816812299999995, 8.447023300056077)),
  Mapping(
      name: "Gontershausen, Homberg (Ohm)",
      latlng: LatLng(50.7362448, 8.9689265)),
  Mapping(
      name: "Gontershausen, Homberg", latlng: LatLng(50.7362448, 8.9689265)),
  Mapping(
      name: "Gonterskirchen, Laubach",
      latlng: LatLng(50.5120423, 9.037289835087597)),
  Mapping(
      name: "Gonzenheim, Bad Homburg vor der Höhe",
      latlng: LatLng(50.2201779, 8.6398874)),
  Mapping(name: "Görsroth, Hünstetten", latlng: LatLng(50.2262632, 8.2135334)),
  Mapping(
      name: "Gorxheim, Gorxheimertal", latlng: LatLng(49.5401325, 8.7088627)),
  Mapping(name: "Gorxheimertal", latlng: LatLng(49.5310565, 8.7328525)),
  Mapping(name: "Görzhain, Ottrau", latlng: LatLng(50.8108956, 9.4259058)),
  Mapping(name: "Goßfelden, Lahntal", latlng: LatLng(50.8636706, 8.74682)),
  Mapping(
      name: "Goßmannsrode, Kirchheim", latlng: LatLng(50.8583439, 9.5802838)),
  Mapping(name: "Gotthards, Nüsttal", latlng: LatLng(50.6216864, 9.9013673)),
  Mapping(name: "Göttingen, Lahntal", latlng: LatLng(50.8756738, 8.776117)),
  Mapping(
      name: "Gottsbüren, Trendelburg", latlng: LatLng(51.5795999, 9.4998089)),
  Mapping(name: "Gottstreu, Wesertal", latlng: LatLng(51.5772226, 9.5860367)),
  Mapping(name: "Götzen, Schotten", latlng: LatLng(50.5191951, 9.1411831)),
  Mapping(name: "Götzenhain, Dreieich", latlng: LatLng(49.9983379, 8.7333529)),
  Mapping(name: "Götzenhof, Petersberg", latlng: LatLng(50.5810862, 9.7168291)),
  Mapping(
      name: "Gräfenhausen, Weiterstadt", latlng: LatLng(49.9303376, 8.6022279)),
  Mapping(name: "Grandenborn, Ringgau", latlng: LatLng(51.0822614, 10.0375508)),
  Mapping(
      name: "Gras-Ellenbach, Grasellenbach",
      latlng: LatLng(49.6281399, 8.8625552)),
  Mapping(
      name: "Grasellenbach", latlng: LatLng(49.62869345, 8.843560887255553)),
  Mapping(
      name: "Gravenbruch, Neu-Isenburg", latlng: LatLng(50.0597725, 8.7516482)),
  Mapping(name: "Gräveneck, Weinbach", latlng: LatLng(50.4488435, 8.2573252)),
  Mapping(name: "Grävenwiesbach", latlng: LatLng(50.386783, 8.4573342)),
  Mapping(name: "Grävenwiesbach", latlng: LatLng(50.386783, 8.4573342)),
  Mapping(name: "Grebenau, Guxhagen", latlng: LatLng(51.2025069, 9.4811975)),
  Mapping(name: "Grebenau", latlng: LatLng(50.7302717, 9.4369168)),
  Mapping(name: "Grebenau", latlng: LatLng(50.7302717, 9.4369168)),
  Mapping(name: "Grebendorf, Meinhard", latlng: LatLng(51.2244767, 10.0724629)),
  Mapping(
      name: "Grebenhagen, Schwarzenborn", latlng: LatLng(50.9159277, 9.47865)),
  Mapping(name: "Grebenhain", latlng: LatLng(50.4964493, 9.3254613)),
  Mapping(name: "Grebenhain", latlng: LatLng(50.4964493, 9.3254613)),
  Mapping(name: "Grebenroth, Heidenrod", latlng: LatLng(50.1984638, 7.9337341)),
  Mapping(name: "Grebenstein", latlng: LatLng(51.4474181, 9.414293)),
  Mapping(name: "Grebenstein", latlng: LatLng(51.4474181, 9.414293)),
  Mapping(name: "Greifenstein", latlng: LatLng(50.5951403, 8.2583542)),
  Mapping(name: "Greifenstein", latlng: LatLng(50.5951403, 8.2583542)),
  Mapping(
      name: "Greifenthal, Ehringshausen",
      latlng: LatLng(50.6030639, 8.316853535247581)),
  Mapping(
      name: "Grein, Neckarsteinach",
      latlng: LatLng(49.443748049999996, 8.84446261122291)),
  Mapping(name: "Griedel, Butzbach", latlng: LatLng(50.440442, 8.7055761)),
  Mapping(
      name: "Griedelbach, Waldsolms",
      latlng: LatLng(50.45418445, 8.519748536879781)),
  Mapping(
      name: "Griesheim, Frankfurt am Main",
      latlng: LatLng(50.0914289, 8.6078631)),
  Mapping(name: "Griesheim, Griesheim", latlng: LatLng(50.0942339, 8.6058328)),
  Mapping(name: "Griesheim", latlng: LatLng(48.63551, 7.667722)),
  Mapping(name: "Grifte, Edermünde", latlng: LatLng(51.211625, 9.4447371)),
  Mapping(name: "Grimelsheim, Liebenau", latlng: LatLng(51.4765415, 9.2327537)),
  Mapping(name: "Gronau, Bad Vilbel", latlng: LatLng(50.1929469, 8.7811392)),
  Mapping(name: "Gronau, Bensheim", latlng: LatLng(49.6835273, 8.6723952)),
  Mapping(name: "Groß-Bieberau", latlng: LatLng(49.7902515, 8.8161036)),
  Mapping(name: "Groß-Bieberau", latlng: LatLng(49.7902515, 8.8161036)),
  Mapping(name: "Groß-Bieberau", latlng: LatLng(49.7902515, 8.8161036)),
  Mapping(
      name: "Groß-Breitenbach, Mörlenbach",
      latlng: LatLng(49.6058829, 8.7490167)),
  Mapping(name: "Groß-Eichen, Mücke", latlng: LatLng(50.5991539, 9.0758651)),
  Mapping(name: "Groß-Felda, Feldatal", latlng: LatLng(50.6508707, 9.1716372)),
  Mapping(name: "Groß-Gerau", latlng: LatLng(49.9194456, 8.4852426)),
  Mapping(name: "Groß-Gerau", latlng: LatLng(49.9194456, 8.4852426)),
  Mapping(name: "Groß-Karben, Karben", latlng: LatLng(50.2389675, 8.7725734)),
  Mapping(
      name: "Groß-Rohrheim, Groß-Rohrheim",
      latlng: LatLng(49.7139417, 8.4766609)),
  Mapping(name: "Groß-Rohrheim", latlng: LatLng(49.7172193, 8.4730404)),
  Mapping(name: "Groß-Umstadt", latlng: LatLng(49.86477, 8.95669)),
  Mapping(name: "Groß-Umstadt", latlng: LatLng(49.86477, 8.95669)),
  Mapping(name: "Groß-Zimmern", latlng: LatLng(49.8864905, 8.8014685)),
  Mapping(name: "Groß-Zimmern", latlng: LatLng(49.8864905, 8.8014685)),
  Mapping(name: "Großalmerode", latlng: LatLng(51.2440301, 9.80537)),
  Mapping(name: "Großalmerode", latlng: LatLng(51.2440301, 9.80537)),
  Mapping(
      name: "Großaltenstädten, Hohenahr",
      latlng: LatLng(50.6550985, 8.483433844380908)),
  Mapping(name: "Großauheim, Hanau", latlng: LatLng(50.1026386, 8.9458834)),
  Mapping(
      name: "Großen-Buseck, Buseck",
      latlng: LatLng(50.6154586, 8.78999154488917)),
  Mapping(name: "Großen-Linden, Linden", latlng: LatLng(50.5290314, 8.6508486)),
  Mapping(
      name: "Großenbach, Hünfeld",
      latlng: LatLng(50.6864548, 9.807298965825208)),
  Mapping(
      name: "Großenenglis, Borken (Hessen)",
      latlng: LatLng(51.0781576, 9.2740741)),
  Mapping(name: "Großenenglis, Borken", latlng: LatLng(51.0781576, 9.2740741)),
  Mapping(
      name: "Großenhausen, Linsengericht",
      latlng: LatLng(50.1603882, 9.1900715)),
  Mapping(name: "Großenlüder", latlng: LatLng(50.5753618, 9.5502218)),
  Mapping(name: "Großenlüder", latlng: LatLng(50.5753618, 9.5502218)),
  Mapping(name: "Großenmoor, Burghaun", latlng: LatLng(50.7032916, 9.6522364)),
  Mapping(name: "Großenritte, Baunatal", latlng: LatLng(51.2477437, 9.3845517)),
  Mapping(
      name: "Großentaft, Eiterfeld",
      latlng: LatLng(50.739293, 9.851142370926429)),
  Mapping(
      name: "Großkrotzenburg, Großkrotzenburg",
      latlng: LatLng(50.0875611, 8.9830827)),
  Mapping(name: "Großkrotzenburg", latlng: LatLng(50.0826406, 8.9837384)),
  Mapping(
      name: "Großropperhausen, Frielendorf",
      latlng: LatLng(50.9397459, 9.3687254)),
  Mapping(
      name: "Großseelheim, Kirchhain", latlng: LatLng(50.8173479, 8.8624581)),
  Mapping(
      name: "Grube Messel[10], Messel",
      latlng: LatLng(49.917882500000005, 8.758666171638428)),
  Mapping(name: "Gruben, Burghaun", latlng: LatLng(50.6951837, 9.7506275)),
  Mapping(name: "Grünberg", latlng: LatLng(50.5913238, 8.9603407)),
  Mapping(name: "Grünberg", latlng: LatLng(50.5913238, 8.9603407)),
  Mapping(
      name: "Grund-Schwalheim, Echzell", latlng: LatLng(50.4133238, 8.9027663)),
  Mapping(name: "Gründau", latlng: LatLng(50.2212637, 9.1234581)),
  Mapping(
      name: "Grüningen, Pohlheim",
      latlng: LatLng(50.50890905, 8.726831995044446)),
  Mapping(
      name: "Grüsen, Gemünden (Wohra)", latlng: LatLng(51.0016331, 8.9511323)),
  Mapping(name: "Grüsen, Gemünden", latlng: LatLng(51.0016331, 8.9511323)),
  Mapping(name: "Grüsselbach, Rasdorf", latlng: LatLng(50.7404874, 9.9213282)),
  Mapping(name: "Gudensberg", latlng: LatLng(51.1762806, 9.3674039)),
  Mapping(name: "Gudensberg", latlng: LatLng(51.1762806, 9.3674039)),
  Mapping(name: "Gumpen", latlng: LatLng(49.8687722, 12.2344182)),
  Mapping(
      name: "Gumpersberg, Bad König", latlng: LatLng(49.7708648, 8.9311861)),
  Mapping(
      name: "Gundernhausen, Roßdorf", latlng: LatLng(49.8703684, 8.7884335)),
  Mapping(name: "Gundhelm, Schlüchtern", latlng: LatLng(50.3652585, 9.6329753)),
  Mapping(
      name: "Gungelshausen, Willingshausen",
      latlng: LatLng(50.8659436, 9.230764)),
  Mapping(name: "Günsterode, Melsungen", latlng: LatLng(51.1694243, 9.6603777)),
  Mapping(
      name: "Günterfürst[7], Erbach", latlng: LatLng(49.6359004, 8.9787709)),
  Mapping(
      name: "Günterod, Bad Endbach",
      latlng: LatLng(50.734999900000005, 8.466069624667503)),
  Mapping(name: "Guntersdorf, Herborn", latlng: LatLng(50.6502507, 8.2445235)),
  Mapping(
      name: "Guntershausen, Baunatal", latlng: LatLng(51.2334047, 9.4638818)),
  Mapping(
      name: "Günthers, Tann (Rhön)",
      latlng: LatLng(50.6567081, 9.994350333529749)),
  Mapping(name: "Günthers, Tann", latlng: LatLng(50.6587919, 9.9929565)),
  Mapping(
      name: "Gunzenau, Freiensteinau", latlng: LatLng(50.4605291, 9.4044512)),
  Mapping(
      name: "Gustavsburg, Ginsheim-Gustavsburg",
      latlng: LatLng(49.9794903, 8.3317364)),
  Mapping(
      name: "Gusternhain, Breitscheid",
      latlng: LatLng(50.66282565, 8.179956050479845)),
  Mapping(
      name: "Gutleutviertel, Frankfurt am Main",
      latlng: LatLng(50.1017076, 8.6605407)),
  Mapping(
      name: "Gutsbezirk Kaufunger Wald,, Werra-Meißner-Kreis",
      latlng: LatLng(51.2820185, 9.7383135)),
  Mapping(
      name: "Gutsbezirk Reinhardswald,, Landkreis Kassel",
      latlng: LatLng(51.4951377, 9.5395632)),
  Mapping(
      name: "Gutsbezirk Spessart,, Main-Kinzig-Kreis",
      latlng: LatLng(50.2585514, 9.4586921)),
  Mapping(
      name: "Güttersbach, Mossautal", latlng: LatLng(49.6149297, 8.9118313)),
  Mapping(name: "Guxhagen", latlng: LatLng(51.2016986, 9.4975082)),
  Mapping(name: "Guxhagen", latlng: LatLng(51.2016986, 9.4975082)),
  Mapping(
      name: "Haarhausen, Borken (Hessen)",
      latlng: LatLng(51.0133412, 9.2618034)),
  Mapping(name: "Haarhausen, Borken", latlng: LatLng(51.0133412, 9.2618034)),
  Mapping(
      name: "Haarhausen, Homberg (Ohm)", latlng: LatLng(50.7395726, 8.9507852)),
  Mapping(name: "Haarhausen, Homberg", latlng: LatLng(50.7395726, 8.9507852)),
  Mapping(name: "Habel, Tann (Rhön)", latlng: LatLng(50.6354507, 9.9760436)),
  Mapping(name: "Habel, Tann", latlng: LatLng(50.6354507, 9.9760436)),
  Mapping(name: "Habichtswald", latlng: LatLng(51.3322189, 9.3254924)),
  Mapping(name: "Habitzheim, Otzberg", latlng: LatLng(49.8500055, 8.8806036)),
  Mapping(
      name: "Hachborn, Ebsdorfergrund", latlng: LatLng(50.7199014, 8.790693)),
  Mapping(name: "Hadamar", latlng: LatLng(50.4494908, 8.048833)),
  Mapping(name: "Hadamar", latlng: LatLng(50.4494908, 8.048833)),
  Mapping(name: "Haddamar, Fritzlar", latlng: LatLng(51.1597603, 9.2660877)),
  Mapping(
      name: "Haddamshausen, Marburg", latlng: LatLng(50.7792775, 8.7028587)),
  Mapping(
      name: "Haddenberg, Haina (Kloster)",
      latlng: LatLng(51.0249399, 9.0562801)),
  Mapping(name: "Haddenberg, Haina", latlng: LatLng(51.0249399, 9.0562801)),
  Mapping(name: "Hahn, Pfungstadt", latlng: LatLng(49.7952806, 8.5550467)),
  Mapping(name: "Hahn, Taunusstein", latlng: LatLng(50.1429055, 8.15977)),
  Mapping(
      name: "Hähnlein, Alsbach-Hähnlein",
      latlng: LatLng(49.7397789, 8.6064597)),
  Mapping(name: "Haiger", latlng: LatLng(50.7420214, 8.2039451)),
  Mapping(name: "Haiger", latlng: LatLng(50.7420214, 8.2039451)),
  Mapping(name: "Hailer, Gelnhausen", latlng: LatLng(50.1866112, 9.1568885)),
  Mapping(
      name: "Haimbach, Fulda", latlng: LatLng(50.5455848, 9.620134778907381)),
  Mapping(name: "Hain-Gründau, Gründau", latlng: LatLng(50.2441071, 9.1421988)),
  Mapping(name: "Haina (Kloster)", latlng: LatLng(51.040421, 8.990769)),
  Mapping(name: "Haina", latlng: LatLng(35.000074, 104.999927)),
  Mapping(
      name: "Hainbach, Gemünden (Felda)",
      latlng: LatLng(50.6700529, 9.0984266)),
  Mapping(name: "Hainbach, Gemünden", latlng: LatLng(50.6700529, 9.0984266)),
  Mapping(name: "Hainburg", latlng: LatLng(48.1466103, 16.9422459)),
  Mapping(name: "Hainchen, Limeshain", latlng: LatLng(50.2694822, 8.994836)),
  Mapping(
      name: "Haine, Allendorf (Eder)", latlng: LatLng(51.0387344, 8.7213762)),
  Mapping(name: "Haine, Allendorf", latlng: LatLng(51.0387344, 8.7213762)),
  Mapping(name: "Haingrund, Lützelbach", latlng: LatLng(49.7605856, 9.0969829)),
  Mapping(name: "Hainhausen, Rodgau", latlng: LatLng(50.0414749, 8.8771695)),
  Mapping(name: "Hainrode, Ludwigsau", latlng: LatLng(50.9664324, 9.5757712)),
  Mapping(name: "Hainstadt, Breuberg", latlng: LatLng(49.8353104, 9.0434401)),
  Mapping(name: "Hainstadt, Hainburg", latlng: LatLng(50.0772179, 8.937813)),
  Mapping(
      name: "Haintchen, Selters (Taunus)",
      latlng: LatLng(50.3595984, 8.3174721)),
  Mapping(name: "Haintchen, Selters", latlng: LatLng(50.3595984, 8.3174721)),
  Mapping(name: "Hainzell, Hosenfeld", latlng: LatLng(50.5404325, 9.4931859)),
  Mapping(name: "Haisterbach, Erbach", latlng: LatLng(49.6273289, 8.9768847)),
  Mapping(name: "Haitz, Gelnhausen", latlng: LatLng(50.2117009, 9.2236614)),
  Mapping(name: "Haldorf, Edermünde", latlng: LatLng(51.2025368, 9.4340529)),
  Mapping(
      name: "Halgehausen, Haina (Kloster)",
      latlng: LatLng(51.0281924, 8.9396241)),
  Mapping(name: "Halgehausen, Haina", latlng: LatLng(51.0281924, 8.9396241)),
  Mapping(
      name: "Hallgarten (Rheingau), Oestrich-Winkel",
      latlng: LatLng(50.0284182, 8.0326446)),
  Mapping(
      name: "Hallgarten, Oestrich-Winkel",
      latlng: LatLng(50.0284182, 8.0326446)),
  Mapping(name: "Halsdorf, Wohratal", latlng: LatLng(50.9144709, 8.9472119)),
  Mapping(name: "Hambach, Taunusstein", latlng: LatLng(50.1926255, 8.1801901)),
  Mapping(
      name: "Hammelbach, Grasellenbach",
      latlng: LatLng(49.63753455, 8.827139404868785)),
  Mapping(name: "Hammersbach", latlng: LatLng(50.2302967, 8.9970268)),
  Mapping(
      name: "Hanau-Innenstadt, Hanau", latlng: LatLng(50.1259865, 8.9439205)),
  Mapping(name: "Hanau-Lamboy, Hanau", latlng: LatLng(50.1405855, 8.94798)),
  Mapping(name: "Hanau-Nordwest, Hanau", latlng: LatLng(50.1438646, 8.8831684)),
  Mapping(name: "Hanau-Südost, Hanau", latlng: LatLng(50.1210733, 8.9292147)),
  Mapping(name: "Hanau", latlng: LatLng(50.132881, 8.9169797)),
  Mapping(name: "Hanau", latlng: LatLng(50.132881, 8.9169797)),
  Mapping(
      name: "Hangenmeilingen, Elbtal", latlng: LatLng(50.4930194, 8.0695512)),
  Mapping(name: "Harb, Nidda", latlng: LatLng(50.4336175, 8.9876609)),
  Mapping(
      name: "Harbach, Grünberg",
      latlng: LatLng(50.57753515, 8.880606271707915)),
  Mapping(name: "Harbshausen, Vöhl", latlng: LatLng(51.1869125, 8.9183797)),
  Mapping(
      name: "Harheim, Frankfurt am Main", latlng: LatLng(50.182287, 8.6929716)),
  Mapping(name: "Harle, Wabern", latlng: LatLng(51.0994746, 9.3856518)),
  Mapping(name: "Harleshausen, Kassel", latlng: LatLng(51.33537, 9.440355)),
  Mapping(
      name: "Harmerz, Fulda", latlng: LatLng(50.51169855, 9.647624183171615)),
  Mapping(
      name: "Harmuthsachsen, Waldkappel",
      latlng: LatLng(51.1607881, 9.8576665)),
  Mapping(
      name: "Harnrode, Philippsthal", latlng: LatLng(50.8596768, 9.9713253)),
  Mapping(
      name: "Harpertshausen, Babenhausen",
      latlng: LatLng(49.9263333, 8.9158102)),
  Mapping(
      name: "Harreshausen, Babenhausen", latlng: LatLng(49.9702495, 8.9828677)),
  Mapping(
      name: "Hartenrod, Bad Endbach",
      latlng: LatLng(50.754361599999996, 8.457385392324888)),
  Mapping(
      name: "Hartenrod, Wald-Michelbach",
      latlng: LatLng(49.5849616, 8.8340106)),
  Mapping(
      name: "Hartershausen, Schlitz", latlng: LatLng(50.6338901, 9.5831595)),
  Mapping(
      name: "Hartmannshain, Grebenhain", latlng: LatLng(50.4713654, 9.2757643)),
  Mapping(name: "Haselstein, Nüsttal", latlng: LatLng(50.6805757, 9.853878)),
  Mapping(
      name: "Hasselbach, Waldkappel", latlng: LatLng(51.1675027, 9.8298773)),
  Mapping(name: "Hasselbach, Weilburg", latlng: LatLng(50.4836845, 8.2050374)),
  Mapping(
      name: "Hasselbach, Weilrod",
      latlng: LatLng(50.3417307, 8.342227553103852)),
  Mapping(name: "Hasselborn, Waldsolms", latlng: LatLng(50.4076592, 8.4898567)),
  Mapping(name: "Hasselroth", latlng: LatLng(50.1591912, 9.0988968)),
  Mapping(
      name: "Hassenhausen, Fronhausen",
      latlng: LatLng(50.7030962, 8.74646551956862)),
  Mapping(
      name: "Hassenroth, Höchst i. Odw.",
      latlng: LatLng(49.7903724, 8.9343349)),
  Mapping(
      name: "Haßloch, Rüsselsheim am Main",
      latlng: LatLng(49.9847776, 8.4563942)),
  Mapping(
      name: "Hattenbach, Niederaula", latlng: LatLng(50.8049472, 9.5597176)),
  Mapping(name: "Hattendorf, Alsfeld", latlng: LatLng(50.793188, 9.3089222)),
  Mapping(
      name: "Hattenheim, Eltville am Rhein",
      latlng: LatLng(50.0150007, 8.056326)),
  Mapping(name: "Hattenhof, Neuhof", latlng: LatLng(50.467645, 9.6755591)),
  Mapping(
      name: "Hattenrod, Reiskirchen",
      latlng: LatLng(50.57212345, 8.854626826851733)),
  Mapping(
      name: "Hatterode, Breitenbach am Herzberg",
      latlng: LatLng(50.7566613, 9.5027521)),
  Mapping(name: "Hattersheim am Main", latlng: LatLng(50.0723339, 8.4858331)),
  Mapping(
      name: "Hattersheim, Hattersheim am Main",
      latlng: LatLng(50.068234149999995, 8.48929883247623)),
  Mapping(
      name: "Hatzbach, Stadtallendorf", latlng: LatLng(50.8759761, 9.0146245)),
  Mapping(name: "Hatzfeld (Eder)", latlng: LatLng(50.9847904, 8.5630273)),
  Mapping(name: "Hatzfeld", latlng: LatLng(45.7917331, 20.7183733)),
  Mapping(
      name: "Haubern, Frankenberg (Eder)",
      latlng: LatLng(51.051931, 8.8993419)),
  Mapping(name: "Haubern, Frankenberg", latlng: LatLng(51.051931, 8.8993419)),
  Mapping(name: "Haueda, Liebenau", latlng: LatLng(51.4898683, 9.248739)),
  Mapping(name: "Hauneck", latlng: LatLng(50.8216109, 9.7282255)),
  Mapping(
      name: "Haunedorf, Petersberg",
      latlng: LatLng(50.5789238, 9.744277290607123)),
  Mapping(name: "Haunetal", latlng: LatLng(50.7588341, 9.6672876)),
  Mapping(
      name: "Hauptschwenda, Neukirchen", latlng: LatLng(50.8922169, 9.4054868)),
  Mapping(
      name: "Hausen über Aar, Aarbergen", latlng: LatLng(50.251782, 8.0599357)),
  Mapping(
      name: "Hausen vor der Höhe, Schlangenbad",
      latlng: LatLng(50.0830269, 8.0445432)),
  Mapping(
      name: "Hausen-Arnsbach, Neu-Anspach",
      latlng: LatLng(50.3083503, 8.5055738)),
  Mapping(
      name: "Hausen-Oes, Butzbach",
      latlng: LatLng(50.4238937, 8.61227445909146)),
  Mapping(
      name: "Hausen, Bad Soden-Salmünster",
      latlng: LatLng(50.2725788, 9.3791412)),
  Mapping(
      name: "Hausen, Frankfurt am Main", latlng: LatLng(50.1320084, 8.6243618)),
  Mapping(
      name: "Hausen, Hessisch Lichtenau",
      latlng: LatLng(51.2054149, 9.8288936)),
  Mapping(name: "Hausen, Knüllwald", latlng: LatLng(50.9937947, 9.5649356)),
  Mapping(name: "Hausen, Oberaula", latlng: LatLng(50.8457401, 9.4544683)),
  Mapping(name: "Hausen, Obertshausen", latlng: LatLng(50.0778222, 8.8671673)),
  Mapping(
      name: "Hausen, Pohlheim", latlng: LatLng(50.54938625, 8.74444877112132)),
  Mapping(name: "Hausen, Waldbrunn", latlng: LatLng(50.5242939, 8.0946775)),
  Mapping(name: "Hauserberg, Wetzlar", latlng: LatLng(50.5575565, 8.5116322)),
  Mapping(name: "Hauswurz, Neuhof", latlng: LatLng(50.4631079, 9.4763499)),
  Mapping(name: "Hebel, Wabern", latlng: LatLng(51.0683273, 9.3801605)),
  Mapping(
      name: "Hebenshausen, Neu-Eichenberg",
      latlng: LatLng(51.3896965, 9.9135752)),
  Mapping(name: "Heblos, Lauterbach", latlng: LatLng(50.6449974, 9.3605824)),
  Mapping(name: "Hebstahl, Oberzent", latlng: LatLng(49.5118116, 9.0103964)),
  Mapping(
      name: "Hechelmannskirchen, Burghaun",
      latlng: LatLng(50.7081421, 9.6412006)),
  Mapping(
      name: "Heckershausen, Ahnatal", latlng: LatLng(51.3663756, 9.4268899)),
  Mapping(
      name: "Heckholzhausen, Beselich", latlng: LatLng(50.4864358, 8.1580506)),
  Mapping(
      name: "Heddernheim, Frankfurt am Main",
      latlng: LatLng(50.159627, 8.6466155)),
  Mapping(
      name: "Heddersdorf, Kirchheim", latlng: LatLng(50.8518535, 9.5538226)),
  Mapping(name: "Heegheim, Altenstadt", latlng: LatLng(50.3075175, 8.9736586)),
  Mapping(name: "Heenes, Bad Hersfeld", latlng: LatLng(50.8922688, 9.6764744)),
  Mapping(
      name: "Heftrich, Idstein",
      latlng: LatLng(50.21466035, 8.336059017079949)),
  Mapping(name: "Heidelbach, Alsfeld", latlng: LatLng(50.8061764, 9.2580039)),
  Mapping(name: "Heidenrod", latlng: LatLng(50.1672054, 7.9678518)),
  Mapping(
      name: "Heiligenborn, Driedorf",
      latlng: LatLng(50.641992849999994, 8.213367983996632)),
  Mapping(
      name: "Heiligenrode, Niestetal", latlng: LatLng(51.3071052, 9.5804799)),
  Mapping(name: "Heilsberg, Bad Vilbel", latlng: LatLng(50.1701102, 8.7215322)),
  Mapping(
      name: "Heimarshausen, Naumburg", latlng: LatLng(51.181506, 9.2085747)),
  Mapping(
      name: "Heimbach, Bad Schwalbach", latlng: LatLng(50.1545889, 8.0450667)),
  Mapping(name: "Heimbach, Gilserberg", latlng: LatLng(50.9320274, 9.0066384)),
  Mapping(
      name: "Heimboldshausen, Philippsthal",
      latlng: LatLng(50.8530472, 9.9533102)),
  Mapping(
      name: "Heimertshausen, Kirtorf", latlng: LatLng(50.7413637, 9.1596511)),
  Mapping(name: "Heina, Morschen", latlng: LatLng(51.0797883, 9.5927044)),
  Mapping(name: "Heinebach, Alheim", latlng: LatLng(51.0501797, 9.6668813)),
  Mapping(
      name: "Heinzenberg, Grävenwiesbach",
      latlng: LatLng(50.3870541, 8.399714566265871)),
  Mapping(name: "Heisebeck, Wesertal", latlng: LatLng(51.5853733, 9.6561501)),
  Mapping(
      name: "Heisterberg, Driedorf",
      latlng: LatLng(50.65823535, 8.153876121134797)),
  Mapping(name: "Heisters, Grebenhain", latlng: LatLng(50.5130908, 9.4152924)),
  Mapping(name: "Heldenbergen, Nidderau", latlng: LatLng(50.237709, 8.8673819)),
  Mapping(name: "Heldra, Wanfried", latlng: LatLng(51.1285586, 10.1977179)),
  Mapping(
      name: "Helen Keller Lauterbach", latlng: LatLng(50.6346622, 9.4116058)),
  Mapping(
      name: "Helen Keller Strasse Lauterbach",
      latlng: LatLng(50.6346622, 9.4116058)),
  Mapping(name: "Helfersdorf, Kefenrod", latlng: LatLng(50.3390792, 9.2557924)),
  Mapping(name: "Hellstein, Brachttal", latlng: LatLng(50.319537, 9.300266)),
  Mapping(
      name: "Helmarshausen, Bad Karlshafen",
      latlng: LatLng(51.6293899, 9.4592867)),
  Mapping(
      name: "Helmighausen, Diemelstadt", latlng: LatLng(51.4723768, 8.9267807)),
  Mapping(name: "Helmscheid, Korbach", latlng: LatLng(51.3232506, 8.8721468)),
  Mapping(name: "Helmshausen, Felsberg", latlng: LatLng(51.0957683, 9.437356)),
  Mapping(
      name: "Helpershain, Ulrichstein", latlng: LatLng(50.6078537, 9.2274714)),
  Mapping(name: "Helsa", latlng: LatLng(51.2447892, 9.6727072)),
  Mapping(name: "Helsa", latlng: LatLng(51.2447892, 9.6727072)),
  Mapping(name: "Helsen, Bad Arolsen", latlng: LatLng(51.3814867, 8.9974383)),
  Mapping(name: "Hembach, Brombachtal", latlng: LatLng(49.7288324, 8.9239867)),
  Mapping(
      name: "Hemfurth-Edersee, Edertal", latlng: LatLng(51.1750086, 9.0546162)),
  Mapping(name: "Hemmen, Schlitz", latlng: LatLng(50.6208093, 9.6072041)),
  Mapping(
      name: "Hemmighausen, Willingen (Upland)",
      latlng: LatLng(51.3090538, 8.6997445)),
  Mapping(
      name: "Hemmighausen, Willingen", latlng: LatLng(51.3090538, 8.6997445)),
  Mapping(name: "Hennethal, Hohenstein", latlng: LatLng(50.2279762, 8.1198906)),
  Mapping(
      name: "Heppenheim (Bergstraße)", latlng: LatLng(49.6416143, 8.6333327)),
  Mapping(name: "Heppenheim", latlng: LatLng(49.6408048, 8.6372164)),
  Mapping(
      name: "Herbelhausen, Gemünden (Wohra)",
      latlng: LatLng(51.0037689, 8.9774139)),
  Mapping(
      name: "Herbelhausen, Gemünden", latlng: LatLng(51.0037689, 8.9774139)),
  Mapping(
      name: "Herborn (Kernstadt), Herborn",
      latlng: LatLng(50.6845372, 8.3080615)),
  Mapping(name: "Herborn", latlng: LatLng(50.6832181, 8.3031361)),
  Mapping(name: "Herborn", latlng: LatLng(50.6832181, 8.3031361)),
  Mapping(name: "Herbsen, Volkmarsen", latlng: LatLng(51.4301248, 9.0561121)),
  Mapping(name: "Herbstein", latlng: LatLng(50.5608868, 9.3804574)),
  Mapping(name: "Herbstein", latlng: LatLng(50.5608868, 9.3804574)),
  Mapping(name: "Herchenhain, Grebenhain", latlng: LatLng(50.479625, 9.268563)),
  Mapping(name: "Herchenrode, Modautal", latlng: LatLng(49.7607157, 8.7383302)),
  Mapping(name: "Herfa, Heringen", latlng: LatLng(50.888048, 9.919699)),
  Mapping(
      name: "Hergersdorf, Schwalmtal", latlng: LatLng(50.6886009, 9.3211142)),
  Mapping(name: "Hergershausen, Alheim", latlng: LatLng(51.0288379, 9.6970036)),
  Mapping(
      name: "Hergershausen, Babenhausen",
      latlng: LatLng(49.9391411, 8.9125488)),
  Mapping(
      name: "Hergetsfeld, Knüllwald", latlng: LatLng(50.9370933, 9.4552659)),
  Mapping(name: "Hering, Otzberg", latlng: LatLng(49.8197584, 8.9140663)),
  Mapping(name: "Heringen (Werra)", latlng: LatLng(50.8868593, 9.9746798)),
  Mapping(name: "Heringen, Hünfelden", latlng: LatLng(50.3171195, 8.1120011)),
  Mapping(name: "Heringen", latlng: LatLng(48.7752261, 7.169946)),
  Mapping(
      name: "Heringhausen, Diemelsee",
      latlng: LatLng(51.364109400000004, 8.72248783898634)),
  Mapping(
      name: "Herlefeld, Spangenberg",
      latlng: LatLng(51.0840687, 9.743022985892816)),
  Mapping(name: "Herleshausen", latlng: LatLng(51.0327326, 10.1143597)),
  Mapping(name: "Herleshausen", latlng: LatLng(51.0327326, 10.1143597)),
  Mapping(
      name: "Hermannrode, Neu-Eichenberg",
      latlng: LatLng(51.4043634, 9.8614216)),
  Mapping(
      name: "Hermannspiegel, Haunetal", latlng: LatLng(50.8058558, 9.7312616)),
  Mapping(
      name: "Hermannstein, Wetzlar",
      latlng: LatLng(50.598538149999996, 8.494104754718585)),
  Mapping(name: "Hermershausen, Marburg", latlng: LatLng(50.787468, 8.6874748)),
  Mapping(name: "Herolz, Schlüchtern", latlng: LatLng(50.3474055, 9.5561508)),
  Mapping(name: "Herrnhaag, Büdingen", latlng: LatLng(50.2639522, 9.0825907)),
  Mapping(
      name: "Hertingshausen, Baunatal", latlng: LatLng(51.2300156, 9.4193381)),
  Mapping(
      name: "Hertingshausen, Wohratal", latlng: LatLng(50.9628286, 8.9279989)),
  Mapping(
      name: "Herzhausen, Dautphetal", latlng: LatLng(50.8244767, 8.5578583)),
  Mapping(name: "Herzhausen, Vöhl", latlng: LatLng(51.1844621, 8.894917)),
  Mapping(
      name: "Heskem, Ebsdorfergrund", latlng: LatLng(50.7470068, 8.8313984)),
  Mapping(
      name: "Hesperinghausen, Diemelstadt",
      latlng: LatLng(51.4748249, 8.9058477)),
  Mapping(name: "Hesselbach, Oberzent", latlng: LatLng(49.5751431, 9.0880673)),
  Mapping(
      name: "Hesseldorf, Wächtersbach", latlng: LatLng(50.2741043, 9.3060141)),
  Mapping(name: "Hessenaue, Trebur", latlng: LatLng(49.8910913, 8.3703085)),
  Mapping(name: "Hesserode, Felsberg", latlng: LatLng(51.0922475, 9.427043)),
  Mapping(name: "Hessisch Lichtenau", latlng: LatLng(51.1927404, 9.7517183)),
  Mapping(name: "Hessisch Lichtenau", latlng: LatLng(51.1927404, 9.7517183)),
  Mapping(
      name: "Hessisch Radmühl (Radmühl I), Freiensteinau",
      latlng: LatLng(50.4089963, 9.3687183)),
  Mapping(
      name: "Hessisch Radmühl, Freiensteinau",
      latlng: LatLng(50.4089963, 9.3687183)),
  Mapping(name: "Heßlar, Felsberg", latlng: LatLng(51.133588, 9.4829025)),
  Mapping(name: "Heßloch, Wiesbaden", latlng: LatLng(50.1107062, 8.2962551)),
  Mapping(
      name: "Hetschbach i. Odw., Höchst i. Odw.",
      latlng: LatLng(49.8104171, 8.9820969)),
  Mapping(
      name: "Hettenhain, Bad Schwalbach",
      latlng: LatLng(50.1330506, 8.0885257)),
  Mapping(
      name: "Hettenhausen, Gersfeld (Rhön)",
      latlng: LatLng(50.4516974, 9.823289204377188)),
  Mapping(
      name: "Hettenhausen, Gersfeld",
      latlng: LatLng(50.4516974, 9.823289204377188)),
  Mapping(name: "Hettersroth, Birstein", latlng: LatLng(50.3452296, 9.2729678)),
  Mapping(name: "Hetzbach, Oberzent", latlng: LatLng(49.593438, 8.9882099)),
  Mapping(name: "Hetzerode, Waldkappel", latlng: LatLng(51.1334943, 9.8096437)),
  Mapping(name: "Heubach, Groß-Umstadt", latlng: LatLng(49.8406683, 8.9657861)),
  Mapping(name: "Heubach, Kalbach", latlng: LatLng(50.3841503, 9.7194781)),
  Mapping(name: "Heuchelheim, Elbtal", latlng: LatLng(50.4943744, 8.0564817)),
  Mapping(
      name: "Heuchelheim, Reichelsheim", latlng: LatLng(50.3674478, 8.8667269)),
  Mapping(name: "Heuchelheim", latlng: LatLng(50.5825291, 8.6305978)),
  Mapping(name: "Heusenstamm", latlng: LatLng(50.0537652, 8.8236013)),
  Mapping(name: "Heusenstamm", latlng: LatLng(50.0537652, 8.8236013)),
  Mapping(
      name: "Hexenberg, Dietzenbach", latlng: LatLng(49.9942616, 8.7666154)),
  Mapping(name: "Heyerode, Sontra", latlng: LatLng(51.0717265, 9.8729071)),
  Mapping(name: "Hilders", latlng: LatLng(50.5554204, 9.9754786)),
  Mapping(name: "Hilders", latlng: LatLng(50.5554204, 9.9754786)),
  Mapping(name: "Hilgenroth, Heidenrod", latlng: LatLng(50.137389, 7.9390551)),
  Mapping(
      name: "Hilgershausen, Bad Sooden-Allendorf",
      latlng: LatLng(51.2717551, 9.8915968)),
  Mapping(
      name: "Hilgershausen, Felsberg", latlng: LatLng(51.1036372, 9.4712437)),
  Mapping(
      name: "Hillartshausen, Friedewald",
      latlng: LatLng(50.8559793, 9.8896119)),
  Mapping(
      name: "Hillershausen, Korbach", latlng: LatLng(51.2207588, 8.7495134)),
  Mapping(
      name: "Hilmes, Schenklengsfeld", latlng: LatLng(50.8378587, 9.8633031)),
  Mapping(
      name: "Hilperhausen, Niederaula", latlng: LatLng(50.8031241, 9.6813894)),
  Mapping(
      name: "Hiltersklingen, Mossautal", latlng: LatLng(49.639364, 8.8997923)),
  Mapping(name: "Himbach, Limeshain", latlng: LatLng(50.2599793, 9.0026952)),
  Mapping(
      name: "Himmelsberg, Kirchhain", latlng: LatLng(50.8587058, 8.9158462)),
  Mapping(name: "Hinterbach, Oberzent", latlng: LatLng(49.5466244, 8.9020304)),
  Mapping(
      name: "Hintermeilingen, Waldbrunn",
      latlng: LatLng(50.4960484, 8.1138499)),
  Mapping(
      name: "Hintersteinau, Steinau an der Straße",
      latlng: LatLng(50.4157626, 9.4666472)),
  Mapping(
      name: "Hirschberg, Herborn",
      latlng: LatLng(50.64485865, 8.268342943379148)),
  Mapping(
      name: "Hirschhagen [12], Hessisch Lichtenau",
      latlng: LatLng(51.2257525, 9.6965877)),
  Mapping(
      name: "Hirschhausen, Weilburg",
      latlng: LatLng(50.49776705, 8.340537934370792)),
  Mapping(name: "Hirschhorn (Neckar)", latlng: LatLng(49.4481382, 8.8973938)),
  Mapping(name: "Hirschhorn", latlng: LatLng(49.4481382, 8.8973938)),
  Mapping(name: "Hirzbach, Hammersbach", latlng: LatLng(50.2197353, 8.9647358)),
  Mapping(
      name: "Hirzenhain, Eschenburg",
      latlng: LatLng(50.79191695, 8.390636757943842)),
  Mapping(name: "Hirzenhain", latlng: LatLng(50.3992585, 9.1257763)),
  Mapping(name: "Hirzenhain", latlng: LatLng(50.3992585, 9.1257763)),
  Mapping(name: "Hitzelrode, Meinhard", latlng: LatLng(51.241076, 10.0558664)),
  Mapping(name: "Hitzerode, Berkatal", latlng: LatLng(51.2397193, 9.9582559)),
  Mapping(name: "Hitzkirchen, Kefenrod", latlng: LatLng(50.3423252, 9.2531493)),
  Mapping(name: "Hoch-Weisel, Butzbach", latlng: LatLng(50.4029544, 8.63934)),
  Mapping(name: "Hochheim am Main", latlng: LatLng(50.0145517, 8.3514488)),
  Mapping(name: "Hochheim am Main", latlng: LatLng(50.0145517, 8.3514488)),
  Mapping(
      name: "Höchst an der Nidder, Altenstadt",
      latlng: LatLng(50.2698123, 8.9276378)),
  Mapping(name: "Höchst i. Odw.", latlng: LatLng(49.7891138, 8.9789625)),
  Mapping(
      name: "Höchst im Odw., Höchst i. Odw.",
      latlng: LatLng(49.801331, 8.9936445)),
  Mapping(
      name: "Höchst, Frankfurt am Main", latlng: LatLng(50.0995118, 8.5452956)),
  Mapping(name: "Höchst, Gelnhausen", latlng: LatLng(50.2046172, 9.2349882)),
  Mapping(name: "Hochstadt, Maintal", latlng: LatLng(50.1531515, 8.8329541)),
  Mapping(name: "Hochstädten, Bensheim", latlng: LatLng(49.7122922, 8.6499273)),
  Mapping(name: "Höckersdorf, Mücke", latlng: LatLng(50.5917632, 9.1070637)),
  Mapping(
      name: "Hof Eich, Linsengericht", latlng: LatLng(50.1667843, 9.2094842)),
  Mapping(name: "Hof Lauterbach, Vöhl", latlng: LatLng(51.2307752, 8.9288027)),
  Mapping(
      name: "Höf und Haid, Flieden",
      latlng: LatLng(50.401621399999996, 9.533080242328946)),
  Mapping(
      name: "Hofaschenbach, Nüsttal", latlng: LatLng(50.6356528, 9.8453241)),
  Mapping(name: "Hofbieber", latlng: LatLng(50.5932038, 9.8708724)),
  Mapping(name: "Hofbieber", latlng: LatLng(50.5932038, 9.8708724)),
  Mapping(name: "Hofen, Runkel", latlng: LatLng(50.4246324, 8.1586095)),
  Mapping(name: "Hofgeismar", latlng: LatLng(51.4956238, 9.3793181)),
  Mapping(name: "Hofgeismar", latlng: LatLng(51.4956238, 9.3793181)),
  Mapping(name: "Hofheim am Taunus", latlng: LatLng(50.086546, 8.447324)),
  Mapping(name: "Hofheim am Taunus", latlng: LatLng(50.086546, 8.447324)),
  Mapping(name: "Hofheim, Lampertheim", latlng: LatLng(49.6576505, 8.4081236)),
  Mapping(
      name: "Hohe Luft, Bad Hersfeld", latlng: LatLng(50.8601935, 9.7319961)),
  Mapping(name: "Hohenahr", latlng: LatLng(50.6775158, 8.5255965)),
  Mapping(name: "Hohenborn, Zierenberg", latlng: LatLng(51.4203593, 9.2795184)),
  Mapping(name: "Hoheneiche, Wehretal", latlng: LatLng(51.1291821, 9.9716895)),
  Mapping(name: "Hohenkirchen, Espenau", latlng: LatLng(51.3970561, 9.4734634)),
  Mapping(name: "Hohenroda", latlng: LatLng(50.8146932, 9.929429)),
  Mapping(
      name: "Hohenroth, Driedorf",
      latlng: LatLng(50.6425098, 8.140759057053366)),
  Mapping(
      name: "Hohensolms, Hohenahr",
      latlng: LatLng(50.6450164, 8.507472937632407)),
  Mapping(name: "Hohenstein", latlng: LatLng(53.5834201, 20.2816198)),
  Mapping(
      name: "Hohenzell, Schlüchtern", latlng: LatLng(50.3214305, 9.5363375)),
  Mapping(
      name: "Höingen, Homberg (Ohm)", latlng: LatLng(50.7193368, 8.9201979)),
  Mapping(name: "Höingen, Homberg", latlng: LatLng(50.7193368, 8.9201979)),
  Mapping(name: "Höllerbach, Brensbach", latlng: LatLng(49.778926, 8.9020854)),
  Mapping(
      name: "Hollstein, Hessisch Lichtenau",
      latlng: LatLng(51.1814786, 9.7889551)),
  Mapping(
      name: "Holzburg, Schrecksbach", latlng: LatLng(50.8268857, 9.2544233)),
  Mapping(
      name: "Holzhausen über Aar, Hohenstein",
      latlng: LatLng(50.2095701, 8.0882285)),
  Mapping(
      name: "Holzhausen, Dautphetal", latlng: LatLng(50.8142202, 8.5255273)),
  Mapping(name: "Holzhausen, Edermünde", latlng: LatLng(51.2158937, 9.4219999)),
  Mapping(
      name: "Holzhausen, Fronhausen", latlng: LatLng(50.7164516, 8.6893872)),
  Mapping(
      name: "Holzhausen, Greifenstein",
      latlng: LatLng(50.5954322, 8.28822633190509)),
  Mapping(
      name: "Holzhausen, Hatzfeld (Eder)",
      latlng: LatLng(50.9885334, 8.6003611)),
  Mapping(name: "Holzhausen, Hatzfeld", latlng: LatLng(50.9885334, 8.6003611)),
  Mapping(
      name: "Holzhausen, Herleshausen", latlng: LatLng(51.0412977, 10.0889635)),
  Mapping(
      name: "Holzhausen, Homberg (Efze)",
      latlng: LatLng(51.0256899, 9.4244335)),
  Mapping(name: "Holzhausen, Homberg", latlng: LatLng(51.0256899, 9.4244335)),
  Mapping(
      name: "Holzhausen, Immenhausen", latlng: LatLng(51.4231695, 9.538374)),
  Mapping(name: "Holzheim, Haunetal", latlng: LatLng(50.7824639, 9.6708972)),
  Mapping(
      name: "Holzheim, Pohlheim", latlng: LatLng(50.488161, 8.715932126935591)),
  Mapping(
      name: "Holzmühl, Freiensteinau", latlng: LatLng(50.4137946, 9.4196756)),
  Mapping(name: "Homberg (Efze)", latlng: LatLng(51.0333517, 9.4000153)),
  Mapping(name: "Homberg (Ohm)", latlng: LatLng(50.7274933, 8.997847)),
  Mapping(name: "Homberg", latlng: LatLng(50.6407001, 8.1058112)),
  Mapping(
      name: "Hombergshausen, Homberg (Efze)",
      latlng: LatLng(51.0704239, 9.4394058)),
  Mapping(
      name: "Hombergshausen, Homberg", latlng: LatLng(51.0704239, 9.4394058)),
  Mapping(
      name: "Hombressen, Hofgeismar", latlng: LatLng(51.4933471, 9.4564666)),
  Mapping(
      name: "Hommershausen, Frankenberg (Eder)",
      latlng: LatLng(51.098297, 8.7603495)),
  Mapping(
      name: "Hommershausen, Frankenberg", latlng: LatLng(51.098297, 8.7603495)),
  Mapping(
      name: "Hommertshausen, Dautphetal",
      latlng: LatLng(50.8466797, 8.5110997)),
  Mapping(name: "Hönebach, Wildeck", latlng: LatLng(50.9355497, 9.9395109)),
  Mapping(name: "Hoof, Schauenburg", latlng: LatLng(51.2838861, 9.350464)),
  Mapping(
      name: "Hopfelde, Hessisch Lichtenau",
      latlng: LatLng(51.1799884, 9.7655668)),
  Mapping(
      name: "Hopfgarten, Schwalmtal", latlng: LatLng(50.7033074, 9.2972016)),
  Mapping(
      name: "Hopfmannsfeld, Lautertal (Vogelsberg)",
      latlng: LatLng(50.5880731, 9.3131231)),
  Mapping(
      name: "Hopfmannsfeld, Lautertal", latlng: LatLng(50.5880731, 9.3131231)),
  Mapping(name: "Horbach, Freigericht", latlng: LatLng(50.1396126, 9.1627389)),
  Mapping(
      name: "Hörbach, Herborn", latlng: LatLng(50.66940765, 8.266893169655882)),
  Mapping(name: "Hörgenau", latlng: LatLng(50.587288, 9.2868749)),
  Mapping(name: "Höringhausen, Waldeck", latlng: LatLng(51.2734076, 8.9868794)),
  Mapping(name: "Hörle, Volkmarsen", latlng: LatLng(51.4431065, 9.0691148)),
  Mapping(
      name: "Hornau, Kelkheim (Taunus)", latlng: LatLng(50.1464438, 8.4499601)),
  Mapping(name: "Hornau, Kelkheim", latlng: LatLng(50.1464438, 8.4499601)),
  Mapping(name: "Hornbach, Birkenau", latlng: LatLng(49.568884, 8.728968)),
  Mapping(name: "Hornel, Sontra", latlng: LatLng(51.0564857, 9.9088042)),
  Mapping(
      name: "Horwieden [13], Petersberg",
      latlng: LatLng(50.5657611, 9.7450296)),
  Mapping(name: "Hosenfeld", latlng: LatLng(50.5119862, 9.4985532)),
  Mapping(name: "Hosenfeld", latlng: LatLng(50.5119862, 9.4985532)),
  Mapping(
      name: "Hottenbacher Hof, Fischbachtal",
      latlng: LatLng(49.7623114, 8.7824348)),
  Mapping(name: "Hoxhohl, Modautal", latlng: LatLng(49.7521047, 8.7203661)),
  Mapping(
      name: "Hubenrode, Witzenhausen", latlng: LatLng(51.3420681, 9.781509)),
  Mapping(name: "Hübenthal, Sontra", latlng: LatLng(51.0711005, 9.8949269)),
  Mapping(name: "Hübenthal, Witzenhausen", latlng: LatLng(51.39228, 9.824008)),
  Mapping(
      name: "Hüddingen, Bad Wildungen", latlng: LatLng(51.0955894, 9.0193075)),
  Mapping(name: "Hülsa, Homberg (Efze)", latlng: LatLng(50.9458909, 9.4596983)),
  Mapping(name: "Hülsa, Homberg", latlng: LatLng(50.9458909, 9.4596983)),
  Mapping(name: "Hülshof, Bad Endbach", latlng: LatLng(50.7786256, 8.4847535)),
  Mapping(name: "Hümme, Hofgeismar", latlng: LatLng(51.5447155, 9.4072983)),
  Mapping(
      name: "Hummetroth, Höchst i. Odw.",
      latlng: LatLng(49.7805018, 8.9378038)),
  Mapping(
      name: "Hundelshausen, Witzenhausen",
      latlng: LatLng(51.293286, 9.8490097)),
  Mapping(
      name: "Hundsbach, Tann (Rhön)", latlng: LatLng(50.6227925, 10.0412568)),
  Mapping(name: "Hundsbach, Tann", latlng: LatLng(50.6227925, 10.0412568)),
  Mapping(
      name: "Hundsdorf, Bad Wildungen", latlng: LatLng(51.0802688, 9.0397978)),
  Mapping(name: "Hundshausen, Jesberg", latlng: LatLng(50.9771268, 9.1394117)),
  Mapping(
      name: "Hundstadt, Grävenwiesbach",
      latlng: LatLng(50.36838155, 8.479615096588493)),
  Mapping(name: "Hünfeld", latlng: LatLng(50.65546, 9.7764627)),
  Mapping(name: "Hünfeld", latlng: LatLng(50.6730333, 9.7661233)),
  Mapping(name: "Hünfelden", latlng: LatLng(50.3315949, 8.1434075)),
  Mapping(name: "Hungen", latlng: LatLng(50.4696168, 8.9171014)),
  Mapping(name: "Hungen", latlng: LatLng(50.4696168, 8.9171014)),
  Mapping(name: "Hünhan, Burghaun", latlng: LatLng(50.6897373, 9.7338886)),
  Mapping(
      name: "Hunoldstal, Schmitten im Taunus",
      latlng: LatLng(50.300343600000005, 8.460877186119866)),
  Mapping(name: "Hünstetten", latlng: LatLng(50.2408568, 8.17665052993959)),
  Mapping(name: "Huppert, Heidenrod", latlng: LatLng(50.1907209, 8.0063466)),
  Mapping(name: "Hütte, Bad Endbach", latlng: LatLng(50.7567775, 8.5078857)),
  Mapping(
      name: "Hüttelngesäß, Freigericht", latlng: LatLng(50.0930454, 9.1472868)),
  Mapping(name: "Hüttenberg", latlng: LatLng(46.9397139, 14.5486137)),
  Mapping(name: "Hüttenberg", latlng: LatLng(46.9397139, 14.5486137)),
  Mapping(
      name: "Hüttenfeld, Lampertheim", latlng: LatLng(49.5979408, 8.5864676)),
  Mapping(name: "Hüttengesäß, Ronneburg", latlng: LatLng(50.2165801, 9.040196)),
  Mapping(
      name: "Hüttenrode, Haina (Kloster)",
      latlng: LatLng(51.0493491, 9.0354429)),
  Mapping(name: "Hüttenrode, Haina", latlng: LatLng(51.0493491, 9.0354429)),
  Mapping(name: "Hüttenthal, Mossautal", latlng: LatLng(49.6212358, 8.9360929)),
  Mapping(
      name: "Hutzdorf, Schlitz",
      latlng: LatLng(50.684059649999995, 9.585373768997929)),
  Mapping(name: "Hutzwiese", latlng: LatLng(49.7221382, 8.8860676)),
  Mapping(name: "Iba, Bebra", latlng: LatLng(50.9794816, 9.8730987)),
  Mapping(name: "Ibra, Oberaula", latlng: LatLng(50.8253863, 9.494385)),
  Mapping(name: "Idstein", latlng: LatLng(50.2212764, 8.269554)),
  Mapping(name: "Idstein", latlng: LatLng(50.2212764, 8.269554)),
  Mapping(
      name: "Igelhausen [15], Hirzenhain",
      latlng: LatLng(50.4061537, 9.1301725)),
  Mapping(name: "Igelsbach, Heppenheim", latlng: LatLng(49.6514108, 8.7263163)),
  Mapping(name: "Igelsbach", latlng: LatLng(49.1603158, 10.8506917)),
  Mapping(name: "Igstadt, Wiesbaden", latlng: LatLng(50.0818457, 8.3288912)),
  Mapping(
      name: "Ihringshausen, Fuldatal", latlng: LatLng(51.352229, 9.5264044)),
  Mapping(name: "Ilbenstadt, Niddatal", latlng: LatLng(50.2791329, 8.7994979)),
  Mapping(
      name: "Ilbeshausen-Hochwaldhausen, Grebenhain",
      latlng: LatLng(50.5199247, 9.3214956)),
  Mapping(name: "Illnhausen, Birstein", latlng: LatLng(50.4004988, 9.272131)),
  Mapping(
      name: "Ilschhausen, Ebsdorfergrund",
      latlng: LatLng(50.7014765, 8.7913786)),
  Mapping(name: "Ilsdorf, Mücke", latlng: LatLng(50.6113679, 9.0419717)),
  Mapping(name: "Immenhausen", latlng: LatLng(51.4276006, 9.4809136)),
  Mapping(name: "Immenhausen", latlng: LatLng(51.4276006, 9.4809136)),
  Mapping(name: "Immichenhain, Ottrau", latlng: LatLng(50.8106089, 9.3564496)),
  Mapping(
      name: "Immighausen, Lichtenfels (Hessen)",
      latlng: LatLng(51.208025, 8.8507256)),
  Mapping(
      name: "Immighausen, Lichtenfels", latlng: LatLng(51.208025, 8.8507256)),
  Mapping(name: "Imshausen, Bebra", latlng: LatLng(50.9968639, 9.8622043)),
  Mapping(
      name: "In der Mordach, Mühltal", latlng: LatLng(49.8071234, 8.686063)),
  Mapping(
      name: "Inheiden, Hungen", latlng: LatLng(50.4611336, 8.895419432526543)),
  Mapping(
      name: "Innenstadt, Frankfurt am Main",
      latlng: LatLng(50.1145581, 8.6835914)),
  Mapping(
      name: "Ippinghausen, Wolfhagen", latlng: LatLng(51.2814878, 9.1443911)),
  Mapping(
      name: "Istergiesel, Fulda",
      latlng: LatLng(50.5177844, 9.605915369274813)),
  Mapping(name: "Istha, Wolfhagen", latlng: LatLng(51.3044488, 9.2296168)),
  Mapping(name: "Itzenhain, Gilserberg", latlng: LatLng(50.9257113, 9.0645035)),
  Mapping(name: "Jesberg", latlng: LatLng(50.9891556, 9.1396842)),
  Mapping(name: "Jesberg", latlng: LatLng(50.9891556, 9.1396842)),
  Mapping(name: "Jestädt, Meinhard", latlng: LatLng(51.2145027, 10.0173908)),
  Mapping(
      name: "Johannesberg, Bad Hersfeld",
      latlng: LatLng(50.8469578, 9.7006217)),
  Mapping(
      name: "Johannesberg, Fulda",
      latlng: LatLng(50.524492550000005, 9.662778169223877)),
  Mapping(
      name: "Johannisberg, Geisenheim", latlng: LatLng(50.0031207, 7.9811854)),
  Mapping(name: "Josbach, Rauschenberg", latlng: LatLng(50.9134334, 8.9982344)),
  Mapping(name: "Jossa, Hosenfeld", latlng: LatLng(50.5007733, 9.4738023)),
  Mapping(name: "Jossa, Sinntal", latlng: LatLng(50.2383064, 9.5943784)),
  Mapping(name: "Jossgrund", latlng: LatLng(50.1607734, 9.4585777)),
  Mapping(
      name: "Jugenheim, Seeheim-Jugenheim",
      latlng: LatLng(49.7565223, 8.6353359)),
  Mapping(name: "Jügesheim, Rodgau", latlng: LatLng(50.0258503, 8.8841053)),
  Mapping(name: "Juhöhe, Mörlenbach", latlng: LatLng(49.6230252, 8.6963424)),
  Mapping(name: "Jungfernkopf, Kassel", latlng: LatLng(51.342357, 9.4560998)),
  Mapping(name: "Kaichen, Niddatal", latlng: LatLng(50.2543847, 8.8379818)),
  Mapping(name: "Kailbach, Oberzent", latlng: LatLng(49.535691, 9.0773091)),
  Mapping(
      name: "Kaiserlei, Offenbach am Main",
      latlng: LatLng(50.1081322, 8.734453490454925)),
  Mapping(name: "Kalbach", latlng: LatLng(50.4044073, 9.6968378)),
  Mapping(name: "Kallstadt, Birkenau", latlng: LatLng(49.5532224, 8.731954)),
  Mapping(
      name: "Kaltenbach, Spangenberg", latlng: LatLng(51.1339708, 9.6548297)),
  Mapping(
      name: "Kammerbach, Bad Sooden-Allendorf",
      latlng: LatLng(51.2671719, 9.9099921)),
  Mapping(
      name: "Kämmerzell, Fulda", latlng: LatLng(50.6092797, 9.648667589349426)),
  Mapping(name: "Karben", latlng: LatLng(50.2313417, 8.7717673)),
  Mapping(name: "Kassel, Biebergemünd", latlng: LatLng(50.2072683, 9.2791463)),
  Mapping(name: "Kassel", latlng: LatLng(51.3154546, 9.4924096)),
  Mapping(name: "Kassel", latlng: LatLng(51.3154546, 9.4924096)),
  Mapping(
      name: "Katholisch-Willenroth, Bad Soden-Salmünster",
      latlng: LatLng(50.3250099, 9.3514048)),
  Mapping(name: "Kathus, Bad Hersfeld", latlng: LatLng(50.8769063, 9.7672488)),
  Mapping(
      name: "Katzenbach, Biedenkopf", latlng: LatLng(50.8995199, 8.5723176)),
  Mapping(
      name: "Katzenfurt, Ehringshausen",
      latlng: LatLng(50.62547755, 8.350637693074116)),
  Mapping(name: "Kaufungen", latlng: LatLng(51.2817974, 9.6185407)),
  Mapping(name: "Kaulstoß, Schotten", latlng: LatLng(50.4698341, 9.2229673)),
  Mapping(name: "Kauppen, Neuhof", latlng: LatLng(50.4521973, 9.4875904)),
  Mapping(name: "Kefenrod", latlng: LatLng(50.34987, 9.20218)),
  Mapping(name: "Kefenrod", latlng: LatLng(50.34987, 9.20218)),
  Mapping(name: "Kehlnbach, Gladenbach", latlng: LatLng(50.7707574, 8.5642374)),
  Mapping(name: "Kehna, Weimar", latlng: LatLng(50.7435458, 8.6673201)),
  Mapping(
      name: "Kehrenbach, Melsungen",
      latlng: LatLng(51.1680979, 9.614258793126456)),
  Mapping(name: "Kelkheim (Taunus)", latlng: LatLng(50.1375695, 8.4519114)),
  Mapping(
      name: "Kelkheim-Mitte, Kelkheim (Taunus)",
      latlng: LatLng(50.1343112, 8.4532379)),
  Mapping(
      name: "Kelkheim-Mitte, Kelkheim", latlng: LatLng(50.1343112, 8.4532379)),
  Mapping(name: "Kelkheim", latlng: LatLng(50.1375695, 8.4519114)),
  Mapping(
      name: "Kelsterbach, Kelsterbach", latlng: LatLng(50.0623795, 8.5296121)),
  Mapping(name: "Kelsterbach", latlng: LatLng(50.065151, 8.5296632)),
  Mapping(name: "Kelze, Hofgeismar", latlng: LatLng(51.4654713, 9.3709576)),
  Mapping(name: "Kemel, Heidenrod", latlng: LatLng(50.1653146, 8.0167964)),
  Mapping(name: "Kemmerode, Kirchheim", latlng: LatLng(50.8196476, 9.5114545)),
  Mapping(
      name: "Kempfenbrunn, Flörsbachtal",
      latlng: LatLng(50.1109775, 9.4410216)),
  Mapping(
      name: "Keramag/Falkenberg, Flörsheim am Main",
      latlng: LatLng(50.0028832, 8.3986029)),
  Mapping(
      name: "Kerbersdorf, Bad Soden-Salmünster",
      latlng: LatLng(50.3307897, 9.3884073)),
  Mapping(name: "Kernbach, Lahntal", latlng: LatLng(50.8551578, 8.638571)),
  Mapping(
      name: "Kerspenhausen, Niederaula", latlng: LatLng(50.8120163, 9.6560086)),
  Mapping(
      name: "Kerstenhausen, Borken (Hessen)",
      latlng: LatLng(51.0662074, 9.2161225)),
  Mapping(name: "Kerstenhausen, Borken", latlng: LatLng(51.0662074, 9.2161225)),
  Mapping(name: "Kerzell, Eichenzell", latlng: LatLng(50.4846973, 9.6695864)),
  Mapping(
      name: "Kesselbach, Hünstetten", latlng: LatLng(50.2161049, 8.2151341)),
  Mapping(name: "Kesselbach, Rabenau", latlng: LatLng(50.6695484, 8.8748222)),
  Mapping(name: "Kesselstadt, Hanau", latlng: LatLng(50.1305646, 8.8919483)),
  Mapping(name: "Kestrich, Feldatal", latlng: LatLng(50.6487061, 9.1811477)),
  Mapping(name: "Kettenbach, Aarbergen", latlng: LatLng(50.2462544, 8.078519)),
  Mapping(
      name: "Ketternschwalbach, Hünstetten",
      latlng: LatLng(50.2643637, 8.1523553)),
  Mapping(
      name: "Keulos, Künzell", latlng: LatLng(50.538985, 9.740435000918996)),
  Mapping(name: "Kiedrich, Kiedrich", latlng: LatLng(50.0401347, 8.0845253)),
  Mapping(name: "Kiedrich", latlng: LatLng(50.0401347, 8.0845253)),
  Mapping(
      name: "Kilianstädten, Schöneck", latlng: LatLng(50.2004818, 8.8550908)),
  Mapping(name: "Kilsbach, Brensbach", latlng: LatLng(49.763048, 8.9068063)),
  Mapping(name: "Kimbach, Bad König", latlng: LatLng(49.726856, 9.0638124)),
  Mapping(
      name: "Kinzenbach, Heuchelheim", latlng: LatLng(50.5893541, 8.6116306)),
  Mapping(name: "Kirberg, Hünfelden", latlng: LatLng(50.3093381, 8.1606936)),
  Mapping(name: "Kirch-Göns, Butzbach", latlng: LatLng(50.4711342, 8.6534743)),
  Mapping(
      name: "Kirchbauna, Baunatal",
      latlng: LatLng(51.24462245, 9.424717910112879)),
  Mapping(
      name: "Kirchberg, Niedenstein", latlng: LatLng(51.1964809, 9.2975436)),
  Mapping(name: "Kirchbracht, Birstein", latlng: LatLng(50.4030382, 9.2790273)),
  Mapping(
      name: "Kirchbrombach, Brombachtal",
      latlng: LatLng(49.7352531, 8.9539187)),
  Mapping(name: "Kirchditmold, Kassel", latlng: LatLng(51.3233038, 9.4443059)),
  Mapping(
      name: "Kirchhain", latlng: LatLng(50.826987700000004, 8.927593310210382)),
  Mapping(
      name: "Kirchhain", latlng: LatLng(50.826987700000004, 8.927593310210382)),
  Mapping(name: "Kirchhasel, Hünfeld", latlng: LatLng(50.7010733, 9.8011351)),
  Mapping(name: "Kirchheim", latlng: LatLng(48.6102516, 7.4966532)),
  Mapping(name: "Kirchheim", latlng: LatLng(48.6102516, 7.4966532)),
  Mapping(
      name: "Kirchhof, Melsungen",
      latlng: LatLng(51.14210825, 9.596952327920723)),
  Mapping(
      name: "Kirchhosbach, Waldkappel", latlng: LatLng(51.1177445, 9.906733)),
  Mapping(name: "Kirchlotheim, Vöhl", latlng: LatLng(51.1692156, 8.896081)),
  Mapping(name: "Kirchvers, Lohra", latlng: LatLng(50.6876976, 8.6076421)),
  Mapping(
      name: "Kirdorf, Bad Homburg vor der Höhe",
      latlng: LatLng(50.2403868, 8.6083252)),
  Mapping(name: "Kirschgarten, Mücke", latlng: LatLng(50.6315858, 9.0472444)),
  Mapping(name: "Kirschgarten", latlng: LatLng(52.6903815, 13.5811615)),
  Mapping(
      name: "Kirschhausen, Heppenheim", latlng: LatLng(49.6465034, 8.6878784)),
  Mapping(name: "Kirschhofen, Weilburg", latlng: LatLng(50.4732847, 8.2427757)),
  Mapping(name: "Kirtorf", latlng: LatLng(50.7683479, 9.1061031)),
  Mapping(name: "Kirtorf", latlng: LatLng(50.7683479, 9.1061031)),
  Mapping(name: "Klarenthal, Wiesbaden", latlng: LatLng(50.0905914, 8.1993356)),
  Mapping(name: "Kleba, Niederaula", latlng: LatLng(50.8200598, 9.575139)),
  Mapping(name: "Kleestadt, Groß-Umstadt", latlng: LatLng(49.902382, 8.953977)),
  Mapping(
      name: "Klein-Altenstädten, Aßlar",
      latlng: LatLng(50.582840399999995, 8.451976490885391)),
  Mapping(name: "Klein-Auheim, Hanau", latlng: LatLng(50.0985406, 8.928056)),
  Mapping(
      name: "Klein-Bieberau, Modautal", latlng: LatLng(49.7586307, 8.766276)),
  Mapping(
      name: "Klein-Breitenbach, Mörlenbach",
      latlng: LatLng(49.5988629, 8.7279915)),
  Mapping(
      name: "Klein-Eichen, Grünberg",
      latlng: LatLng(50.5909929, 9.05072911020534)),
  Mapping(
      name: "Klein-Gerau, Büttelborn", latlng: LatLng(49.9208353, 8.5198434)),
  Mapping(
      name: "Klein-Gumpen, Reichelsheim (Odenwald)",
      latlng: LatLng(49.7013861, 8.8210773)),
  Mapping(
      name: "Klein-Gumpen, Reichelsheim",
      latlng: LatLng(49.7013861, 8.8210773)),
  Mapping(name: "Klein-Karben, Karben", latlng: LatLng(50.2249029, 8.7766448)),
  Mapping(
      name: "Klein-Krotzenburg, Hainburg",
      latlng: LatLng(50.0748618, 8.9659774)),
  Mapping(
      name: "Klein-Rohrheim, Gernsheim", latlng: LatLng(49.734226, 8.4901045)),
  Mapping(
      name: "Klein-Umstadt, Groß-Umstadt",
      latlng: LatLng(49.889642, 8.9458322)),
  Mapping(
      name: "Klein-Welzheim, Seligenstadt",
      latlng: LatLng(50.0404856, 9.0068304)),
  Mapping(
      name: "Klein-Zimmern, Groß-Zimmern",
      latlng: LatLng(49.8683011, 8.8494245)),
  Mapping(
      name: "Kleinalmerode, Witzenhausen",
      latlng: LatLng(51.3307368, 9.7871765)),
  Mapping(
      name: "Kleinenglis, Borken (Hessen)",
      latlng: LatLng(51.0727398, 9.2552669)),
  Mapping(name: "Kleinenglis, Borken", latlng: LatLng(51.0727398, 9.2552669)),
  Mapping(name: "Kleinensee, Heringen", latlng: LatLng(50.9285268, 9.9762873)),
  Mapping(name: "Kleinern, Edertal", latlng: LatLng(51.1423465, 9.0625236)),
  Mapping(
      name: "Kleingladenbach, Breidenbach",
      latlng: LatLng(50.8838507, 8.4294712)),
  Mapping(
      name: "Kleinlinden, Gießen",
      latlng: LatLng(50.5619023, 8.648067172745915)),
  Mapping(
      name: "Kleinlüder, Großenlüder", latlng: LatLng(50.5491493, 9.5158806)),
  Mapping(
      name: "Kleinropperhausen, Ottrau", latlng: LatLng(50.8241657, 9.3828855)),
  Mapping(
      name: "Kleinsassen (mit Schackau), Hofbieber",
      latlng: LatLng(50.55296105, 9.872476452713581)),
  Mapping(
      name: "Kleinsassen, Hofbieber", latlng: LatLng(50.5512422, 9.8746821)),
  Mapping(
      name: "Kleinseelheim, Kirchhain", latlng: LatLng(50.8050432, 8.8863103)),
  Mapping(
      name: "Kleinvach, Bad Sooden-Allendorf",
      latlng: LatLng(51.2476918, 9.9955579)),
  Mapping(
      name: "Klesberg,, Steinau an der Straße",
      latlng: LatLng(50.3970535, 9.4460827)),
  Mapping(
      name: "Kloppenheim, Karben",
      latlng: LatLng(50.23259205, 8.749398862215113)),
  Mapping(
      name: "Kloppenheim, Wiesbaden", latlng: LatLng(50.0944834, 8.3065158)),
  Mapping(
      name: "Kloster Arnsburg, Lich", latlng: LatLng(50.4939679, 8.7930321)),
  Mapping(name: "Knickhagen, Fuldatal", latlng: LatLng(51.3960713, 9.5540176)),
  Mapping(name: "Knoden", latlng: LatLng(49.69420925, 8.718695198781102)),
  Mapping(name: "Knüllwald", latlng: LatLng(51.002789, 9.5070574)),
  Mapping(
      name: "Kocherbach, Wald-Michelbach",
      latlng: LatLng(49.599928, 8.8346972)),
  Mapping(name: "Köddingen, Feldatal", latlng: LatLng(50.6184843, 9.2100008)),
  Mapping(name: "Kohden, Nidda", latlng: LatLng(50.4239697, 9.0099969)),
  Mapping(
      name: "Kohlgrund, Bad Arolsen", latlng: LatLng(51.4350029, 8.9415507)),
  Mapping(
      name: "Kohlgrund, Dipperz",
      latlng: LatLng(50.520060349999994, 9.789974604087227)),
  Mapping(
      name: "Kohlhaus, Fulda", latlng: LatLng(50.5264966, 9.68536262940431)),
  Mapping(
      name: "Kohlhausen, Bad Hersfeld", latlng: LatLng(50.8307755, 9.6778222)),
  Mapping(name: "Kolmbach, Lindenfels", latlng: LatLng(49.7031302, 8.7520488)),
  Mapping(
      name: "Kölschhausen, Ehringshausen",
      latlng: LatLng(50.63172885, 8.383921635408587)),
  Mapping(
      name: "Kölzenhain, Ulrichstein", latlng: LatLng(50.5571694, 9.1668227)),
  Mapping(name: "Kombach, Biedenkopf", latlng: LatLng(50.8766713, 8.5579161)),
  Mapping(
      name: "Königsberg, Biebertal",
      latlng: LatLng(50.637073099999995, 8.545352284740058)),
  Mapping(name: "Königshagen, Edertal", latlng: LatLng(51.1922782, 9.1487229)),
  Mapping(
      name: "Königshofen, Niedernhausen",
      latlng: LatLng(50.160215949999994, 8.29898832478851)),
  Mapping(
      name: "Königstädten, Rüsselsheim am Main",
      latlng: LatLng(49.9650441, 8.4474255)),
  Mapping(name: "Königstein im Taunus", latlng: LatLng(50.1818833, 8.465271)),
  Mapping(name: "Königstein im Taunus", latlng: LatLng(50.1818833, 8.465271)),
  Mapping(name: "Königswald, Cornberg", latlng: LatLng(51.0680058, 9.8194783)),
  Mapping(name: "Konnefeld, Morschen", latlng: LatLng(51.0464866, 9.624613)),
  Mapping(name: "Konradsdorf, Ortenberg", latlng: LatLng(50.344889, 9.022917)),
  Mapping(
      name: "Konrode, Schenklengsfeld", latlng: LatLng(50.8169193, 9.8309835)),
  Mapping(
      name: "Köppern, Friedrichsdorf", latlng: LatLng(50.2757104, 8.6514774)),
  Mapping(name: "Korbach", latlng: LatLng(51.2743649, 8.8720648)),
  Mapping(name: "Korbach", latlng: LatLng(51.2743649, 8.8720648)),
  Mapping(name: "Körle", latlng: LatLng(48.3169013, -3.0559821)),
  Mapping(name: "Körle", latlng: LatLng(48.3169013, -3.0559821)),
  Mapping(
      name: "Körnbach, Eiterfeld",
      latlng: LatLng(50.75030505, 9.759043080053278)),
  Mapping(name: "Kornsand, Trebur", latlng: LatLng(49.8670703, 8.3560665)),
  Mapping(
      name: "Korsika, Wald-Michelbach", latlng: LatLng(49.5195913, 8.8567971)),
  Mapping(
      name: "Kortelshütte, Oberzent", latlng: LatLng(49.4816327, 8.9228656)),
  Mapping(
      name: "Kraftsolms, Waldsolms",
      latlng: LatLng(50.45333425, 8.445240384832218)),
  Mapping(
      name: "Kranichstein, Darmstadt",
      latlng: LatLng(49.906122350000004, 8.691411985828061)),
  Mapping(
      name: "Kransberg, Usingen",
      latlng: LatLng(50.349712499999995, 8.590612122035136)),
  Mapping(name: "Krauthausen, Sontra", latlng: LatLng(51.0885121, 9.9797329)),
  Mapping(
      name: "Kreidach, Wald-Michelbach", latlng: LatLng(49.5651712, 8.7994734)),
  Mapping(
      name: "Kressenbach, Schlüchtern", latlng: LatLng(50.3701309, 9.4650337)),
  Mapping(name: "Kriftel, Kriftel", latlng: LatLng(50.0822333, 8.4751919)),
  Mapping(name: "Kriftel", latlng: LatLng(50.0850027, 8.4707355)),
  Mapping(
      name: "Kröckelbach, Fürth (Odenwald)",
      latlng: LatLng(49.6484006, 8.7804585)),
  Mapping(name: "Kröckelbach, Fürth", latlng: LatLng(49.6552885, 8.7967608)),
  Mapping(
      name: "Krofdorf-Gleiberg, Wettenberg",
      latlng: LatLng(50.6216047, 8.6364636)),
  Mapping(
      name: "Kröffelbach, Waldsolms",
      latlng: LatLng(50.43938935, 8.464429462342672)),
  Mapping(
      name: "Kröftel, Idstein", latlng: LatLng(50.2233831, 8.379915718612716)),
  Mapping(name: "Kröge", latlng: LatLng(51.0282475, 8.6361815)),
  Mapping(
      name: "Kronberg im Taunus",
      latlng: LatLng(50.1907415, 8.518277904791713)),
  Mapping(
      name: "Kronberg im Taunus",
      latlng: LatLng(50.1907415, 8.518277904791713)),
  Mapping(
      name: "Krumbach, Biebertal",
      latlng: LatLng(50.6651085, 8.594025133822537)),
  Mapping(
      name: "Krumbach, Fürth (Odenwald)",
      latlng: LatLng(49.6534536, 8.7871735)),
  Mapping(name: "Krumbach, Fürth", latlng: LatLng(49.6649091, 8.793793)),
  Mapping(name: "Kruspis, Haunetal", latlng: LatLng(50.7722694, 9.6571643)),
  Mapping(name: "Kubach, Weilburg", latlng: LatLng(50.4732213, 8.2995434)),
  Mapping(
      name: "Küchen, Hessisch Lichtenau",
      latlng: LatLng(51.1767312, 9.8166933)),
  Mapping(name: "Külte, Volkmarsen", latlng: LatLng(51.4017085, 9.0743176)),
  Mapping(
      name: "Künzell-Bachrain, Künzell", latlng: LatLng(50.5405856, 9.7121297)),
  Mapping(name: "Künzell", latlng: LatLng(50.5325269, 9.7306148)),
  Mapping(name: "Laar, Zierenberg", latlng: LatLng(51.4067904, 9.2803461)),
  Mapping(name: "Lahnau", latlng: LatLng(50.5833721, 8.56667)),
  Mapping(name: "Lahnbahnhof, Leun", latlng: LatLng(50.5394968, 8.3635466)),
  Mapping(name: "Lahntal", latlng: LatLng(50.8633478, 8.7067202)),
  Mapping(name: "Lahr, Waldbrunn", latlng: LatLng(50.5098368, 8.1306499)),
  Mapping(
      name: "Lahrbach, Tann (Rhön)",
      latlng: LatLng(50.61356465, 10.005581794781012)),
  Mapping(name: "Lahrbach, Tann", latlng: LatLng(50.6213759, 10.0043474)),
  Mapping(name: "Laimbach, Weilmünster", latlng: LatLng(50.4654764, 8.3550485)),
  Mapping(
      name: "Laisa, Battenberg (Eder)", latlng: LatLng(50.9942915, 8.6307267)),
  Mapping(name: "Laisa, Battenberg", latlng: LatLng(50.9942915, 8.6307267)),
  Mapping(name: "Lamerden, Liebenau", latlng: LatLng(51.5266884, 9.3261973)),
  Mapping(
      name: "Lämmerspiel, Mühlheim am Main",
      latlng: LatLng(50.0977026, 8.8552101)),
  Mapping(name: "Lampertheim", latlng: LatLng(48.6503574, 7.7003567)),
  Mapping(name: "Lampertheim", latlng: LatLng(48.6503574, 7.7003567)),
  Mapping(
      name: "Lampertsfeld, Schenklengsfeld",
      latlng: LatLng(50.8328151, 9.8392094)),
  Mapping(name: "Landau, Bad Arolsen", latlng: LatLng(51.3424633, 9.0829255)),
  Mapping(
      name: "Landefeld, Spangenberg", latlng: LatLng(51.0954248, 9.7089133)),
  Mapping(
      name: "Landenhausen, Wartenberg", latlng: LatLng(50.6080743, 9.4766823)),
  Mapping(
      name: "Landershausen, Schenklengsfeld",
      latlng: LatLng(50.8050975, 9.8169798)),
  Mapping(
      name: "Lanertshausen, Frielendorf",
      latlng: LatLng(50.9711985, 9.3568462)),
  Mapping(
      name: "Lang-Göns, Langgöns",
      latlng: LatLng(50.49627205, 8.664660656156371)),
  Mapping(name: "Langd, Hungen", latlng: LatLng(50.47260985, 8.9514038977666)),
  Mapping(
      name: "Langen (Hessen), Langen (Hessen)",
      latlng: LatLng(49.9936169, 8.6568034)),
  Mapping(name: "Langen (Hessen)", latlng: LatLng(49.9927036, 8.6671682)),
  Mapping(
      name: "Langen-Bergheim, Hammersbach",
      latlng: LatLng(50.2355264, 8.9992345)),
  Mapping(name: "Langen", latlng: LatLng(49.9927036, 8.6671682)),
  Mapping(
      name: "Langenaubach, Haiger",
      latlng: LatLng(50.71280555, 8.18291999990926)),
  Mapping(
      name: "Langenbach, Weilmünster", latlng: LatLng(50.3972049, 8.3749985)),
  Mapping(name: "Langenberg, Hofbieber", latlng: LatLng(50.5943585, 9.9037352)),
  Mapping(
      name: "Langenbieber, Hofbieber", latlng: LatLng(50.5727596, 9.8382153)),
  Mapping(
      name: "Langenbrombach, Brombachtal",
      latlng: LatLng(49.7223085, 8.9509678)),
  Mapping(
      name: "Langendernbach, Dornburg", latlng: LatLng(50.5394858, 8.0480572)),
  Mapping(
      name: "Langendiebach, Erlensee", latlng: LatLng(50.170388, 8.9795681)),
  Mapping(name: "Langendorf, Wohratal", latlng: LatLng(50.9423986, 8.9256872)),
  Mapping(
      name: "Langenhain-Ziegenberg, Ober-Mörlen",
      latlng: LatLng(50.3645613, 8.6361545)),
  Mapping(
      name: "Langenhain, Hofheim am Taunus",
      latlng: LatLng(50.1056286, 8.3984563)),
  Mapping(name: "Langenhain, Wehretal", latlng: LatLng(51.1419751, 10.0341617)),
  Mapping(
      name: "Langenschwarz, Burghaun", latlng: LatLng(50.7189469, 9.6323704)),
  Mapping(
      name: "Langenseifen, Bad Schwalbach",
      latlng: LatLng(50.1203697, 8.0091864)),
  Mapping(
      name: "Langenselbold, Langenselbold",
      latlng: LatLng(50.1620787, 9.0582992)),
  Mapping(name: "Langenselbold", latlng: LatLng(50.1780857, 9.0433074)),
  Mapping(
      name: "Langenstein, Kirchhain", latlng: LatLng(50.8324488, 8.9588248)),
  Mapping(
      name: "Langenthal, Hirschhorn (Neckar)",
      latlng: LatLng(49.46896995, 8.844485341753906)),
  Mapping(
      name: "Langenthal, Hirschhorn",
      latlng: LatLng(49.46896995, 8.844485341753906)),
  Mapping(
      name: "Langenthal, Trendelburg", latlng: LatLng(51.6103987, 9.3655106)),
  Mapping(name: "Langgöns", latlng: LatLng(50.4918436, 8.629093)),
  Mapping(name: "Langhecke, Villmar", latlng: LatLng(50.3877854, 8.2819411)),
  Mapping(name: "Langschied, Heidenrod", latlng: LatLng(50.1767138, 7.9680792)),
  Mapping(
      name: "Langsdorf, Lich",
      latlng: LatLng(50.501338450000006, 8.862078003008289)),
  Mapping(
      name: "Langstadt, Babenhausen", latlng: LatLng(49.9235133, 8.9507137)),
  Mapping(name: "Langwaden, Bensheim", latlng: LatLng(49.7184338, 8.5515147)),
  Mapping(name: "Lanzenhain, Herbstein", latlng: LatLng(50.5438823, 9.3029812)),
  Mapping(
      name: "Lanzingen, Biebergemünd", latlng: LatLng(50.1776595, 9.2801561)),
  Mapping(
      name: "Lardenbach, Grünberg",
      latlng: LatLng(50.582556, 9.04577144802604)),
  Mapping(
      name: "Laubach, Grävenwiesbach",
      latlng: LatLng(50.361522750000006, 8.438567918791737)),
  Mapping(name: "Laubach", latlng: LatLng(50.0557179, 7.5099389)),
  Mapping(name: "Laubach", latlng: LatLng(50.0557179, 7.5099389)),
  Mapping(
      name: "Laubuseschbach, Weilmünster",
      latlng: LatLng(50.3972039, 8.3359214)),
  Mapping(
      name: "Laudenau, Reichelsheim (Odenwald)",
      latlng: LatLng(49.7165063, 8.8052609)),
  Mapping(
      name: "Laudenau, Reichelsheim", latlng: LatLng(49.7165063, 8.8052609)),
  Mapping(
      name: "Laudenbach, Großalmerode", latlng: LatLng(51.2332372, 9.8121615)),
  Mapping(name: "Lauerbach[7], Erbach", latlng: LatLng(49.6464362, 8.9946534)),
  Mapping(
      name: "Laufdorf, Schöffengrund",
      latlng: LatLng(50.516342249999994, 8.457080025657444)),
  Mapping(
      name: "Laufenselden, Heidenrod", latlng: LatLng(50.2124106, 7.9960651)),
  Mapping(name: "Launsbach, Wettenberg", latlng: LatLng(50.6213563, 8.6567599)),
  Mapping(
      name: "Lauten-Weschnitz, Rimbach", latlng: LatLng(49.6480406, 8.7423021)),
  Mapping(
      name: "Lautenhausen, Friedewald", latlng: LatLng(50.8704757, 9.8834001)),
  Mapping(
      name: "Lauter, Laubach",
      latlng: LatLng(50.568895850000004, 8.981133434399505)),
  Mapping(name: "Lauterbach (Hessen)", latlng: LatLng(50.6656227, 9.4236655)),
  Mapping(name: "Lauterbach", latlng: LatLng(49.8272228, 16.3286778)),
  Mapping(
      name: "Lauterborn, Offenbach am Main",
      latlng: LatLng(50.08414155, 8.753781927629305)),
  Mapping(name: "Lautern, Lautertal", latlng: LatLng(49.7215029, 8.720596)),
  Mapping(name: "Lautertal (Odenwald)", latlng: LatLng(49.7123967, 8.6925279)),
  Mapping(
      name: "Lautertal (Vogelsberg)", latlng: LatLng(50.5945002, 9.2880529)),
  Mapping(name: "Lautertal", latlng: LatLng(50.5945002, 9.2880529)),
  Mapping(name: "Leberbach", latlng: LatLng(49.6640064, 8.8270721)),
  Mapping(
      name: "Leckringhausen, Wolfhagen", latlng: LatLng(51.3027112, 9.1452212)),
  Mapping(name: "Leeheim, Riedstadt", latlng: LatLng(49.8576903, 8.4399491)),
  Mapping(
      name: "Lehnerz, Fulda", latlng: LatLng(50.5894335, 9.664956663976238)),
  Mapping(
      name: "Lehnhausen, Gemünden (Wohra)",
      latlng: LatLng(50.9876856, 8.9210481)),
  Mapping(name: "Lehnhausen, Gemünden", latlng: LatLng(50.9876856, 8.9210481)),
  Mapping(
      name: "Lehnheim, Grünberg",
      latlng: LatLng(50.615001250000006, 8.991617921611883)),
  Mapping(name: "Lehrbach, Kirtorf", latlng: LatLng(50.7768353, 9.0555163)),
  Mapping(
      name: "Leibolz, Eiterfeld",
      latlng: LatLng(50.7498604, 9.823913472535533)),
  Mapping(
      name: "Leidenhofen, Ebsdorfergrund",
      latlng: LatLng(50.7257798, 8.8198766)),
  Mapping(
      name: "Leidhecken, Florstadt",
      latlng: LatLng(50.34448425, 8.908000654951291)),
  Mapping(name: "Leihgestern, Linden", latlng: LatLng(50.5283664, 8.6785724)),
  Mapping(
      name: "Leimbach, Eiterfeld",
      latlng: LatLng(50.7419396, 9.788585250011542)),
  Mapping(name: "Leimbach, Heringen", latlng: LatLng(50.8981885, 10.0274664)),
  Mapping(
      name: "Leimbach, Willingshausen", latlng: LatLng(50.8735915, 9.2315943)),
  Mapping(name: "Leimsfeld, Frielendorf", latlng: LatLng(50.9431154, 9.280582)),
  Mapping(
      name: "Leisenwald, Wächtersbach", latlng: LatLng(50.3192021, 9.2298526)),
  Mapping(name: "Lelbach, Korbach", latlng: LatLng(51.2888098, 8.8257711)),
  Mapping(
      name: "Lembach, Homberg (Efze)", latlng: LatLng(51.0416557, 9.3473873)),
  Mapping(name: "Lembach, Homberg", latlng: LatLng(51.0416557, 9.3473873)),
  Mapping(
      name: "Lenderscheid, Frielendorf", latlng: LatLng(50.9674292, 9.3743902)),
  Mapping(
      name: "Lendorf, Borken (Hessen)", latlng: LatLng(51.0617173, 9.344649)),
  Mapping(name: "Lendorf, Borken", latlng: LatLng(51.0617173, 9.344649)),
  Mapping(name: "Lengefeld, Korbach", latlng: LatLng(51.2679404, 8.830758)),
  Mapping(name: "Lengemannsau", latlng: LatLng(51.0615867, 9.4436762)),
  Mapping(name: "Lengers, Heringen", latlng: LatLng(50.8613122, 9.9945652)),
  Mapping(name: "Lengfeld, Otzberg", latlng: LatLng(49.8340054, 8.9050063)),
  Mapping(
      name: "Lenzhahn, Idstein",
      latlng: LatLng(50.194398750000005, 8.319022996170172)),
  Mapping(
      name: "Lettgenbrunn, Jossgrund", latlng: LatLng(50.1677019, 9.4179497)),
  Mapping(
      name: "Leuderode, Frielendorf", latlng: LatLng(50.9672874, 9.4008346)),
  Mapping(name: "Leun", latlng: LatLng(50.5501919, 8.3572732)),
  Mapping(name: "Leun", latlng: LatLng(50.5501919, 8.3572732)),
  Mapping(name: "Leusel, Alsfeld", latlng: LatLng(50.7591445, 9.2328705)),
  Mapping(name: "Lich", latlng: LatLng(50.5201683, 8.8165535)),
  Mapping(name: "Lich", latlng: LatLng(50.5201683, 8.8165535)),
  Mapping(name: "Lichenroth, Birstein", latlng: LatLng(50.4371429, 9.3246763)),
  Mapping(name: "Licherode, Alheim", latlng: LatLng(51.0175679, 9.5910339)),
  Mapping(
      name: "Lichtenberg, Fischbachtal", latlng: LatLng(49.7712312, 8.8044666)),
  Mapping(name: "Lichtenfels", latlng: LatLng(50.14568, 11.06382)),
  Mapping(
      name: "Lichtenhagen, Knüllwald", latlng: LatLng(51.0158926, 9.5127082)),
  Mapping(name: "Liebenau", latlng: LatLng(51.4961951, 9.2827972)),
  Mapping(name: "Liebenau", latlng: LatLng(51.4961951, 9.2827972)),
  Mapping(name: "Liebhards, Hilders", latlng: LatLng(50.5674289, 9.9489947)),
  Mapping(name: "Lieblos, Gründau", latlng: LatLng(50.2078394, 9.1394716)),
  Mapping(name: "Liederbach am Taunus", latlng: LatLng(50.1230468, 8.4878708)),
  Mapping(name: "Liederbach, Alsfeld", latlng: LatLng(50.7269339, 9.2468974)),
  Mapping(name: "Lieschensruh, Edertal", latlng: LatLng(51.172426, 9.1091662)),
  Mapping(name: "Limbach, Hünstetten", latlng: LatLng(50.2448445, 8.1752968)),
  Mapping(name: "Limburg a.d. Lahn", latlng: LatLng(50.3876305, 8.0636197)),
  Mapping(name: "Limburg an der Lahn", latlng: LatLng(50.3876305, 8.0636197)),
  Mapping(name: "Limeshain", latlng: LatLng(50.2640969, 8.9819962)),
  Mapping(
      name: "Limesstadt, Schwalbach am Taunus",
      latlng: LatLng(50.1591194, 8.5215614)),
  Mapping(name: "Linden", latlng: LatLng(50.6019526, 7.8504832)),
  Mapping(name: "Lindenau, Sontra", latlng: LatLng(51.042796, 9.9683073)),
  Mapping(name: "Lindenfels", latlng: LatLng(49.6850417, 8.7787942)),
  Mapping(name: "Lindenfels", latlng: LatLng(49.6850417, 8.7787942)),
  Mapping(
      name: "Lindenholzhausen, Limburg an der Lahn",
      latlng: LatLng(50.3752356, 8.1213245)),
  Mapping(
      name: "Lindenstruth, Reiskirchen",
      latlng: LatLng(50.5916043, 8.852936295896143)),
  Mapping(name: "Lindheim, Altenstadt", latlng: LatLng(50.2906955, 8.9804796)),
  Mapping(
      name: "Lindschied, Bad Schwalbach",
      latlng: LatLng(50.1606614, 8.0650723)),
  Mapping(name: "Lingelbach, Alsfeld", latlng: LatLng(50.7604015, 9.4022783)),
  Mapping(
      name: "Linnenbach, Fürth (Odenwald)",
      latlng: LatLng(49.6678717, 8.7664998)),
  Mapping(name: "Linnenbach, Fürth", latlng: LatLng(49.6457721, 8.7620267)),
  Mapping(name: "Linsengericht", latlng: LatLng(50.1694463, 9.1971928)),
  Mapping(
      name: "Linsingen, Frielendorf", latlng: LatLng(50.9616678, 9.2823994)),
  Mapping(
      name: "Linter, Limburg an der Lahn",
      latlng: LatLng(50.3685649, 8.0931486)),
  Mapping(
      name: "Lippoldsberg, Wesertal", latlng: LatLng(51.6239317, 9.5599042)),
  Mapping(name: "Lischeid, Gilserberg", latlng: LatLng(50.9198753, 9.0221112)),
  Mapping(
      name: "Lispenhausen, Rotenburg an der Fulda",
      latlng: LatLng(50.9903131, 9.7713458)),
  Mapping(name: "Lißberg, Ortenberg", latlng: LatLng(50.3758775, 9.0838486)),
  Mapping(
      name: "Litzelbach, Grasellenbach", latlng: LatLng(49.6205689, 8.8348082)),
  Mapping(
      name: "Litzelröder, Lindenfels", latlng: LatLng(49.6916639, 8.7825044)),
  Mapping(
      name: "Lixfeld, Angelburg",
      latlng: LatLng(50.804295499999995, 8.411767855034327)),
  Mapping(name: "Lobenhausen, Körle", latlng: LatLng(51.1670527, 9.5155032)),
  Mapping(name: "Loheland, Künzell", latlng: LatLng(50.5093261, 9.7630265)),
  Mapping(name: "Lohfelden", latlng: LatLng(51.2723244, 9.5535427)),
  Mapping(
      name: "Löhlbach, Haina (Kloster)", latlng: LatLng(51.0654852, 8.9814397)),
  Mapping(name: "Löhlbach, Haina", latlng: LatLng(51.0654852, 8.9814397)),
  Mapping(name: "Löhnberg", latlng: LatLng(50.5111954, 8.2711131)),
  Mapping(name: "Löhnberg", latlng: LatLng(50.5111954, 8.2711131)),
  Mapping(name: "Lohne, Fritzlar", latlng: LatLng(51.1806432, 9.265369)),
  Mapping(name: "Lohra", latlng: LatLng(50.736102, 8.6348744)),
  Mapping(name: "Lohra", latlng: LatLng(50.736102, 8.6348744)),
  Mapping(name: "Löhrbach", latlng: LatLng(49.5462215, 8.7642549)),
  Mapping(name: "Lohre, Felsberg", latlng: LatLng(51.1221027, 9.3861876)),
  Mapping(
      name: "Lohrhaupten, Flörsbachtal", latlng: LatLng(50.1265929, 9.4777445)),
  Mapping(name: "Lollar", latlng: LatLng(50.6488974, 8.7064931)),
  Mapping(name: "Lollar", latlng: LatLng(50.6488974, 8.7064931)),
  Mapping(name: "Londorf, Rabenau", latlng: LatLng(50.6755046, 8.8621264)),
  Mapping(name: "Lorbach, Büdingen", latlng: LatLng(50.2747147, 9.0939754)),
  Mapping(name: "Lorch", latlng: LatLng(48.8, 9.68333)),
  Mapping(name: "Lorch", latlng: LatLng(48.8, 9.68333)),
  Mapping(name: "Lorchhausen, Lorch", latlng: LatLng(50.0530145, 7.7852063)),
  Mapping(
      name: "Lorsbach, Hofheim am Taunus",
      latlng: LatLng(50.1170973, 8.4228409)),
  Mapping(name: "Lorsch, Lorsch", latlng: LatLng(49.6590244, 8.5659948)),
  Mapping(name: "Lorsch", latlng: LatLng(49.6546967, 8.5682813)),
  Mapping(name: "Lörzenbach, Fürth", latlng: LatLng(49.6446415, 8.7529287)),
  Mapping(
      name: "Löschenrod, Eichenzell", latlng: LatLng(50.4980339, 9.6793218)),
  Mapping(
      name: "Loshausen, Willingshausen", latlng: LatLng(50.8860813, 9.2519865)),
  Mapping(
      name: "Louisendorf, Frankenau", latlng: LatLng(51.0965463, 8.8762535)),
  Mapping(name: "Lüderbach, Ringgau", latlng: LatLng(51.0735395, 10.134305)),
  Mapping(
      name: "Lüdermünd, Fulda", latlng: LatLng(50.60987155, 9.62235200971698)),
  Mapping(name: "Lüdersdorf, Bebra", latlng: LatLng(50.9596437, 9.7634332)),
  Mapping(name: "Ludwigsau", latlng: LatLng(50.9249798, 9.6873779)),
  Mapping(
      name: "Lumda, Grünberg", latlng: LatLng(50.63885345, 8.93526355990566)),
  Mapping(
      name: "Lütersheim, Volkmarsen", latlng: LatLng(51.3702894, 9.1164338)),
  Mapping(name: "Lütter, Eichenzell", latlng: LatLng(50.4774942, 9.757521)),
  Mapping(name: "Lütterz, Großenlüder", latlng: LatLng(50.5948496, 9.5958645)),
  Mapping(
      name: "Lützel-Wiebelsbach, Lützelbach",
      latlng: LatLng(49.7871582, 9.076768)),
  Mapping(name: "Lützel, Biebergemünd", latlng: LatLng(50.1583145, 9.2521329)),
  Mapping(name: "Lützelbach, Modautal", latlng: LatLng(49.7428743, 8.76662)),
  Mapping(name: "Lützelbach", latlng: LatLng(49.7773428, 9.0837192)),
  Mapping(
      name: "Lützelhausen, Linsengericht", latlng: LatLng(50.16503, 9.1745949)),
  Mapping(
      name: "Lützellinden, Gießen",
      latlng: LatLng(50.54014415, 8.596732684699587)),
  Mapping(
      name: "Lützelwig, Homberg (Efze)", latlng: LatLng(51.0076491, 9.3688098)),
  Mapping(name: "Lützelwig, Homberg", latlng: LatLng(51.0076491, 9.3688098)),
  Mapping(
      name: "Lützendorf, Weilmünster", latlng: LatLng(50.4448184, 8.3650718)),
  Mapping(name: "Maar, Lauterbach", latlng: LatLng(50.6599803, 9.3873948)),
  Mapping(name: "Maar", latlng: LatLng(50.6599803, 9.3873948)),
  Mapping(
      name: "Maberzell, Fulda",
      latlng: LatLng(50.575889700000005, 9.620985364872976)),
  Mapping(
      name: "Machtlos, Breitenbach am Herzberg",
      latlng: LatLng(50.8038237, 9.4865663)),
  Mapping(name: "Machtlos, Ronshausen", latlng: LatLng(50.9689642, 9.9155238)),
  Mapping(
      name: "Mäckelsdorf, Waldkappel", latlng: LatLng(51.1313386, 9.8363237)),
  Mapping(
      name: "Mackenheim, Abtsteinach", latlng: LatLng(49.5621209, 8.7860675)),
  Mapping(
      name: "Mackenzell, Hünfeld",
      latlng: LatLng(50.648304949999996, 9.792363181915839)),
  Mapping(name: "Mademühlen, Driedorf", latlng: LatLng(50.6255101, 8.1634569)),
  Mapping(name: "Maden, Gudensberg", latlng: LatLng(51.1657328, 9.3768936)),
  Mapping(
      name: "Magdlos, Flieden", latlng: LatLng(50.42981695, 9.519728597685265)),
  Mapping(name: "Mahlerts, Hofbieber", latlng: LatLng(50.6081138, 9.938212)),
  Mapping(name: "Maibach, Butzbach", latlng: LatLng(50.3788505, 8.5718618)),
  Mapping(
      name: "Maiersbach, Gersfeld (Rhön)",
      latlng: LatLng(50.4635922, 9.886870714002768)),
  Mapping(
      name: "Maiersbach, Gersfeld",
      latlng: LatLng(50.4635922, 9.886870714002768)),
  Mapping(
      name: "Mainflingen, Mainhausen", latlng: LatLng(50.0294545, 9.0252657)),
  Mapping(name: "Mainhausen", latlng: LatLng(50.0084758, 9.0106074)),
  Mapping(name: "Maintal", latlng: LatLng(50.143872, 8.8371444)),
  Mapping(
      name: "Mainz-Amöneburg, Wiesbaden",
      latlng: LatLng(50.0321078, 8.2577147)),
  Mapping(
      name: "Mainz-Kastel, Wiesbaden", latlng: LatLng(50.0083449, 8.2844378)),
  Mapping(
      name: "Mainz-Kostheim, Wiesbaden", latlng: LatLng(50.0051896, 8.3038698)),
  Mapping(name: "Mainzlar, Staufenberg", latlng: LatLng(50.6616049, 8.7299749)),
  Mapping(
      name: "Malchen, Seeheim-Jugenheim",
      latlng: LatLng(49.7903849, 8.6519015)),
  Mapping(name: "Malges, Hünfeld", latlng: LatLng(50.7308482, 9.8025431)),
  Mapping(
      name: "Malkes, Fulda",
      latlng: LatLng(50.555434250000005, 9.581326189597082)),
  Mapping(
      name: "Malkomes, Schenklengsfeld", latlng: LatLng(50.8529926, 9.8193993)),
  Mapping(name: "Malmeneich", latlng: LatLng(50.441688, 7.9956604274096215)),
  Mapping(name: "Malsfeld", latlng: LatLng(51.0875775, 9.5128116)),
  Mapping(name: "Malsfeld", latlng: LatLng(51.0875775, 9.5128116)),
  Mapping(
      name: "Mammolshain, Königstein im Taunus",
      latlng: LatLng(50.1725416, 8.4977688)),
  Mapping(
      name: "Mandeln, Dietzhölztal",
      latlng: LatLng(50.85521115, 8.330162076968795)),
  Mapping(
      name: "Manderbach, Dillenburg",
      latlng: LatLng(50.77259905, 8.259346563100607)),
  Mapping(
      name: "Mandern, Bad Wildungen", latlng: LatLng(51.1251099, 9.2001702)),
  Mapping(
      name: "Mangelsbach, Michelstadt", latlng: LatLng(49.6682351, 9.0851311)),
  Mapping(name: "Mansbach, Hohenroda", latlng: LatLng(50.7857822, 9.916642)),
  Mapping(
      name: "Mappershain, Heidenrod", latlng: LatLng(50.1710116, 7.9953977)),
  Mapping(name: "Marbach, Erbach", latlng: LatLng(49.6058579, 8.9839591)),
  Mapping(name: "Marbach, Marburg", latlng: LatLng(50.815706, 8.7495349)),
  Mapping(name: "Marbach, Petersberg", latlng: LatLng(50.6205902, 9.7248434)),
  Mapping(
      name: "Marborn, Steinau an der Straße",
      latlng: LatLng(50.319774, 9.419372)),
  Mapping(name: "Marburg", latlng: LatLng(50.8090106, 8.7704695)),
  Mapping(name: "Marburg", latlng: LatLng(50.8090106, 8.7704695)),
  Mapping(name: "Marburg", latlng: LatLng(50.8090106, 8.7704695)),
  Mapping(name: "Mardorf, Amöneburg", latlng: LatLng(50.7659627, 8.9170656)),
  Mapping(
      name: "Mardorf, Homberg (Efze)", latlng: LatLng(51.0483945, 9.394247)),
  Mapping(name: "Mardorf, Homberg", latlng: LatLng(51.0483945, 9.394247)),
  Mapping(
      name: "Margretenhaun, Petersberg", latlng: LatLng(50.5659388, 9.7620611)),
  Mapping(
      name: "Mariendorf, Immenhausen", latlng: LatLng(51.4523043, 9.4892819)),
  Mapping(name: "Marienhagen, Vöhl", latlng: LatLng(51.2119903, 8.9113059)),
  Mapping(
      name: "Marienthal, Geisenheim", latlng: LatLng(50.0045483, 7.9524729)),
  Mapping(
      name: "Marjoß, Steinau an der Straße",
      latlng: LatLng(50.2578575, 9.5136667)),
  Mapping(
      name: "Markershausen, Herleshausen",
      latlng: LatLng(51.0422959, 10.1135695)),
  Mapping(name: "Marköbel, Hammersbach", latlng: LatLng(50.2226835, 8.9844499)),
  Mapping(name: "Martenroth, Heidenrod", latlng: LatLng(50.2025174, 7.921485)),
  Mapping(
      name: "Martinhagen, Schauenburg", latlng: LatLng(51.287379, 9.2850229)),
  Mapping(
      name: "Martinsthal, Eltville am Rhein",
      latlng: LatLng(50.0532607, 8.1209015)),
  Mapping(
      name: "Marxheim, Hofheim am Taunus",
      latlng: LatLng(50.0724011, 8.4320722)),
  Mapping(
      name: "Marzhausen, Neu-Eichenberg",
      latlng: LatLng(51.4107384, 9.8995569)),
  Mapping(
      name: "Massenhausen, Bad Arolsen", latlng: LatLng(51.3899381, 8.9507916)),
  Mapping(
      name: "Massenheim, Bad Vilbel", latlng: LatLng(50.1903986, 8.7209962)),
  Mapping(
      name: "Massenheim, Hochheim am Main",
      latlng: LatLng(50.04144495, 8.387234562031203)),
  Mapping(
      name: "Mathildenviertel, Offenbach am Main",
      latlng: LatLng(50.1049364, 8.77578931281709)),
  Mapping(name: "Mauers, Haunetal", latlng: LatLng(50.7825293, 9.7015696)),
  Mapping(
      name: "Maulbach, Homberg (Ohm)", latlng: LatLng(50.7279026, 9.0561342)),
  Mapping(name: "Maulbach, Homberg", latlng: LatLng(50.7279026, 9.0561342)),
  Mapping(
      name: "Mauloff, Weilrod", latlng: LatLng(50.2858842, 8.397256359603315)),
  Mapping(name: "Mauswinkel, Birstein", latlng: LatLng(50.4024867, 9.289105)),
  Mapping(name: "Meckbach, Ludwigsau", latlng: LatLng(50.9190555, 9.7907361)),
  Mapping(name: "Mecklar, Ludwigsau", latlng: LatLng(50.9174645, 9.7612468)),
  Mapping(
      name: "Medenbach, Breitscheid",
      latlng: LatLng(50.70343325, 8.218796628809978)),
  Mapping(name: "Medenbach, Wiesbaden", latlng: LatLng(50.1048126, 8.3407229)),
  Mapping(name: "Meerholz, Gelnhausen", latlng: LatLng(50.1835823, 9.141452)),
  Mapping(name: "Mehlen, Edertal", latlng: LatLng(51.1643975, 9.1066231)),
  Mapping(
      name: "Meiches, Lautertal (Vogelsberg)",
      latlng: LatLng(50.6247072, 9.2561977)),
  Mapping(name: "Meiches, Lautertal", latlng: LatLng(50.6247072, 9.2561977)),
  Mapping(name: "Meimbressen, Calden", latlng: LatLng(51.4047748, 9.3553712)),
  Mapping(
      name: "Meineringhausen, Korbach", latlng: LatLng(51.255864, 8.9405875)),
  Mapping(name: "Meinhard", latlng: LatLng(51.2140398, 10.0610708)),
  Mapping(name: "Meisenbach, Haunetal", latlng: LatLng(50.7866535, 9.7131008)),
  Mapping(name: "Meißner", latlng: LatLng(51.2072898, 9.9276214)),
  Mapping(name: "Melbach, Wölfersheim", latlng: LatLng(50.3796678, 8.8090081)),
  Mapping(
      name: "Melgershausen, Felsberg", latlng: LatLng(51.1436411, 9.4936197)),
  Mapping(name: "Mellnau, Wetter", latlng: LatLng(50.9297493, 8.7504724)),
  Mapping(
      name: "Melperts, Ehrenberg (Rhön)",
      latlng: LatLng(50.5128859, 10.011856)),
  Mapping(name: "Melperts, Ehrenberg", latlng: LatLng(50.5128859, 10.011856)),
  Mapping(name: "Melsungen", latlng: LatLng(51.1313219, 9.5438678)),
  Mapping(name: "Melsungen", latlng: LatLng(51.1313219, 9.5438678)),
  Mapping(name: "Melzdorf, Petersberg", latlng: LatLng(50.5762408, 9.7544661)),
  Mapping(
      name: "Mengeringhausen, Bad Arolsen",
      latlng: LatLng(51.3814867, 8.9974383)),
  Mapping(
      name: "Mengers, Eiterfeld",
      latlng: LatLng(50.79687905, 9.787020675864177)),
  Mapping(name: "Mengerskirchen", latlng: LatLng(50.5653508, 8.1550248)),
  Mapping(name: "Mengsberg, Neustadt", latlng: LatLng(50.9009335, 9.1002972)),
  Mapping(
      name: "Mengshausen, Niederaula", latlng: LatLng(50.7938507, 9.6197277)),
  Mapping(name: "Mensfelden, Hünfelden", latlng: LatLng(50.3427417, 8.1051945)),
  Mapping(name: "Merenberg", latlng: LatLng(50.5082969, 8.1917001)),
  Mapping(
      name: "Merkenbach, Herborn",
      latlng: LatLng(50.65605995, 8.299056229409683)),
  Mapping(
      name: "Merkenfritz, Hirzenhain", latlng: LatLng(50.3992857, 9.1539985)),
  Mapping(name: "Merlau, Mücke", latlng: LatLng(50.6241241, 9.028304)),
  Mapping(name: "Merlos [17], Grebenau", latlng: LatLng(50.7510111, 9.4525479)),
  Mapping(
      name: "Mernes, Bad Soden-Salmünster",
      latlng: LatLng(50.2378767, 9.4779953)),
  Mapping(
      name: "Merxhausen, Bad Emstal", latlng: LatLng(51.2267363, 9.2657369)),
  Mapping(
      name: "Merzhausen, Usingen",
      latlng: LatLng(50.3240086, 8.461516650146056)),
  Mapping(
      name: "Merzhausen, Willingshausen",
      latlng: LatLng(50.8509569, 9.2217455)),
  Mapping(name: "Meßbach, Fischbachtal", latlng: LatLng(49.748163, 8.8081039)),
  Mapping(name: "Messel, Messel", latlng: LatLng(49.9217115, 8.7459623)),
  Mapping(name: "Messel", latlng: LatLng(49.9369643, 8.7449232)),
  Mapping(
      name: "Messenhausen, Rödermark", latlng: LatLng(49.9900996, 8.8017164)),
  Mapping(name: "Metze, Niedenstein", latlng: LatLng(51.2053796, 9.3364527)),
  Mapping(
      name: "Metzebach, Spangenberg", latlng: LatLng(51.0866122, 9.7004653)),
  Mapping(
      name: "Metzlos-Gehaag, Grebenhain",
      latlng: LatLng(50.4942837, 9.4114982)),
  Mapping(name: "Metzlos, Grebenhain", latlng: LatLng(50.4837884, 9.4008356)),
  Mapping(name: "Michelau, Büdingen", latlng: LatLng(50.3280185, 9.1718113)),
  Mapping(
      name: "Michelbach, Aarbergen",
      latlng: LatLng(50.227086150000005, 8.063911509176762)),
  Mapping(name: "Michelbach, Marburg", latlng: LatLng(50.845599, 8.7150694)),
  Mapping(name: "Michelbach, Schotten", latlng: LatLng(50.5041326, 9.1600729)),
  Mapping(name: "Michelbach, Usingen", latlng: LatLng(50.3737421, 8.5336421)),
  Mapping(name: "Michelnau, Nidda", latlng: LatLng(50.4194873, 9.0430506)),
  Mapping(
      name: "Michelsberg, Schwalmstadt", latlng: LatLng(50.9642753, 9.2406536)),
  Mapping(
      name: "Michelsrombach, Hünfeld",
      latlng: LatLng(50.6528356, 9.6509839251989)),
  Mapping(name: "Michelstadt", latlng: LatLng(49.68841, 9.05647)),
  Mapping(name: "Michelstadt", latlng: LatLng(49.68841, 9.05647)),
  Mapping(name: "Mitlechtern, Rimbach", latlng: LatLng(49.6439058, 8.7355386)),
  Mapping(name: "Mitte, Kassel", latlng: LatLng(51.3157848, 9.4950396)),
  Mapping(
      name: "Mittel-Gründau, Gründau", latlng: LatLng(50.2285975, 9.1109496)),
  Mapping(
      name: "Mittel-Kinzig, Bad König", latlng: LatLng(49.7593866, 8.9500266)),
  Mapping(name: "Mittel-Seemen, Gedern", latlng: LatLng(50.4005464, 9.2381575)),
  Mapping(
      name: "Mittelaschenbach, Nüsttal", latlng: LatLng(50.646669, 9.8596823)),
  Mapping(name: "Mittelbuchen, Hanau", latlng: LatLng(50.1776159, 8.8870552)),
  Mapping(
      name: "Mittelheim, Oestrich-Winkel",
      latlng: LatLng(50.0029526, 8.020638)),
  Mapping(
      name: "Mittelkalbach, Kalbach", latlng: LatLng(50.4241816, 9.6424947)),
  Mapping(
      name: "Mittelrode, Fulda",
      latlng: LatLng(50.53632415, 9.606366196775106)),
  Mapping(name: "Mittenaar", latlng: LatLng(50.6892569, 8.3842752)),
  Mapping(name: "Mitterode, Sontra", latlng: LatLng(51.1067951, 9.9241136)),
  Mapping(name: "Modau, Ober-Ramstadt", latlng: LatLng(49.7948466, 8.7386625)),
  Mapping(name: "Modautal", latlng: LatLng(49.75572, 8.74308)),
  Mapping(
      name: "Mohnhausen, Haina (Kloster)",
      latlng: LatLng(51.0241567, 8.9181104)),
  Mapping(name: "Mohnhausen, Haina", latlng: LatLng(51.0241567, 8.9181104)),
  Mapping(name: "Moischeid, Gilserberg", latlng: LatLng(50.9669724, 9.0488513)),
  Mapping(name: "Moischt, Marburg", latlng: LatLng(50.7749168, 8.8168676)),
  Mapping(
      name: "Mölln [18], Ebsdorfergrund",
      latlng: LatLng(50.7470068, 8.8313984)),
  Mapping(
      name: "Molzbach, Hünfeld", latlng: LatLng(50.6663965, 9.810510211725441)),
  Mapping(name: "Momart, Bad König", latlng: LatLng(49.7267527, 9.0132338)),
  Mapping(name: "Momberg, Neustadt", latlng: LatLng(50.8790992, 9.1080575)),
  Mapping(name: "Mönchehof, Espenau", latlng: LatLng(51.3867029, 9.4521904)),
  Mapping(
      name: "Mönchhosbach, Nentershausen",
      latlng: LatLng(51.038716, 9.8981413)),
  Mapping(
      name: "Mönstadt, Grävenwiesbach",
      latlng: LatLng(50.39253035, 8.41995515120552)),
  Mapping(name: "Mörfelden-Walldorf", latlng: LatLng(49.9923836, 8.5622468)),
  Mapping(
      name: "Mörfelden, Mörfelden-Walldorf",
      latlng: LatLng(49.9761052, 8.5638601)),
  Mapping(name: "Mörlenbach", latlng: LatLng(49.5982679, 8.7354401)),
  Mapping(name: "Mörlenbach", latlng: LatLng(49.5982679, 8.7354401)),
  Mapping(name: "Morles, Nüsttal", latlng: LatLng(50.6286529, 9.8492972)),
  Mapping(
      name: "Mornshausen a. S., Gladenbach",
      latlng: LatLng(50.7531224, 8.596161)),
  Mapping(
      name: "Mornshausen, Dautphetal", latlng: LatLng(50.8411557, 8.5395465)),
  Mapping(name: "Morschen", latlng: LatLng(51.0717144, 9.5969183)),
  Mapping(
      name: "Mörshausen, Homberg (Efze)", latlng: LatLng(51.0429702, 9.443004)),
  Mapping(name: "Mörshausen, Homberg", latlng: LatLng(51.0429702, 9.443004)),
  Mapping(
      name: "Mörshausen, Spangenberg", latlng: LatLng(51.1125964, 9.6070419)),
  Mapping(
      name: "Mosbach, Gersfeld (Rhön)", latlng: LatLng(50.443729, 9.9473849)),
  Mapping(name: "Mosbach, Gersfeld", latlng: LatLng(50.443729, 9.9473849)),
  Mapping(name: "Mosbach, Schaafheim", latlng: LatLng(49.8911225, 9.0295631)),
  Mapping(name: "Mosborn, Flörsbachtal", latlng: LatLng(50.1086815, 9.4051039)),
  Mapping(name: "Mosheim, Malsfeld", latlng: LatLng(51.0844253, 9.4604083)),
  Mapping(name: "Mossautal", latlng: LatLng(49.6448742, 8.9132941)),
  Mapping(name: "Möttau, Weilmünster", latlng: LatLng(50.453128, 8.400356)),
  Mapping(name: "Mottgers, Sinntal", latlng: LatLng(50.2981052, 9.6532255)),
  Mapping(name: "Motzenrode, Meinhard", latlng: LatLng(51.235056, 10.0400149)),
  Mapping(name: "Motzfeld, Friedewald", latlng: LatLng(50.8501422, 9.8587478)),
  Mapping(name: "Mücke", latlng: LatLng(50.6160482, 9.0275281)),
  Mapping(
      name: "Mudersbach, Hohenahr",
      latlng: LatLng(50.6884512, 8.492188128278698)),
  Mapping(name: "Mühlbach, Neuenstein", latlng: LatLng(50.9330858, 9.5572354)),
  Mapping(name: "Mühlhausen, Breuberg", latlng: LatLng(49.8017924, 9.0492771)),
  Mapping(
      name: "Mühlhausen, Homberg (Efze)", latlng: LatLng(51.0438817, 9.374593)),
  Mapping(name: "Mühlhausen, Homberg", latlng: LatLng(51.0438817, 9.374593)),
  Mapping(name: "Mühlhausen, Twistetal", latlng: LatLng(51.3344222, 8.9084311)),
  Mapping(name: "Mühlheim am Main", latlng: LatLng(50.1080582, 8.8467138)),
  Mapping(name: "Mühlheim am Main", latlng: LatLng(50.1080582, 8.8467138)),
  Mapping(name: "Mühltal", latlng: LatLng(49.8077, 8.6941)),
  Mapping(name: "Mulang [19], Kassel", latlng: LatLng(51.3105808, 9.4193361)),
  Mapping(
      name: "Mümling-Grumbach, Höchst i. Odw.",
      latlng: LatLng(49.7704187, 8.9877143)),
  Mapping(name: "Mummenroth, Brensbach", latlng: LatLng(49.7888586, 8.8929188)),
  Mapping(name: "Münch-Leusel, Alsfeld", latlng: LatLng(50.7832053, 9.2761755)),
  Mapping(
      name: "Münchhausen, Driedorf",
      latlng: LatLng(50.613018600000004, 8.191302911378168)),
  Mapping(name: "Münchhausen", latlng: LatLng(48.9196671, 8.1484455)),
  Mapping(name: "Münchhausen", latlng: LatLng(48.9196671, 8.1484455)),
  Mapping(
      name: "Münchholzhausen, Wetzlar", latlng: LatLng(50.5508937, 8.5761377)),
  Mapping(
      name: "Münden, Lichtenfels (Hessen)",
      latlng: LatLng(51.1529922, 8.7476819)),
  Mapping(name: "Münden, Lichtenfels", latlng: LatLng(51.1529922, 8.7476819)),
  Mapping(
      name: "Mündershausen, Rotenburg an der Fulda",
      latlng: LatLng(50.9795265, 9.7159973)),
  Mapping(name: "Münschbach", latlng: LatLng(49.6108585, 8.7683054)),
  Mapping(name: "Münster (Hessen)", latlng: LatLng(49.92953, 8.85111)),
  Mapping(name: "Münster, Butzbach", latlng: LatLng(50.3901197, 8.6166094)),
  Mapping(
      name: "Münster, Kelkheim (Taunus)", latlng: LatLng(50.126703, 8.4635502)),
  Mapping(name: "Münster, Kelkheim", latlng: LatLng(50.126703, 8.4635502)),
  Mapping(
      name: "Münster, Laubach",
      latlng: LatLng(50.552153149999995, 8.922442927338945)),
  Mapping(
      name: "Münster, Selters (Taunus)", latlng: LatLng(50.3703309, 8.2652279)),
  Mapping(name: "Münster, Selters", latlng: LatLng(50.3703309, 8.2652279)),
  Mapping(name: "Münster", latlng: LatLng(51.9625101, 7.6251879)),
  Mapping(name: "Münzenberg", latlng: LatLng(50.4518351, 8.7759774)),
  Mapping(name: "Münzenberg", latlng: LatLng(50.4518351, 8.7759774)),
  Mapping(name: "Müs, Großenlüder", latlng: LatLng(50.5904677, 9.5049449)),
  Mapping(
      name: "Muschenheim, Lich", latlng: LatLng(50.4809728, 8.802566569610416)),
  Mapping(name: "Müsenbach, Haunetal", latlng: LatLng(50.7895005, 9.7054874)),
  Mapping(
      name: "Nanz-Willershausen, Lohra", latlng: LatLng(50.7545949, 8.6441803)),
  Mapping(
      name: "Nanzenbach, Dillenburg",
      latlng: LatLng(50.772716200000005, 8.3459866155103)),
  Mapping(
      name: "Nassenerfurth, Borken (Hessen)",
      latlng: LatLng(51.0234703, 9.2601811)),
  Mapping(name: "Nassenerfurth, Borken", latlng: LatLng(51.0234703, 9.2601811)),
  Mapping(
      name: "Nauborn, Wetzlar", latlng: LatLng(50.52569445, 8.49250634315717)),
  Mapping(
      name: "Nauborner Straße, Wetzlar", latlng: LatLng(50.5391397, 8.5015497)),
  Mapping(name: "Nauheim, Hünfelden", latlng: LatLng(50.3452965, 8.1365254)),
  Mapping(name: "Nauheim, Nauheim", latlng: LatLng(50.0563486, 7.7560273)),
  Mapping(name: "Nauheim", latlng: LatLng(49.9452137, 8.4535626)),
  Mapping(name: "Naumburg", latlng: LatLng(51.1525648, 11.8099186)),
  Mapping(name: "Naumburg", latlng: LatLng(51.1525648, 11.8099186)),
  Mapping(
      name: "Naunheim, Wetzlar",
      latlng: LatLng(50.599046799999996, 8.520538137260228)),
  Mapping(
      name: "Naunstadt, Grävenwiesbach",
      latlng: LatLng(50.3742155, 8.44555139138974)),
  Mapping(name: "Naurod, Wiesbaden", latlng: LatLng(50.1352061, 8.3013099)),
  Mapping(name: "Nauroth, Heidenrod", latlng: LatLng(50.1491768, 7.9473068)),
  Mapping(name: "Nausis, Knüllwald", latlng: LatLng(50.9724348, 9.5207242)),
  Mapping(name: "Nausis, Neukirchen", latlng: LatLng(50.8404287, 9.3641744)),
  Mapping(
      name: "Nausis, Spangenberg",
      latlng: LatLng(51.09045405, 9.721198734773624)),
  Mapping(
      name: "Neckarhausen, Neckarsteinach",
      latlng: LatLng(49.417277, 8.8822963)),
  Mapping(name: "Neckarsteinach", latlng: LatLng(49.4082418, 8.8364591)),
  Mapping(name: "Neckarsteinach", latlng: LatLng(49.4082418, 8.8364591)),
  Mapping(
      name: "Neerdar, Willingen (Upland)",
      latlng: LatLng(51.2924355, 8.729247)),
  Mapping(name: "Neerdar, Willingen", latlng: LatLng(51.2924355, 8.729247)),
  Mapping(name: "Neesbach, Hünfelden", latlng: LatLng(50.3297108, 8.1531237)),
  Mapping(
      name: "Nenderoth, Greifenstein",
      latlng: LatLng(50.5829335, 8.204518220589586)),
  Mapping(name: "Nenterode, Knüllwald", latlng: LatLng(50.9913889, 9.5316485)),
  Mapping(name: "Nentershausen", latlng: LatLng(50.4200473, 7.9351275)),
  Mapping(name: "Nentershausen", latlng: LatLng(50.4200473, 7.9351275)),
  Mapping(name: "Nesselbrunn, Weimar", latlng: LatLng(50.8032258, 8.6422838)),
  Mapping(
      name: "Nesselröden, Herleshausen",
      latlng: LatLng(51.0255328, 10.1110784)),
  Mapping(name: "Netra, Ringgau", latlng: LatLng(51.0949684, 10.0922507)),
  Mapping(name: "Netze, Waldeck", latlng: LatLng(51.2243705, 9.094177)),
  Mapping(name: "Neu-Anspach", latlng: LatLng(50.3001938, 8.5071011)),
  Mapping(
      name: "Neu-Berich, Bad Arolsen", latlng: LatLng(51.3853374, 9.0806503)),
  Mapping(name: "Neu-Eichenberg", latlng: LatLng(51.3819199, 9.9058655)),
  Mapping(name: "Neu-Isenburg", latlng: LatLng(50.0464196, 8.6717748)),
  Mapping(name: "Neu-Isenburg", latlng: LatLng(50.0464196, 8.6717748)),
  Mapping(name: "Neuberg", latlng: LatLng(50.1971476, 8.9863881)),
  Mapping(name: "Neudorf, Diemelstadt", latlng: LatLng(51.4524623, 8.9470293)),
  Mapping(name: "Neudorf, Wächtersbach", latlng: LatLng(50.266101, 9.3171907)),
  Mapping(
      name: "Neuenbrunslar, Felsberg", latlng: LatLng(51.1701325, 9.4390677)),
  Mapping(name: "Neuengronau, Sinntal", latlng: LatLng(50.2712935, 9.6060973)),
  Mapping(
      name: "Neuenhain, Bad Soden am Taunus",
      latlng: LatLng(50.159906050000004, 8.486843170633554)),
  Mapping(name: "Neuenhain, Neuental", latlng: LatLng(50.987643, 9.2645442)),
  Mapping(
      name: "Neuenhaßlau, Hasselroth", latlng: LatLng(50.1619944, 9.0926772)),
  Mapping(
      name: "Neuenrode [20], Neu-Eichenberg",
      latlng: LatLng(51.3912123, 9.8725653)),
  Mapping(
      name: "Neuenschmidten, Brachttal", latlng: LatLng(50.3134403, 9.2858573)),
  Mapping(name: "Neuenstein", latlng: LatLng(49.2047713, 9.5803049)),
  Mapping(name: "Neuental", latlng: LatLng(50.990145, 9.225198)),
  Mapping(name: "Neuerode, Meinhard", latlng: LatLng(51.2209715, 10.055318)),
  Mapping(name: "Neuhof, Taunusstein", latlng: LatLng(50.1708993, 8.2111022)),
  Mapping(name: "Neuhof", latlng: LatLng(49.8032237, 14.356915)),
  Mapping(name: "Neuhof", latlng: LatLng(49.8032237, 14.356915)),
  Mapping(
      name: "Neukirchen, Braunfels",
      latlng: LatLng(50.48000375, 8.43080438752655)),
  Mapping(name: "Neukirchen, Haunetal", latlng: LatLng(50.7697763, 9.6951545)),
  Mapping(
      name: "Neukirchen, Lichtenfels (Hessen)",
      latlng: LatLng(51.131854, 8.7204756)),
  Mapping(
      name: "Neukirchen, Lichtenfels", latlng: LatLng(51.131854, 8.7204756)),
  Mapping(name: "Neukirchen", latlng: LatLng(54.8687122, 8.7339915)),
  Mapping(name: "Neukirchen", latlng: LatLng(54.8687122, 8.7339915)),
  Mapping(
      name: "Neuludwigsdorf, Allendorf (Eder)",
      latlng: LatLng(51.0794896, 8.5885511)),
  Mapping(
      name: "Neuludwigsdorf, Allendorf", latlng: LatLng(51.0794896, 8.5885511)),
  Mapping(name: "Neumorschen, Morschen", latlng: LatLng(51.0631385, 9.6067128)),
  Mapping(name: "Neunkirchen, Modautal", latlng: LatLng(49.7334221, 8.7750291)),
  Mapping(
      name: "Neuschloß, Lampertheim", latlng: LatLng(49.6022625, 8.5157454)),
  Mapping(
      name: "Neuschwambach, Tann (Rhön)",
      latlng: LatLng(50.5975777, 9.971835759682683)),
  Mapping(name: "Neuschwambach, Tann", latlng: LatLng(50.5944552, 9.9808538)),
  Mapping(
      name: "Neuseesen, Witzenhausen", latlng: LatLng(51.342583, 9.9180661)),
  Mapping(name: "Neuses, Freigericht", latlng: LatLng(50.1284801, 9.1399252)),
  Mapping(name: "Neustadt (Hessen)", latlng: LatLng(50.8515376, 9.1173459)),
  Mapping(
      name: "Neustadt [21], Neuhof", latlng: LatLng(54.5406872, 18.2856792)),
  Mapping(name: "Neustadt, Breuberg", latlng: LatLng(49.820304, 9.0401158)),
  Mapping(name: "Neustadt, Wetzlar", latlng: LatLng(50.5597327, 8.4977844)),
  Mapping(name: "Neustadt", latlng: LatLng(50.0759376, 14.4199464)),
  Mapping(
      name: "Neustall, Steinau an der Straße",
      latlng: LatLng(50.399673, 9.4229286)),
  Mapping(
      name: "Neuswarts, Tann (Rhön)", latlng: LatLng(50.6597725, 9.9699325)),
  Mapping(name: "Neuswarts, Tann", latlng: LatLng(50.6597725, 9.9699325)),
  Mapping(name: "Neutsch, Modautal", latlng: LatLng(49.7753527, 8.7116431)),
  Mapping(
      name: "Neuweilnau, Weilrod",
      latlng: LatLng(50.31924665, 8.402065654016134)),
  Mapping(
      name: "Neuwiedermuß, Ronneburg", latlng: LatLng(50.2298834, 9.0593982)),
  Mapping(name: "Nidda", latlng: LatLng(50.4267, 9.0286)),
  Mapping(name: "Nidda", latlng: LatLng(50.4267, 9.0286)),
  Mapping(name: "Niddatal", latlng: LatLng(50.2833, 8.83333)),
  Mapping(
      name: "Niddawitzhausen, Eschwege", latlng: LatLng(51.1787905, 9.9858496)),
  Mapping(name: "Nidderau", latlng: LatLng(50.2290263, 8.8762327)),
  Mapping(
      name: "Nied, Frankfurt am Main", latlng: LatLng(50.1007301, 8.5722132)),
  Mapping(name: "Niedenstein", latlng: LatLng(51.2332937, 9.3166577)),
  Mapping(name: "Niedenstein", latlng: LatLng(51.2332937, 9.3166577)),
  Mapping(
      name: "Nieder-Beerbach, Mühltal", latlng: LatLng(49.7912808, 8.6769066)),
  Mapping(
      name: "Nieder-Bessingen, Lich",
      latlng: LatLng(50.53884855, 8.8790607430997)),
  Mapping(
      name: "Nieder-Breidenbach, Romrod",
      latlng: LatLng(50.6936942, 9.2247277)),
  Mapping(name: "Nieder-Ense, Korbach", latlng: LatLng(51.2330747, 8.8619988)),
  Mapping(
      name: "Nieder-Erlenbach, Frankfurt am Main",
      latlng: LatLng(50.2026088, 8.7119602)),
  Mapping(
      name: "Nieder-Eschbach, Frankfurt am Main",
      latlng: LatLng(50.201765449999996, 8.666575693266704)),
  Mapping(
      name: "Nieder-Florstadt, Florstadt",
      latlng: LatLng(50.3174043, 8.8605768)),
  Mapping(
      name: "Nieder-Gemünden, Gemünden (Felda)",
      latlng: LatLng(50.6941297, 9.0565343)),
  Mapping(name: "Nieder-Gemünden", latlng: LatLng(50.6941297, 9.0565343)),
  Mapping(
      name: "Nieder-Kainsbach, Brensbach",
      latlng: LatLng(49.7531557, 8.8831757)),
  Mapping(
      name: "Nieder-Kinzig, Bad König", latlng: LatLng(49.7553778, 8.9738207)),
  Mapping(
      name: "Nieder-Klingen, Otzberg", latlng: LatLng(49.819196, 8.8906917)),
  Mapping(
      name: "Nieder-Liebersbach, Birkenau (Odenwald)",
      latlng: LatLng(49.5811257, 8.7199833)),
  Mapping(
      name: "Nieder-Liebersbach, Birkenau",
      latlng: LatLng(49.5826461, 8.701167)),
  Mapping(
      name: "Nieder-Mockstadt, Florstadt",
      latlng: LatLng(50.32818055, 8.950372309188626)),
  Mapping(
      name: "Nieder-Modau, Ober-Ramstadt",
      latlng: LatLng(49.80148995, 8.736828002163818)),
  Mapping(
      name: "Nieder-Moos, Freiensteinau",
      latlng: LatLng(50.4738994, 9.3821525)),
  Mapping(
      name: "Nieder-Mörlen, Bad Nauheim",
      latlng: LatLng(50.3812219, 8.7215152)),
  Mapping(
      name: "Nieder-Oberrod, Idstein",
      latlng: LatLng(50.23227525, 8.363092673666507)),
  Mapping(
      name: "Nieder-Ofleiden, Homberg (Ohm)",
      latlng: LatLng(50.7530371, 8.9722094)),
  Mapping(
      name: "Nieder-Ofleiden, Homberg", latlng: LatLng(50.7530371, 8.9722094)),
  Mapping(name: "Nieder-Ohmen, Mücke", latlng: LatLng(50.6465015, 9.0345433)),
  Mapping(
      name: "Nieder-Ramstadt, Mühltal", latlng: LatLng(49.8277734, 8.7030545)),
  Mapping(name: "Nieder-Roden, Rodgau", latlng: LatLng(50.0002464, 8.8716063)),
  Mapping(
      name: "Nieder-Rosbach, Rosbach vor der Höhe",
      latlng: LatLng(50.2993007, 8.6966378)),
  Mapping(
      name: "Nieder-Schleidern, Korbach",
      latlng: LatLng(51.2467479, 8.7495564)),
  Mapping(name: "Nieder-Seemen, Gedern", latlng: LatLng(50.3867886, 9.2463198)),
  Mapping(name: "Nieder-Stoll, Schlitz", latlng: LatLng(50.6512822, 9.5190153)),
  Mapping(
      name: "Nieder-Waroldern, Twistetal",
      latlng: LatLng(51.308162, 9.0072831)),
  Mapping(
      name: "Nieder-Weisel, Butzbach", latlng: LatLng(50.4151421, 8.682298)),
  Mapping(name: "Nieder-Werbe, Waldeck", latlng: LatLng(51.2101225, 9.0050161)),
  Mapping(
      name: "Nieder-Wöllstadt, Wöllstadt",
      latlng: LatLng(50.2813679, 8.7700714)),
  Mapping(
      name: "Niederasphe, Münchhausen", latlng: LatLng(50.9411804, 8.6652491)),
  Mapping(
      name: "Niederaula, Niederaula",
      latlng: LatLng(50.812606599999995, 9.613123863633525)),
  Mapping(name: "Niederaula", latlng: LatLng(50.7961213, 9.5891659)),
  Mapping(name: "Niederauroff, Idstein", latlng: LatLng(50.2193063, 8.2339611)),
  Mapping(
      name: "Niederbeisheim, Knüllwald", latlng: LatLng(51.0413104, 9.524105)),
  Mapping(
      name: "Niederbieber, Hofbieber", latlng: LatLng(50.5806008, 9.8027669)),
  Mapping(
      name: "Niederbiel, Solms", latlng: LatLng(50.5594324, 8.393730873747536)),
  Mapping(
      name: "Niederbrechen, Brechen", latlng: LatLng(50.3624802, 8.1626224)),
  Mapping(
      name: "Niederdieten, Breidenbach", latlng: LatLng(50.8699732, 8.4416695)),
  Mapping(
      name: "Niederdorfelden, Niederdorfelden",
      latlng: LatLng(50.1932594, 8.8094674)),
  Mapping(name: "Niederdorfelden", latlng: LatLng(50.1941493, 8.8030419)),
  Mapping(
      name: "Niederdünzebach, Eschwege",
      latlng: LatLng(51.1775874, 10.0969583)),
  Mapping(
      name: "Niedereisenhausen, Steffenberg",
      latlng: LatLng(50.8402628, 8.4745797)),
  Mapping(
      name: "Niederellenbach, Alheim", latlng: LatLng(51.0415112, 9.6541462)),
  Mapping(
      name: "Niederelsungen, Wolfhagen", latlng: LatLng(51.3894686, 9.1893068)),
  Mapping(
      name: "Niederems, Waldems",
      latlng: LatLng(50.2559002, 8.348250648352808)),
  Mapping(name: "Niedergirmes, Wetzlar", latlng: LatLng(50.565262, 8.5039213)),
  Mapping(
      name: "Niedergladbach, Schlangenbad",
      latlng: LatLng(50.1045975, 7.9896216)),
  Mapping(
      name: "Niedergrenzebach, Schwalmstadt",
      latlng: LatLng(50.9134485, 9.2565104)),
  Mapping(
      name: "Niedergründau, Gründau", latlng: LatLng(50.2098239, 9.1052276)),
  Mapping(name: "Niedergude, Alheim", latlng: LatLng(51.0540443, 9.7044404)),
  Mapping(name: "Niederhadamar, Hadamar", latlng: LatLng(50.4353198, 8.03464)),
  Mapping(
      name: "Niederhöchstadt, Eschborn", latlng: LatLng(50.1568015, 8.5468189)),
  Mapping(
      name: "Niederhofheim, Liederbach",
      latlng: LatLng(50.12248125, 8.480875716385302)),
  Mapping(name: "Niederhone, Eschwege", latlng: LatLng(51.1993008, 10.0077392)),
  Mapping(
      name: "Niederhörlen, Steffenberg",
      latlng: LatLng(50.841671, 8.443926688156619)),
  Mapping(
      name: "Niederissigheim, Bruchköbel",
      latlng: LatLng(50.1936276, 8.9338346)),
  Mapping(
      name: "Niederjosbach, Eppstein", latlng: LatLng(50.1536144, 8.353288)),
  Mapping(
      name: "Niederjossa, Niederaula", latlng: LatLng(50.7751254, 9.5696401)),
  Mapping(
      name: "Niederkalbach, Kalbach",
      latlng: LatLng(50.4398465, 9.652780405078888)),
  Mapping(
      name: "Niederkaufungen, Kaufungen",
      latlng: LatLng(51.2843351, 9.5996904)),
  Mapping(
      name: "Niederkleen, Langgöns",
      latlng: LatLng(50.476603049999994, 8.599466618670721)),
  Mapping(
      name: "Niederklein, Stadtallendorf",
      latlng: LatLng(50.7940797, 8.9966347)),
  Mapping(
      name: "Niederlauken, Weilrod",
      latlng: LatLng(50.343858, 8.436099630344684)),
  Mapping(
      name: "Niederlemp, Ehringshausen",
      latlng: LatLng(50.65105185, 8.416557259848162)),
  Mapping(
      name: "Niederlibbach, Taunusstein",
      latlng: LatLng(50.2085242, 8.1719505)),
  Mapping(
      name: "Niederlistingen, Breuna", latlng: LatLng(51.448558, 9.2515897)),
  Mapping(
      name: "Niedermeilingen, Heidenrod",
      latlng: LatLng(50.1786853, 7.9000297)),
  Mapping(
      name: "Niedermeiser, Liebenau", latlng: LatLng(51.4589281, 9.3071754)),
  Mapping(
      name: "Niedermittlau, Hasselroth", latlng: LatLng(50.1696544, 9.1262328)),
  Mapping(
      name: "Niedermöllrich, Wabern", latlng: LatLng(51.1168188, 9.3660067)),
  Mapping(
      name: "Niedernhausen, Fischbachtal",
      latlng: LatLng(49.7739752, 8.8174333)),
  Mapping(name: "Niedernhausen", latlng: LatLng(50.1614795, 8.3175102)),
  Mapping(name: "Niedernhausen", latlng: LatLng(50.1614795, 8.3175102)),
  Mapping(name: "Niederorke, Vöhl", latlng: LatLng(51.1408344, 8.8471468)),
  Mapping(
      name: "Niederquembach, Schöffengrund",
      latlng: LatLng(50.4756246, 8.45781955479873)),
  Mapping(
      name: "Niederrad, Frankfurt am Main",
      latlng: LatLng(50.0882911, 8.6427072)),
  Mapping(
      name: "Niederreifenberg, Schmitten im Taunus",
      latlng: LatLng(50.24206595, 8.425680097586826)),
  Mapping(
      name: "Niederrode, Fulda",
      latlng: LatLng(50.52875295, 9.617348917663156)),
  Mapping(
      name: "Niederrodenbach, Rodenbach",
      latlng: LatLng(50.1435328, 9.0220949)),
  Mapping(
      name: "Niederroßbach, Haiger",
      latlng: LatLng(50.7918697, 8.222489866264837)),
  Mapping(
      name: "Niederscheld, Dillenburg",
      latlng: LatLng(50.7221447, 8.317282924536133)),
  Mapping(
      name: "Niederseelbach, Niedernhausen",
      latlng: LatLng(50.18310365, 8.277033660347445)),
  Mapping(name: "Niederselters", latlng: LatLng(50.3367531, 8.2262328)),
  Mapping(
      name: "Niedershausen, Löhnberg",
      latlng: LatLng(50.5413478, 8.25791597999362)),
  Mapping(
      name: "Niederthalhausen, Ludwigsau",
      latlng: LatLng(50.9479285, 9.6468315)),
  Mapping(
      name: "Niedertiefenbach, Beselich",
      latlng: LatLng(50.4427056, 8.1323938)),
  Mapping(
      name: "Niederurff, Bad Zwesten", latlng: LatLng(51.035733, 9.1918939)),
  Mapping(
      name: "Niederursel, Frankfurt am Main",
      latlng: LatLng(50.1690572, 8.6188761)),
  Mapping(
      name: "Niedervellmar, Vellmar", latlng: LatLng(51.3546889, 9.4789245)),
  Mapping(
      name: "Niedervorschütz, Felsberg", latlng: LatLng(51.1496657, 9.3828187)),
  Mapping(name: "Niederwald, Kirchhain", latlng: LatLng(50.8285651, 8.8789534)),
  Mapping(name: "Niederwalgern, Weimar", latlng: LatLng(50.7348091, 8.702876)),
  Mapping(name: "Niederwalluf, Walluf", latlng: LatLng(50.0351742, 8.1636638)),
  Mapping(
      name: "Niederweidbach, Bischoffen",
      latlng: LatLng(50.7143671, 8.483383710561288)),
  Mapping(name: "Niederweimar, Weimar", latlng: LatLng(50.7599776, 8.7311292)),
  Mapping(name: "Niederwetter, Wetter", latlng: LatLng(50.891634, 8.7478545)),
  Mapping(
      name: "Niederwetz, Schöffengrund",
      latlng: LatLng(50.4906141, 8.500552858821743)),
  Mapping(name: "Niederweyer, Hadamar", latlng: LatLng(50.4505736, 8.0804951)),
  Mapping(
      name: "Niederzell, Schlüchtern", latlng: LatLng(50.3301641, 9.5038497)),
  Mapping(
      name: "Niederzeuzheim, Hadamar", latlng: LatLng(50.4698775, 8.036972)),
  Mapping(name: "Niederzwehren, Kassel", latlng: LatLng(51.2861096, 9.4670127)),
  Mapping(name: "Nieste, Nieste", latlng: LatLng(51.3122935, 9.6709943)),
  Mapping(name: "Nieste", latlng: LatLng(51.3099456, 9.6522229)),
  Mapping(name: "Niestetal", latlng: LatLng(51.3186979, 9.586191)),
  Mapping(
      name: "Nonnenroth, Hungen",
      latlng: LatLng(50.51504985, 8.907811468894007)),
  Mapping(name: "Nonrod, Fischbachtal", latlng: LatLng(49.7548726, 8.8200798)),
  Mapping(name: "Nord-Holland, Kassel", latlng: LatLng(51.3305624, 9.4997836)),
  Mapping(
      name: "Nordeck, Allendorf (Lumda)",
      latlng: LatLng(50.6730566, 8.8377681)),
  Mapping(name: "Nordeck, Allendorf", latlng: LatLng(50.6911374, 8.8403359)),
  Mapping(name: "Nordenbeck, Korbach", latlng: LatLng(51.2404201, 8.839838)),
  Mapping(
      name: "Nordend, Frankfurt am Main",
      latlng: LatLng(50.1249197, 8.6923167)),
  Mapping(
      name: "Nordenstadt, Wiesbaden", latlng: LatLng(50.0629943, 8.3412428)),
  Mapping(name: "Nordheim, Biblis", latlng: LatLng(49.6812658, 8.3883867)),
  Mapping(name: "Nordshausen, Kassel", latlng: LatLng(51.2806979, 9.4323613)),
  Mapping(
      name: "Nösberts-Weidmoos, Grebenhain",
      latlng: LatLng(50.5138911, 9.3779487)),
  Mapping(name: "Nothfelden, Wolfhagen", latlng: LatLng(51.3523647, 9.2096329)),
  Mapping(name: "Nüst, Hünfeld", latlng: LatLng(50.64891625, 9.76233321302335)),
  Mapping(name: "Nüsttal", latlng: LatLng(50.6326438, 9.8629998)),
  Mapping(name: "Obbornhofen, Hungen", latlng: LatLng(50.4393931, 8.8337283)),
  Mapping(name: "Ober-Abtsteinach", latlng: LatLng(49.54389, 8.7839549)),
  Mapping(
      name: "Ober-Beerbach, Seeheim-Jugenheim",
      latlng: LatLng(49.7649332, 8.6856315)),
  Mapping(
      name: "Ober-Bessingen, Lich",
      latlng: LatLng(50.5364316, 8.904373676506896)),
  Mapping(
      name: "Ober-Breidenbach, Romrod", latlng: LatLng(50.6788186, 9.2308862)),
  Mapping(name: "Ober-Ense, Korbach", latlng: LatLng(51.2351913, 8.8399804)),
  Mapping(
      name: "Ober-Erlenbach, Bad Homburg vor der Höhe",
      latlng: LatLng(50.2269346, 8.6799368)),
  Mapping(
      name: "Ober-Eschbach, Bad Homburg vor der Höhe",
      latlng: LatLng(50.2162771, 8.6502192)),
  Mapping(
      name: "Ober-Florstadt, Florstadt", latlng: LatLng(50.3257847, 8.8748872)),
  Mapping(name: "Ober-Gleen, Kirtorf", latlng: LatLng(50.7565675, 9.1336651)),
  Mapping(
      name: "Ober-Hainbrunn, Oberzent", latlng: LatLng(49.490084, 8.9031019)),
  Mapping(
      name: "Ober-Hambach, Heppenheim", latlng: LatLng(49.6675058, 8.6884896)),
  Mapping(
      name: "Ober-Hörgern, Münzenberg", latlng: LatLng(50.4645777, 8.7500173)),
  Mapping(name: "Ober-Kainsbach", latlng: LatLng(49.7246516, 8.9018015)),
  Mapping(
      name: "Ober-Kinzig, Bad König", latlng: LatLng(49.7676761, 8.9454006)),
  Mapping(name: "Ober-Klein-Gumpen", latlng: LatLng(49.6893862, 8.8143986)),
  Mapping(name: "Ober-Klingen, Otzberg", latlng: LatLng(49.8098511, 8.8901492)),
  Mapping(name: "Ober-Lais, Nidda", latlng: LatLng(50.41845, 9.0994115)),
  Mapping(
      name: "Ober-Laudenbach, Heppenheim",
      latlng: LatLng(49.6143807, 8.6757891)),
  Mapping(
      name: "Ober-Liebersbach, Mörlenbach",
      latlng: LatLng(49.6051411, 8.7085413)),
  Mapping(
      name: "Ober-Mengelbach, Wald-Michelbach",
      latlng: LatLng(49.5833491, 8.7943169)),
  Mapping(
      name: "Ober-Mockstadt, Ranstadt", latlng: LatLng(50.3456105, 8.9647335)),
  Mapping(
      name: "Ober-Modau, Ober-Ramstadt",
      latlng: LatLng(49.78451655, 8.737442287258538)),
  Mapping(
      name: "Ober-Moos, Freiensteinau", latlng: LatLng(50.4571093, 9.366603)),
  Mapping(name: "Ober-Mörlen", latlng: LatLng(50.3726927, 8.6925312)),
  Mapping(name: "Ober-Mörlen", latlng: LatLng(50.3726927, 8.6925312)),
  Mapping(
      name: "Ober-Mossau, Mossautal", latlng: LatLng(49.6754826, 8.9254829)),
  Mapping(
      name: "Ober-Mumbach, Mörlenbach", latlng: LatLng(49.5781775, 8.7549775)),
  Mapping(name: "Ober-Nauses, Otzberg", latlng: LatLng(49.8085682, 8.9459943)),
  Mapping(
      name: "Ober-Ofleiden, Homberg (Ohm)",
      latlng: LatLng(50.7344881, 8.9806291)),
  Mapping(
      name: "Ober-Ofleiden, Homberg", latlng: LatLng(50.7344881, 8.9806291)),
  Mapping(name: "Ober-Ohmen, Mücke", latlng: LatLng(50.6168596, 9.1164453)),
  Mapping(
      name: "Ober-Ostern, Reichelsheim (Odenwald)",
      latlng: LatLng(49.6769211, 8.8500817)),
  Mapping(
      name: "Ober-Ostern, Reichelsheim", latlng: LatLng(49.6769211, 8.8500817)),
  Mapping(name: "Ober-Ramstadt", latlng: LatLng(49.8152, 8.7548)),
  Mapping(name: "Ober-Ramstadt", latlng: LatLng(49.8152, 8.7548)),
  Mapping(name: "Ober-Roden, Rödermark", latlng: LatLng(49.9766226, 8.8239353)),
  Mapping(
      name: "Ober-Rosbach, Rosbach vor der Höhe",
      latlng: LatLng(50.3044103, 8.6907103)),
  Mapping(
      name: "Ober-Scharbach, Grasellenbach",
      latlng: LatLng(49.6141589, 8.8270842)),
  Mapping(name: "Ober-Schmitten, Nidda", latlng: LatLng(50.4453332, 9.0335064)),
  Mapping(
      name: "Ober-Schönmattenwag, Wald-Michelbach",
      latlng: LatLng(49.5372178, 8.8640791)),
  Mapping(name: "Ober-Seemen, Gedern", latlng: LatLng(50.4189462, 9.2361711)),
  Mapping(
      name: "Ober-Seibertenrod, Ulrichstein",
      latlng: LatLng(50.5897819, 9.1581667)),
  Mapping(
      name: "Ober-Sensbach, Oberzent", latlng: LatLng(49.5623507, 9.015783)),
  Mapping(name: "Ober-Sorg, Schwalmtal", latlng: LatLng(50.6859307, 9.2987576)),
  Mapping(
      name: "Ober-Waroldern, Twistetal",
      latlng: LatLng(51.30236525, 8.96188023454377)),
  Mapping(name: "Ober-Wegfurth, Schlitz", latlng: LatLng(50.7473003, 9.579187)),
  Mapping(name: "Ober-Werbe, Waldeck", latlng: LatLng(51.2257506, 8.9824019)),
  Mapping(
      name: "Ober-Widdersheim, Nidda", latlng: LatLng(50.4259079, 8.9372186)),
  Mapping(
      name: "Ober-Wöllstadt, Wöllstadt", latlng: LatLng(50.2986821, 8.7510404)),
  Mapping(
      name: "Oberaschenbach, Nüsttal", latlng: LatLng(50.6553482, 9.8659984)),
  Mapping(
      name: "Oberasphe, Münchhausen", latlng: LatLng(50.9584839, 8.6480829)),
  Mapping(name: "Oberau, Altenstadt", latlng: LatLng(50.2749332, 8.946929)),
  Mapping(name: "Oberaula", latlng: LatLng(50.8440713, 9.4747704)),
  Mapping(name: "Oberaula", latlng: LatLng(50.8440713, 9.4747704)),
  Mapping(name: "Oberauroff, Idstein", latlng: LatLng(50.2131813, 8.2396699)),
  Mapping(
      name: "Oberbeisheim, Knüllwald", latlng: LatLng(51.0351862, 9.5000303)),
  Mapping(
      name: "Oberbernhards, Hilders", latlng: LatLng(50.5567588, 9.9025626)),
  Mapping(
      name: "Oberbiel, Solms", latlng: LatLng(50.5642879, 8.423411240264631)),
  Mapping(name: "Oberbrechen, Brechen", latlng: LatLng(50.3533117, 8.1971832)),
  Mapping(
      name: "Oberbreitzbach, Hohenroda", latlng: LatLng(50.8064773, 9.9216469)),
  Mapping(
      name: "Oberdieten, Breidenbach",
      latlng: LatLng(50.85501885, 8.407893423932386)),
  Mapping(
      name: "Oberdorfelden, Schöneck", latlng: LatLng(50.1957106, 8.8234313)),
  Mapping(
      name: "Oberdünzebach, Eschwege", latlng: LatLng(51.166321, 10.0761948)),
  Mapping(
      name: "Obereisenhausen, Steffenberg",
      latlng: LatLng(50.8328484, 8.4828707)),
  Mapping(name: "Oberellenbach, Alheim", latlng: LatLng(51.0257643, 9.6372201)),
  Mapping(
      name: "Oberelsungen, Zierenberg", latlng: LatLng(51.3754414, 9.2370466)),
  Mapping(
      name: "Oberems, Glashütten",
      latlng: LatLng(50.240471150000005, 8.40181765827572)),
  Mapping(
      name: "Oberfeld, Hünfeld",
      latlng: LatLng(50.650514900000005, 9.69695765984807)),
  Mapping(name: "Obergeis, Neuenstein", latlng: LatLng(50.9035001, 9.5959095)),
  Mapping(
      name: "Obergladbach, Schlangenbad",
      latlng: LatLng(50.0883794, 8.0143205)),
  Mapping(
      name: "Obergrenzebach, Frielendorf",
      latlng: LatLng(50.9195187, 9.3047464)),
  Mapping(name: "Obergruben, Hofbieber", latlng: LatLng(50.5916853, 9.9215231)),
  Mapping(name: "Obergude, Alheim", latlng: LatLng(51.0674357, 9.7131556)),
  Mapping(name: "Oberhaun, Hauneck", latlng: LatLng(50.8260385, 9.7263082)),
  Mapping(
      name: "Oberhöchstadt, Kronberg im Taunus",
      latlng: LatLng(50.1827449, 8.5410529)),
  Mapping(
      name: "Oberholzhausen, Haina (Kloster)",
      latlng: LatLng(51.0157525, 8.8894369)),
  Mapping(name: "Oberholzhausen, Haina", latlng: LatLng(51.0157525, 8.8894369)),
  Mapping(name: "Oberhone, Eschwege", latlng: LatLng(51.1849819, 10.0057329)),
  Mapping(
      name: "Oberhörlen, Steffenberg",
      latlng: LatLng(50.831248099999996, 8.415510483901775)),
  Mapping(
      name: "Oberissigheim, Bruchköbel", latlng: LatLng(50.1942424, 8.9536408)),
  Mapping(
      name: "Oberjosbach, Niedernhausen",
      latlng: LatLng(50.1717588, 8.337609746790644)),
  Mapping(
      name: "Oberjossa, Breitenbach am Herzberg",
      latlng: LatLng(50.7746602, 9.5447901)),
  Mapping(
      name: "Oberkalbach, Kalbach",
      latlng: LatLng(50.3997983, 9.682792916767806)),
  Mapping(
      name: "Oberkaufungen, Kaufungen", latlng: LatLng(51.2804769, 9.6307773)),
  Mapping(
      name: "Oberkleen, Langgöns",
      latlng: LatLng(50.46267225, 8.58012899311665)),
  Mapping(
      name: "Oberlauken, Weilrod",
      latlng: LatLng(50.330783499999995, 8.433174060086571)),
  Mapping(
      name: "Oberlemp, Aßlar", latlng: LatLng(50.64641665, 8.45180209656645)),
  Mapping(
      name: "Oberlengsfeld, Schenklengsfeld",
      latlng: LatLng(50.8213974, 9.8604678)),
  Mapping(
      name: "Oberlibbach, Hünstetten", latlng: LatLng(50.2070066, 8.1920944)),
  Mapping(
      name: "Oberliederbach, Liederbach",
      latlng: LatLng(50.118533, 8.499263975316083)),
  Mapping(name: "Oberlistingen, Breuna", latlng: LatLng(51.4439621, 9.2365966)),
  Mapping(
      name: "Obermeilingen, Heidenrod", latlng: LatLng(50.1773155, 7.9098784)),
  Mapping(
      name: "Obermeiser, Calden",
      latlng: LatLng(51.4396275, 9.312518188079977)),
  Mapping(
      name: "Obermelsungen, Melsungen", latlng: LatLng(51.1185456, 9.5321874)),
  Mapping(
      name: "Obermöllrich, Fritzlar", latlng: LatLng(51.1287853, 9.3177343)),
  Mapping(name: "Obernburg, Vöhl", latlng: LatLng(51.2315438, 8.9052065)),
  Mapping(name: "Oberndorf, Jossgrund", latlng: LatLng(50.1916157, 9.4730002)),
  Mapping(
      name: "Oberndorf, Siegbach",
      latlng: LatLng(50.750960449999994, 8.412629524022192)),
  Mapping(
      name: "Oberndorf, Solms", latlng: LatLng(50.52142155, 8.424083974859471)),
  Mapping(name: "Oberndorf, Wetter", latlng: LatLng(50.901092, 8.6714421)),
  Mapping(name: "Obernhain, Wehrheim", latlng: LatLng(50.2791011, 8.5436136)),
  Mapping(
      name: "Obernhausen, Fischbachtal", latlng: LatLng(49.7713852, 8.8081796)),
  Mapping(
      name: "Obernhausen, Gersfeld (Rhön)",
      latlng: LatLng(50.487128, 9.951545849667777)),
  Mapping(
      name: "Obernhausen, Gersfeld",
      latlng: LatLng(50.487128, 9.951545849667777)),
  Mapping(name: "Obernüst, Hofbieber", latlng: LatLng(50.6163172, 9.9362178)),
  Mapping(name: "Oberorke, Vöhl", latlng: LatLng(51.1359475, 8.8454031)),
  Mapping(
      name: "Oberquembach, Schöffengrund",
      latlng: LatLng(50.4658085, 8.479903127137874)),
  Mapping(
      name: "Oberrad, Frankfurt am Main",
      latlng: LatLng(50.0997339, 8.7229146)),
  Mapping(
      name: "Oberreichenbach, Birstein", latlng: LatLng(50.3812376, 9.3267116)),
  Mapping(
      name: "Oberreifenberg, Schmitten im Taunus",
      latlng: LatLng(50.2469418, 8.439970433265547)),
  Mapping(
      name: "Oberrieden, Bad Sooden-Allendorf",
      latlng: LatLng(51.3089124, 9.9267207)),
  Mapping(
      name: "Oberrode, Fulda", latlng: LatLng(50.5367661, 9.586954500407884)),
  Mapping(
      name: "Oberrodenbach, Rodenbach", latlng: LatLng(50.1380943, 9.0570093)),
  Mapping(
      name: "Oberrombach, Hünfeld",
      latlng: LatLng(50.657755699999996, 9.684853142233955)),
  Mapping(name: "Oberrosphe, Wetter", latlng: LatLng(50.9121671, 8.7769754)),
  Mapping(
      name: "Oberroßbach, Haiger",
      latlng: LatLng(50.80083875, 8.246198188083723)),
  Mapping(
      name: "Oberscheld, Dillenburg",
      latlng: LatLng(50.74039645, 8.363510387301536)),
  Mapping(
      name: "Oberseelbach, Niedernhausen",
      latlng: LatLng(50.1871276, 8.2974188)),
  Mapping(
      name: "Oberselters, Bad Camberg", latlng: LatLng(50.3218805, 8.2433764)),
  Mapping(
      name: "Obershausen, Löhnberg",
      latlng: LatLng(50.56572195, 8.233281520836293)),
  Mapping(name: "Obersotzbach, Birstein", latlng: LatLng(50.347635, 9.3276056)),
  Mapping(
      name: "Oberstedten, Oberursel (Taunus)",
      latlng: LatLng(50.226402, 8.5749105)),
  Mapping(name: "Oberstedten, Oberursel", latlng: LatLng(50.226402, 8.5749105)),
  Mapping(name: "Oberstoppel, Haunetal", latlng: LatLng(50.7556062, 9.7135669)),
  Mapping(name: "Obersuhl, Wildeck", latlng: LatLng(50.9512943, 10.0334353)),
  Mapping(
      name: "Oberthalhausen, Ludwigsau", latlng: LatLng(50.9432508, 9.6247027)),
  Mapping(
      name: "Obertiefenbach, Beselich", latlng: LatLng(50.458346, 8.1226551)),
  Mapping(
      name: "Obertshausen, Obertshausen",
      latlng: LatLng(50.0735309, 8.8474665)),
  Mapping(name: "Obertshausen", latlng: LatLng(50.0731304, 8.8732839)),
  Mapping(
      name: "Oberurff-Schiffelborn, Bad Zwesten",
      latlng: LatLng(51.0364603, 9.1556033)),
  Mapping(name: "Oberursel (Taunus)", latlng: LatLng(50.2005518, 8.580452)),
  Mapping(name: "Oberursel", latlng: LatLng(50.2005518, 8.580452)),
  Mapping(name: "Obervellmar, Vellmar", latlng: LatLng(51.3619253, 9.4578336)),
  Mapping(
      name: "Obervorschütz, Gudensberg", latlng: LatLng(51.1631844, 9.3528805)),
  Mapping(name: "Oberwald, Grebenhain", latlng: LatLng(50.4849084, 9.3097388)),
  Mapping(
      name: "Oberwalgern, Fronhausen", latlng: LatLng(50.7107626, 8.6655668)),
  Mapping(name: "Oberwalluf, Walluf", latlng: LatLng(50.0419428, 8.1424222)),
  Mapping(
      name: "Oberweidbach, Bischoffen",
      latlng: LatLng(50.72569195, 8.517588283953291)),
  Mapping(name: "Oberweimar, Weimar", latlng: LatLng(50.9658653, 11.3465187)),
  Mapping(
      name: "Oberweisenborn, Eiterfeld",
      latlng: LatLng(50.78551885, 9.827240395202722)),
  Mapping(
      name: "Oberwetz, Schöffengrund",
      latlng: LatLng(50.4741012, 8.515967451730956)),
  Mapping(name: "Oberweyer, Hadamar", latlng: LatLng(50.4583379, 8.0929227)),
  Mapping(name: "Oberzell, Sinntal", latlng: LatLng(50.3328731, 9.711804)),
  Mapping(name: "Oberzent", latlng: LatLng(49.5509448, 8.9860959)),
  Mapping(name: "Oberzeuzheim, Hadamar", latlng: LatLng(50.4745637, 8.0615606)),
  Mapping(name: "Oberzwehren, Kassel", latlng: LatLng(51.2739192, 9.4483787)),
  Mapping(name: "Ochshausen, Lohfelden", latlng: LatLng(51.2808616, 9.5531878)),
  Mapping(
      name: "Ockershausen [22], Marburg",
      latlng: LatLng(50.8024137, 8.7468543)),
  Mapping(name: "Ockstadt, Friedberg", latlng: LatLng(50.3327492, 8.7217099)),
  Mapping(
      name: "Odenhausen (Lahn), Lollar", latlng: LatLng(50.6734028, 8.706163)),
  Mapping(
      name: "Odenhausen (Lumda), Rabenau",
      latlng: LatLng(50.6618543, 8.8904731)),
  Mapping(name: "Odenhausen, Lollar", latlng: LatLng(50.6746286, 8.7027457)),
  Mapping(
      name: "Odenhausen, Rabenau",
      latlng: LatLng(50.663719549999996, 8.906782742659324)),
  Mapping(name: "Odensachsen, Haunetal", latlng: LatLng(50.7981733, 9.7162563)),
  Mapping(name: "Odersbach, Weilburg", latlng: LatLng(50.4763983, 8.2460265)),
  Mapping(
      name: "Odersberg, Greifenstein",
      latlng: LatLng(50.5979888, 8.204674548656456)),
  Mapping(
      name: "Odershausen, Bad Wildungen",
      latlng: LatLng(51.0868861, 9.1100931)),
  Mapping(name: "Oedelsheim, Wesertal", latlng: LatLng(51.5896633, 9.5971953)),
  Mapping(
      name: "Oelshausen, Zierenberg", latlng: LatLng(51.3137115, 9.2617799)),
  Mapping(name: "Oestrich-Winkel", latlng: LatLng(50.0071863, 8.0167585)),
  Mapping(
      name: "Oestrich, Oestrich-Winkel", latlng: LatLng(50.0029526, 8.020638)),
  Mapping(
      name: "Oetmannshausen, Wehretal", latlng: LatLng(51.1396211, 9.9733345)),
  Mapping(
      name: "Offdilln, Haiger", latlng: LatLng(50.8312235, 8.235345643385312)),
  Mapping(name: "Offenbach am Main", latlng: LatLng(50.1055002, 8.7610698)),
  Mapping(name: "Offenbach am Main", latlng: LatLng(50.1055002, 8.7610698)),
  Mapping(
      name: "Offenbach, Mittenaar",
      latlng: LatLng(50.69003945, 8.417803172890398)),
  Mapping(name: "Offenthal, Dreieich", latlng: LatLng(49.9808356, 8.743481)),
  Mapping(
      name: "Offheim, Limburg an der Lahn",
      latlng: LatLng(50.4151195, 8.0612742)),
  Mapping(name: "Ohmes, Antrifttal", latlng: LatLng(50.76882, 9.1754362)),
  Mapping(name: "Ohren, Hünfelden", latlng: LatLng(50.2997124, 8.1869789)),
  Mapping(name: "Okarben, Karben", latlng: LatLng(50.250355, 8.7544001)),
  Mapping(
      name: "Okriftel, Hattersheim am Main",
      latlng: LatLng(50.0557639, 8.494348826627965)),
  Mapping(name: "Olberode, Oberaula", latlng: LatLng(50.8550719, 9.422407)),
  Mapping(name: "Olfen, Oberzent", latlng: LatLng(49.594582, 8.892685)),
  Mapping(
      name: "Oppenrod, Buseck", latlng: LatLng(50.5806113, 8.796206088097287)),
  Mapping(
      name: "Oppershofen, Rockenberg", latlng: LatLng(50.4168087, 8.7439454)),
  Mapping(name: "Opperz [23], Neuhof", latlng: LatLng(50.4496512, 9.6224726)),
  Mapping(
      name: "Orferode, Bad Sooden-Allendorf",
      latlng: LatLng(51.2570374, 9.935433493896891)),
  Mapping(name: "Orlen, Taunusstein", latlng: LatLng(50.1812046, 8.1864035)),
  Mapping(name: "Orleshausen, Büdingen", latlng: LatLng(50.2858041, 9.0695249)),
  Mapping(name: "Orpethal, Diemelstadt", latlng: LatLng(51.493903, 8.9596557)),
  Mapping(name: "Ortenberg", latlng: LatLng(50.35836, 9.08399)),
  Mapping(name: "Ortenberg", latlng: LatLng(50.35836, 9.08399)),
  Mapping(name: "Ossenheim, Friedberg", latlng: LatLng(50.3256488, 8.7943196)),
  Mapping(
      name: "Ostend, Frankfurt am Main", latlng: LatLng(50.1123728, 8.6999671)),
  Mapping(
      name: "Osterfeld, Allendorf (Eder)",
      latlng: LatLng(51.0257606, 8.6769164)),
  Mapping(
      name: "Osterfeld, Allendorf",
      latlng: LatLng(51.0474456, 8.666579897729072)),
  Mapping(name: "Ostheim, Butzbach", latlng: LatLng(50.4034237, 8.6720343)),
  Mapping(name: "Ostheim, Liebenau", latlng: LatLng(51.506111, 9.321111)),
  Mapping(name: "Ostheim, Malsfeld", latlng: LatLng(51.0795893, 9.4803874)),
  Mapping(name: "Ostheim, Nidderau", latlng: LatLng(50.2242431, 8.9084478)),
  Mapping(
      name: "Otterbach, Gemünden (Felda)",
      latlng: LatLng(50.6936699, 9.0892488)),
  Mapping(name: "Otterbach, Gemünden", latlng: LatLng(50.6936699, 9.0892488)),
  Mapping(name: "Ottlar, Diemelsee", latlng: LatLng(51.331659, 8.6994499)),
  Mapping(name: "Ottrau", latlng: LatLng(50.8131253, 9.4018363)),
  Mapping(name: "Ottrau", latlng: LatLng(50.8131253, 9.4018363)),
  Mapping(name: "Otzberg", latlng: LatLng(49.8261, 8.9225)),
  Mapping(name: "Panrod, Aarbergen", latlng: LatLng(50.2554163, 8.1320879)),
  Mapping(
      name: "Papierfabrik, Kaufungen", latlng: LatLng(51.290948, 9.5678024)),
  Mapping(
      name: "Petersberg, Bad Hersfeld", latlng: LatLng(50.8630426, 9.7452139)),
  Mapping(name: "Petersberg", latlng: LatLng(49.2389365, 7.5657698)),
  Mapping(name: "Petersberg", latlng: LatLng(49.2389365, 7.5657698)),
  Mapping(name: "Petersweiher, Gießen", latlng: LatLng(50.5488816, 8.7181977)),
  Mapping(
      name: "Petterweil, Karben",
      latlng: LatLng(50.24027535, 8.70972909565813)),
  Mapping(
      name: "Pfaffenhausen, Borken (Hessen)",
      latlng: LatLng(51.025004, 9.3155206)),
  Mapping(name: "Pfaffenhausen, Borken", latlng: LatLng(51.025004, 9.3155206)),
  Mapping(
      name: "Pfaffenhausen, Jossgrund", latlng: LatLng(50.1691972, 9.4738775)),
  Mapping(name: "Pfaffenrod, Hosenfeld", latlng: LatLng(50.4883139, 9.4726339)),
  Mapping(
      name: "Pfaffenwiesbach, Wehrheim", latlng: LatLng(50.3299066, 8.6113178)),
  Mapping(name: "Pfieffe, Spangenberg", latlng: LatLng(51.1122358, 9.7353387)),
  Mapping(
      name: "Pfirschbach, Höchst i. Odw.",
      latlng: LatLng(49.7909198, 8.9606627)),
  Mapping(name: "Pfordt, Schlitz", latlng: LatLng(50.6578503, 9.599137)),
  Mapping(name: "Pfungstadt", latlng: LatLng(49.7943, 8.5877)),
  Mapping(name: "Pfungstadt", latlng: LatLng(49.7943, 8.5877)),
  Mapping(
      name: "Philippinenburg und -thal, Wolfhagen",
      latlng: LatLng(51.33010470000001, 9.21535010415109)),
  Mapping(
      name: "Philippinenhof-Warteberg, Kassel",
      latlng: LatLng(51.3453537, 9.4924152)),
  Mapping(
      name: "Philippstein, Braunfels",
      latlng: LatLng(50.48814695, 8.380534614211715)),
  Mapping(name: "Philippsthal (Werra)", latlng: LatLng(50.8456736, 9.980251)),
  Mapping(name: "Philippsthal", latlng: LatLng(50.8456736, 9.980251)),
  Mapping(
      name: "Pilgerzell, Künzell",
      latlng: LatLng(50.515405, 9.735236879745779)),
  Mapping(name: "Pohl-Göns, Butzbach", latlng: LatLng(50.4615397, 8.6507954)),
  Mapping(name: "Pohlheim", latlng: LatLng(50.5165524, 8.7345921)),
  Mapping(
      name: "Poppenhausen (Wasserkuppe)",
      latlng: LatLng(50.5012321, 9.8892457)),
  Mapping(name: "Poppenhausen", latlng: LatLng(50.5012321, 9.8892457)),
  Mapping(name: "Poppenrod, Hosenfeld", latlng: LatLng(50.4978791, 9.4695793)),
  Mapping(
      name: "Praunheim, Frankfurt am Main",
      latlng: LatLng(50.1507958, 8.6215134)),
  Mapping(
      name: "Presberg, Rüdesheim am Rhein",
      latlng: LatLng(50.0517044, 7.8926616)),
  Mapping(
      name: "Preungesheim, Frankfurt am Main",
      latlng: LatLng(50.1565402, 8.6878166)),
  Mapping(
      name: "Preußisch Radmühl (Radmühl II), Freiensteinau",
      latlng: LatLng(50.4051737, 9.35902028924716)),
  Mapping(
      name: "Preußisch Radmühl, Freiensteinau",
      latlng: LatLng(50.4023938, 9.3583678)),
  Mapping(
      name: "Probbach, Mengerskirchen",
      latlng: LatLng(50.55093755, 8.196397216005867)),
  Mapping(name: "Queck, Schlitz", latlng: LatLng(50.7141798, 9.578497)),
  Mapping(
      name: "Queckborn, Grünberg",
      latlng: LatLng(50.57335825, 8.92766656703721)),
  Mapping(
      name: "Quentel, Hessisch Lichtenau",
      latlng: LatLng(51.198576, 9.6488284)),
  Mapping(
      name: "Quotshausen, Steffenberg", latlng: LatLng(50.8541964, 8.4670633)),
  Mapping(name: "Rabenau", latlng: LatLng(50.9631279, 13.6418236)),
  Mapping(
      name: "Rabenscheid, Breitscheid",
      latlng: LatLng(50.6816357, 8.142477828745367)),
  Mapping(
      name: "Rabenstein, Steinau an der Straße",
      latlng: LatLng(50.3775239, 9.3744591)),
  Mapping(
      name: "Rabertshausen, Hungen",
      latlng: LatLng(50.45794025, 8.97311703673386)),
  Mapping(
      name: "Raboldshausen, Neuenstein", latlng: LatLng(50.9139667, 9.5267372)),
  Mapping(
      name: "Rachelshausen, Gladenbach", latlng: LatLng(50.7880815, 8.5297445)),
  Mapping(name: "Radheim, Schaafheim", latlng: LatLng(49.8895407, 9.0158)),
  Mapping(
      name: "Radmühl, Freiensteinau", latlng: LatLng(50.4060081, 9.3634146)),
  Mapping(
      name: "Rai-Breitenbach, Breuberg", latlng: LatLng(49.8142189, 9.0527477)),
  Mapping(
      name: "Raibach, Groß-Umstadt",
      latlng: LatLng(49.87221795, 8.957503453733384)),
  Mapping(name: "Raidelbach, Lautertal", latlng: LatLng(49.709349, 8.7352499)),
  Mapping(name: "Rainrod, Schotten", latlng: LatLng(50.4703361, 9.0766052)),
  Mapping(name: "Rainrod, Schwalmtal", latlng: LatLng(50.7153078, 9.3339039)),
  Mapping(name: "Rambach, Weißenborn", latlng: LatLng(51.1078323, 10.1478878)),
  Mapping(name: "Rambach, Wiesbaden", latlng: LatLng(50.1173526, 8.2738279)),
  Mapping(name: "Ramholz, Schlüchtern", latlng: LatLng(50.3308134, 9.6110119)),
  Mapping(
      name: "Ramschied, Bad Schwalbach", latlng: LatLng(50.1345747, 8.0353)),
  Mapping(name: "Ransbach, Hohenroda", latlng: LatLng(50.8268804, 9.9102838)),
  Mapping(
      name: "Ransbach, Willingshausen", latlng: LatLng(50.8870976, 9.2291504)),
  Mapping(name: "Ransel, Lorch", latlng: LatLng(50.1018793, 7.8420122)),
  Mapping(name: "Ranselberg, Lorch", latlng: LatLng(50.0637545, 7.8331823)),
  Mapping(name: "Ranstadt", latlng: LatLng(50.36683, 8.992065432702923)),
  Mapping(name: "Ranstadt", latlng: LatLng(50.36683, 8.992065432702923)),
  Mapping(name: "Rasdorf", latlng: LatLng(50.7120413, 9.8854058)),
  Mapping(name: "Rasdorf", latlng: LatLng(50.7120413, 9.8854058)),
  Mapping(name: "Raßdorf, Wildeck", latlng: LatLng(50.9463855, 9.9766182)),
  Mapping(
      name: "Rattlar, Willingen (Upland)",
      latlng: LatLng(51.3108593, 8.6482642)),
  Mapping(name: "Rattlar, Willingen", latlng: LatLng(51.3108593, 8.6482642)),
  Mapping(name: "Raubach, Oberzent", latlng: LatLng(49.5572781, 8.886513)),
  Mapping(
      name: "Rauenthal, Eltville am Rhein",
      latlng: LatLng(50.0605525, 8.1102994)),
  Mapping(
      name: "Rauischholzhausen, Ebsdorfergrund",
      latlng: LatLng(50.7597693, 8.881992)),
  Mapping(name: "Raunheim, Raunheim", latlng: LatLng(50.0099033, 8.4550667)),
  Mapping(name: "Raunheim", latlng: LatLng(50.0096998, 8.4498124)),
  Mapping(name: "Rauschenberg", latlng: LatLng(50.8833043, 8.9166685)),
  Mapping(name: "Rauschenberg", latlng: LatLng(50.8833043, 8.9166685)),
  Mapping(name: "Rautenhausen, Bebra", latlng: LatLng(51.0243836, 9.8308588)),
  Mapping(name: "Ravolzhausen, Neuberg", latlng: LatLng(50.1888915, 8.9922915)),
  Mapping(
      name: "Rebgeshain, Ulrichstein", latlng: LatLng(50.5702021, 9.2366033)),
  Mapping(
      name: "Rebsdorf, Steinau an der Straße",
      latlng: LatLng(50.3885417, 9.3686591)),
  Mapping(
      name: "Rechtebach, Waldkappel", latlng: LatLng(51.1157876, 9.8723499)),
  Mapping(
      name: "Rechtenbach, Hüttenberg",
      latlng: LatLng(50.5203934, 8.564123535128953)),
  Mapping(name: "Reckerode, Kirchheim", latlng: LatLng(50.8623319, 9.5977195)),
  Mapping(
      name: "Reckrod, Eiterfeld",
      latlng: LatLng(50.7749429, 9.790965402041532)),
  Mapping(name: "Reddehausen, Cölbe", latlng: LatLng(50.879564, 8.8014686)),
  Mapping(
      name: "Reddighausen, Hatzfeld (Eder)",
      latlng: LatLng(51.0105717, 8.5881731)),
  Mapping(
      name: "Reddighausen, Hatzfeld", latlng: LatLng(51.0105717, 8.5881731)),
  Mapping(
      name: "Reddingshausen, Knüllwald", latlng: LatLng(50.9869456, 9.469098)),
  Mapping(name: "Rehbach, Michelstadt", latlng: LatLng(49.7071993, 8.9525575)),
  Mapping(name: "Reibertenrod, Alsfeld", latlng: LatLng(50.7689334, 9.2558538)),
  Mapping(
      name: "Reichelsheim (Odenwald)",
      latlng: LatLng(49.70043805, 8.84782296118301)),
  Mapping(
      name: "Reichelsheim (Wetterau)", latlng: LatLng(50.3580243, 8.8744648)),
  Mapping(name: "Reichelsheim", latlng: LatLng(50.3611717, 8.8207006)),
  Mapping(
      name: "Reichenbach, Hessisch Lichtenau",
      latlng: LatLng(51.1628101, 9.776685)),
  Mapping(
      name: "Reichenbach, Waldems",
      latlng: LatLng(50.27125445, 8.380743083434528)),
  Mapping(name: "Reichenbach", latlng: LatLng(50.6219793, 12.305088373514671)),
  Mapping(name: "Reichenborn, Merenberg", latlng: LatLng(50.53095, 8.1765587)),
  Mapping(
      name: "Reichensachsen, Wehretal", latlng: LatLng(51.1519879, 9.9981689)),
  Mapping(
      name: "Reichlos, Freiensteinau", latlng: LatLng(50.4609058, 9.4268344)),
  Mapping(name: "Reilos, Ludwigsau", latlng: LatLng(50.9087586, 9.7413937)),
  Mapping(
      name: "Reimboldshausen, Kirchheim",
      latlng: LatLng(50.8190186, 9.5322704)),
  Mapping(name: "Reimenrod, Grebenau", latlng: LatLng(50.743459, 9.428033)),
  Mapping(name: "Reimershausen, Lohra", latlng: LatLng(50.7049268, 8.6410904)),
  Mapping(name: "Reinborn, Waldems", latlng: LatLng(50.2618504, 8.3562621)),
  Mapping(
      name: "Reinhards, Freiensteinau", latlng: LatLng(50.4399074, 9.4449665)),
  Mapping(name: "Reinhardshagen", latlng: LatLng(51.4840743, 9.6064345)),
  Mapping(
      name: "Reinhardshain, Grünberg",
      latlng: LatLng(50.6218354, 8.899117515194753)),
  Mapping(
      name: "Reinhardshausen, Bad Wildungen",
      latlng: LatLng(51.1128665, 9.0744705)),
  Mapping(name: "Reinheim", latlng: LatLng(49.8364879, 8.8238238)),
  Mapping(name: "Reinheim", latlng: LatLng(49.8364879, 8.8238238)),
  Mapping(name: "Reisen", latlng: LatLng(51.7863742, 16.6673223)),
  Mapping(
      name: "Reiskirchen, Hüttenberg",
      latlng: LatLng(50.51085005, 8.519278929298281)),
  Mapping(name: "Reiskirchen", latlng: LatLng(50.5967731, 8.8281513)),
  Mapping(name: "Reiskirchen", latlng: LatLng(50.5967731, 8.8281513)),
  Mapping(
      name: "Reith, Schlüchtern",
      latlng: LatLng(50.36114005, 9.52692811308086)),
  Mapping(
      name: "Reitzenhagen, Bad Wildungen",
      latlng: LatLng(51.1254912, 9.1057282)),
  Mapping(
      name: "Relbehausen, Homberg (Efze)",
      latlng: LatLng(51.0147924, 9.4542238)),
  Mapping(name: "Relbehausen, Homberg", latlng: LatLng(51.0147924, 9.4542238)),
  Mapping(
      name: "Rembrücken, Heusenstamm", latlng: LatLng(50.0493284, 8.8549793)),
  Mapping(name: "Remsfeld, Knüllwald", latlng: LatLng(51.0017454, 9.4699121)),
  Mapping(name: "Renda, Ringgau", latlng: LatLng(51.0674851, 10.0763463)),
  Mapping(name: "Rendel, Karben", latlng: LatLng(50.214887, 8.7927112)),
  Mapping(
      name: "Rengersfeld, Gersfeld (Rhön)",
      latlng: LatLng(50.4297582, 9.9133717)),
  Mapping(name: "Rengersfeld, Gersfeld", latlng: LatLng(50.4297582, 9.9133717)),
  Mapping(
      name: "Rengershausen, Baunatal", latlng: LatLng(51.2562517, 9.4510055)),
  Mapping(
      name: "Rengershausen, Frankenberg (Eder)",
      latlng: LatLng(51.1064036, 8.7016811)),
  Mapping(
      name: "Rengershausen, Frankenberg",
      latlng: LatLng(51.1064036, 8.7016811)),
  Mapping(
      name: "Rengshausen, Knüllwald", latlng: LatLng(51.0055128, 9.5366305)),
  Mapping(
      name: "Rennertehausen, Allendorf (Eder)",
      latlng: LatLng(51.0248604, 8.6903673)),
  Mapping(
      name: "Rennertehausen, Allendorf", latlng: LatLng(51.0248604, 8.6903673)),
  Mapping(
      name: "Renzendorf, Schwalmtal", latlng: LatLng(50.7028439, 9.3098359)),
  Mapping(name: "Reptich, Jesberg", latlng: LatLng(51.0150057, 9.1765341)),
  Mapping(
      name: "Retterode, Hessisch Lichtenau",
      latlng: LatLng(51.1734528, 9.722374)),
  Mapping(
      name: "Reulbach, Ehrenberg (Rhön)",
      latlng: LatLng(50.5100171, 9.967655185428448)),
  Mapping(
      name: "Reulbach, Ehrenberg",
      latlng: LatLng(50.5100171, 9.967655185428448)),
  Mapping(name: "Reuters, Lauterbach", latlng: LatLng(50.674148, 9.3506547)),
  Mapping(name: "Rex, Petersberg", latlng: LatLng(50.5592323, 9.7575829)),
  Mapping(
      name: "Rhadern, Lichtenfels (Hessen)",
      latlng: LatLng(51.1703245, 8.7970646)),
  Mapping(name: "Rhadern, Lichtenfels", latlng: LatLng(51.1703245, 8.7970646)),
  Mapping(name: "Rhena, Korbach", latlng: LatLng(51.2890745, 8.793521)),
  Mapping(name: "Rhenegge, Diemelsee", latlng: LatLng(51.3593954, 8.7714447)),
  Mapping(name: "Rhina, Haunetal", latlng: LatLng(50.7645341, 9.6823319)),
  Mapping(name: "Rhöda, Breuna", latlng: LatLng(51.4093451, 9.1582718)),
  Mapping(name: "Rhoden, Diemelstadt", latlng: LatLng(51.4747814, 9.0098014)),
  Mapping(name: "Rhünda, Felsberg", latlng: LatLng(51.1136647, 9.4132213)),
  Mapping(name: "Richelsdorf, Wildeck", latlng: LatLng(50.9753362, 10.0099373)),
  Mapping(name: "Richen, Groß-Umstadt", latlng: LatLng(49.8865634, 8.92426)),
  Mapping(name: "Richerode, Jesberg", latlng: LatLng(50.9807666, 9.117431)),
  Mapping(
      name: "Riebelsdorf, Neukirchen", latlng: LatLng(50.8785147, 9.3092578)),
  Mapping(name: "Ried, Ebersburg", latlng: LatLng(50.4588687, 9.7679398)),
  Mapping(name: "Riedbahn, Weiterstadt", latlng: LatLng(49.8914619, 8.6135779)),
  Mapping(name: "Riede, Bad Emstal", latlng: LatLng(51.2081037, 9.2558204)),
  Mapping(
      name: "Riedelbach, Weilrod",
      latlng: LatLng(50.29888345, 8.372773393667458)),
  Mapping(
      name: "Riederwald, Frankfurt am Main",
      latlng: LatLng(50.1288376, 8.7331285)),
  Mapping(name: "Riedrode, Bürstadt", latlng: LatLng(49.6492278, 8.4944687)),
  Mapping(name: "Riedstadt", latlng: LatLng(49.8425212, 8.4829447)),
  Mapping(name: "Rimbach [24], Rimbach", latlng: LatLng(47.8919911, 7.1900164)),
  Mapping(name: "Rimbach, Schlitz", latlng: LatLng(50.7288496, 9.5801881)),
  Mapping(name: "Rimbach", latlng: LatLng(49.2282346, 12.8844649)),
  Mapping(name: "Rimhorn, Lützelbach", latlng: LatLng(49.7848445, 9.0376924)),
  Mapping(name: "Rimlos, Lauterbach", latlng: LatLng(50.6456324, 9.3775264)),
  Mapping(
      name: "Rimmels, Nüsttal",
      latlng: LatLng(50.623259000000004, 9.81907885652513)),
  Mapping(name: "Rinderbügen, Büdingen", latlng: LatLng(50.3157776, 9.1868695)),
  Mapping(name: "Ringgau", latlng: LatLng(51.0841794, 10.0694213)),
  Mapping(
      name: "Rittershausen, Dietzhölztal",
      latlng: LatLng(50.8573329, 8.268098019249127)),
  Mapping(
      name: "Rittmannshausen, Ringgau", latlng: LatLng(51.0884849, 10.1308676)),
  Mapping(name: "Rixfeld, Herbstein", latlng: LatLng(50.5789683, 9.3816909)),
  Mapping(name: "Rockenberg", latlng: LatLng(50.4301053, 8.7371043)),
  Mapping(name: "Rockenberg", latlng: LatLng(50.4301053, 8.7371043)),
  Mapping(name: "Rockensüß, Cornberg", latlng: LatLng(51.0524348, 9.8527913)),
  Mapping(name: "Rockshausen, Wabern", latlng: LatLng(51.0777297, 9.4115721)),
  Mapping(
      name: "Rod am Berg, Neu-Anspach", latlng: LatLng(50.3000966, 8.4895752)),
  Mapping(
      name: "Rod an der Weil, Weilrod",
      latlng: LatLng(50.33740485, 8.385291962337387)),
  Mapping(
      name: "Roda, Rosenthal (Hessen)", latlng: LatLng(50.9780042, 8.7791163)),
  Mapping(name: "Roda, Rosenthal", latlng: LatLng(50.9780042, 8.7791163)),
  Mapping(name: "Rodau, Groß-Bieberau", latlng: LatLng(49.7805373, 8.7927726)),
  Mapping(
      name: "Rodau, Zwingenberg (Bergstraße)",
      latlng: LatLng(49.7187117, 8.5797925)),
  Mapping(name: "Rodau, Zwingenberg", latlng: LatLng(49.7187117, 8.5797925)),
  Mapping(
      name: "Röddenau, Frankenberg (Eder)",
      latlng: LatLng(51.0464291, 8.7522497)),
  Mapping(name: "Röddenau, Frankenberg", latlng: LatLng(51.0464291, 8.7522497)),
  Mapping(name: "Rodebach, Waldkappel", latlng: LatLng(51.176567, 9.8698801)),
  Mapping(
      name: "Rödelheim, Frankfurt am Main",
      latlng: LatLng(50.1249843, 8.6125536)),
  Mapping(
      name: "Rodemann, Homberg (Efze)", latlng: LatLng(50.990683, 9.420116)),
  Mapping(name: "Rodemann, Homberg", latlng: LatLng(50.990683, 9.420116)),
  Mapping(name: "Rodenbach, Altenstadt", latlng: LatLng(50.3009183, 8.9547656)),
  Mapping(
      name: "Rodenbach, Frankenberg (Eder)",
      latlng: LatLng(51.0743338, 8.7555286)),
  Mapping(
      name: "Rodenbach, Frankenberg", latlng: LatLng(51.0743338, 8.7555286)),
  Mapping(
      name: "Rodenbach, Gersfeld (Rhön)",
      latlng: LatLng(50.4342724, 9.9287253)),
  Mapping(name: "Rodenbach, Gersfeld", latlng: LatLng(50.4342724, 9.9287253)),
  Mapping(
      name: "Rodenbach, Haiger", latlng: LatLng(50.7687665, 8.218223024598743)),
  Mapping(name: "Rodenbach", latlng: LatLng(49.4740942, 7.6568955)),
  Mapping(
      name: "Rodenberg, Greifenstein", latlng: LatLng(50.6203638, 8.2208977)),
  Mapping(
      name: "Rodenhausen, Lohra",
      latlng: LatLng(50.723084150000005, 8.555855907972497)),
  Mapping(
      name: "Rodenroth, Greifenstein",
      latlng: LatLng(50.58609095, 8.248154323335623)),
  Mapping(
      name: "Rödergrund-Egelmes[25], Hofbieber",
      latlng: LatLng(50.5980974, 9.862818170390465)),
  Mapping(name: "Rödermark", latlng: LatLng(49.9798913, 8.8088274)),
  Mapping(name: "Rodgau", latlng: LatLng(50.0176771, 8.8853392)),
  Mapping(name: "Rödgen, Bad Nauheim", latlng: LatLng(50.3667593, 8.7652568)),
  Mapping(
      name: "Rödgen, Gießen", latlng: LatLng(50.5974996, 8.749956567157817)),
  Mapping(name: "Rodges, Fulda", latlng: LatLng(50.5583078, 9.604493991631827)),
  Mapping(
      name: "Rodheim-Bieber, Biebertal",
      latlng: LatLng(50.6191703, 8.58608418445197)),
  Mapping(
      name: "Rodheim, Hungen", latlng: LatLng(50.44722165, 8.946939038558137)),
  Mapping(name: "Rodholz, Poppenhausen", latlng: LatLng(50.488632, 9.8928101)),
  Mapping(name: "Rohnstadt, Weilmünster", latlng: LatLng(50.40749, 8.3596348)),
  Mapping(name: "Rohrbach, Büdingen", latlng: LatLng(50.3105785, 9.0501995)),
  Mapping(name: "Rohrbach, Ludwigsau", latlng: LatLng(50.9123817, 9.7115422)),
  Mapping(name: "Rohrbach, Mörlenbach", latlng: LatLng(49.5601728, 8.7521678)),
  Mapping(
      name: "Rohrbach, Ober-Ramstadt", latlng: LatLng(49.7998405, 8.762836)),
  Mapping(
      name: "Rohrbach, Reichelsheim (Odenwald)",
      latlng: LatLng(49.6838043, 8.8799954)),
  Mapping(
      name: "Rohrbach, Reichelsheim", latlng: LatLng(49.6838043, 8.8799954)),
  Mapping(name: "Röhrda, Ringgau", latlng: LatLng(51.1029368, 10.0548795)),
  Mapping(name: "Röhrenfurth, Melsungen", latlng: LatLng(51.155814, 9.545984)),
  Mapping(name: "Röhrig, Biebergemünd", latlng: LatLng(50.1606445, 9.3479021)),
  Mapping(name: "Röhrigs, Schlüchtern", latlng: LatLng(50.3871319, 9.5206816)),
  Mapping(
      name: "Röhrigshof, Philippsthal", latlng: LatLng(50.8457545, 9.9615476)),
  Mapping(name: "Rollshausen, Lohra", latlng: LatLng(50.7177428, 8.6036345)),
  Mapping(
      name: "Röllshausen, Schrecksbach", latlng: LatLng(50.8547089, 9.2829446)),
  Mapping(name: "Rollwald, Rodgau", latlng: LatLng(49.990526, 8.8480349)),
  Mapping(name: "Römersberg, Neuental", latlng: LatLng(51.0311488, 9.220969)),
  Mapping(
      name: "Römershausen, Gladenbach", latlng: LatLng(50.7750339, 8.533118)),
  Mapping(
      name: "Römershausen, Haina (Kloster)",
      latlng: LatLng(51.0351409, 8.9001523)),
  Mapping(name: "Römershausen, Haina", latlng: LatLng(51.0351409, 8.9001523)),
  Mapping(
      name: "Rommelhausen, Limeshain", latlng: LatLng(50.2597333, 8.9725804)),
  Mapping(
      name: "Rommerode, Großalmerode", latlng: LatLng(51.2317645, 9.7693832)),
  Mapping(
      name: "Rommers, Gersfeld (Rhön)", latlng: LatLng(50.427618, 9.8893925)),
  Mapping(name: "Rommers, Gersfeld", latlng: LatLng(50.427618, 9.8893925)),
  Mapping(
      name: "Rommershausen, Schwalmstadt",
      latlng: LatLng(50.9312256, 9.1827478)),
  Mapping(name: "Rommerz, Neuhof", latlng: LatLng(50.4510483, 9.5786687)),
  Mapping(name: "Romrod", latlng: LatLng(50.7145445, 9.2187448)),
  Mapping(name: "Romrod", latlng: LatLng(50.7145445, 9.2187448)),
  Mapping(
      name: "Romsthal, Bad Soden-Salmünster",
      latlng: LatLng(50.3168919, 9.3727547)),
  Mapping(name: "Ronhausen, Marburg", latlng: LatLng(50.7557101, 8.7552481)),
  Mapping(name: "Ronneburg", latlng: LatLng(50.8630523, 12.1809073)),
  Mapping(
      name: "Rönshausen, Eichenzell", latlng: LatLng(50.4775087, 9.7410561)),
  Mapping(name: "Ronshausen", latlng: LatLng(50.9347528, 9.8728887)),
  Mapping(name: "Ronshausen", latlng: LatLng(50.9347528, 9.8728887)),
  Mapping(
      name: "Roppershain, Homberg (Efze)",
      latlng: LatLng(51.0310586, 9.3530848)),
  Mapping(name: "Roppershain, Homberg", latlng: LatLng(51.0310586, 9.3530848)),
  Mapping(
      name: "Rörshain, Schwalmstadt", latlng: LatLng(50.9404563, 9.2565579)),
  Mapping(
      name: "Rosbach v.d. Höhe", latlng: LatLng(50.2774771, 8.697439703088971)),
  Mapping(
      name: "Rosengarten, Lampertheim", latlng: LatLng(49.6347084, 8.3958256)),
  Mapping(
      name: "Rosenhöhe, Offenbach am Main",
      latlng: LatLng(50.06624815, 8.75050627472871)),
  Mapping(name: "Rosenthal", latlng: LatLng(49.602176, 13.863958)),
  Mapping(name: "Rosenthal", latlng: LatLng(49.602176, 13.863958)),
  Mapping(name: "Roßbach, Biebergemünd", latlng: LatLng(50.1621926, 9.294481)),
  Mapping(
      name: "Roßbach, Bischoffen",
      latlng: LatLng(50.70467275, 8.512329089384114)),
  Mapping(name: "Roßbach, Erbach", latlng: LatLng(51.2990522, 7.0364208)),
  Mapping(name: "Roßbach, Hünfeld", latlng: LatLng(50.7076289, 9.7772265)),
  Mapping(name: "Roßbach, Witzenhausen", latlng: LatLng(51.3142289, 9.8121323)),
  Mapping(
      name: "Roßberg, Ebsdorfergrund", latlng: LatLng(50.7169563, 8.8769798)),
  Mapping(name: "Roßdorf, Amöneburg", latlng: LatLng(50.7707274, 8.8906611)),
  Mapping(name: "Roßdorf, Bruchköbel", latlng: LatLng(50.1979991, 8.9099707)),
  Mapping(name: "Roßdorf", latlng: LatLng(50.7026664, 10.2163793)),
  Mapping(name: "Roßdorf", latlng: LatLng(50.7026664, 10.2163793)),
  Mapping(name: "Rotenburg a.d. Fulda", latlng: LatLng(51.018118, 9.7487639)),
  Mapping(name: "Rotenburg an der Fulda", latlng: LatLng(51.018118, 9.7487639)),
  Mapping(name: "Rotensee, Hauneck", latlng: LatLng(50.8346078, 9.7432818)),
  Mapping(
      name: "Roth, Driedorf",
      latlng: LatLng(50.649175299999996, 8.217054176002906)),
  Mapping(
      name: "Roth, Eschenburg", latlng: LatLng(50.8435541, 8.37634510879531)),
  Mapping(name: "Roth, Gelnhausen", latlng: LatLng(50.2082551, 9.1602635)),
  Mapping(name: "Roth, Weimar", latlng: LatLng(50.7287424, 8.7264721)),
  Mapping(name: "Rothemann, Eichenzell", latlng: LatLng(50.4672874, 9.7033085)),
  Mapping(
      name: "Rothenberg, Oberzent",
      latlng: LatLng(49.4970493, 8.927129400526933)),
  Mapping(name: "Rothenbergen, Gründau", latlng: LatLng(50.1993537, 9.1129657)),
  Mapping(name: "Rothenditmold, Kassel", latlng: LatLng(51.3249274, 9.4757782)),
  Mapping(
      name: "Rothenkirchen, Burghaun", latlng: LatLng(50.7210423, 9.704311)),
  Mapping(
      name: "Röthges, Laubach", latlng: LatLng(50.5343126, 8.930081089020561)),
  Mapping(
      name: "Rothhelmshausen, Fritzlar", latlng: LatLng(51.103348, 9.2306326)),
  Mapping(name: "Rothwesten, Fuldatal", latlng: LatLng(51.3866496, 9.5180123)),
  Mapping(
      name: "Rotterterode, Kirchheim", latlng: LatLng(50.8726072, 9.5643431)),
  Mapping(
      name: "Rüchenbach, Gladenbach", latlng: LatLng(50.7696462, 8.6255229)),
  Mapping(
      name: "Rückers, Flieden", latlng: LatLng(50.40063655, 9.581619061282936)),
  Mapping(
      name: "Rückers, Hünfeld",
      latlng: LatLng(50.644140449999995, 9.742235611574177)),
  Mapping(name: "Rückersfeld", latlng: LatLng(50.9690788, 9.4459741)),
  Mapping(
      name: "Rückershausen, Aarbergen", latlng: LatLng(50.2650206, 8.0531307)),
  Mapping(
      name: "Rückershausen, Merenberg", latlng: LatLng(50.5384085, 8.1631141)),
  Mapping(
      name: "Rückershausen, Neukirchen", latlng: LatLng(50.8749722, 9.3246962)),
  Mapping(name: "Rückingen, Erlensee", latlng: LatLng(50.158746, 8.9869597)),
  Mapping(
      name: "Rüddingshausen, Rabenau",
      latlng: LatLng(50.68809305, 8.917408971306351)),
  Mapping(name: "Rüdesheim am Rhein", latlng: LatLng(49.9816097, 7.9310198)),
  Mapping(name: "Rüdesheim am Rhein", latlng: LatLng(49.9816097, 7.9310198)),
  Mapping(name: "Rüdigheim, Amöneburg", latlng: LatLng(50.7811137, 8.9520422)),
  Mapping(name: "Rüdigheim, Neuberg", latlng: LatLng(50.2034105, 8.9771445)),
  Mapping(name: "Rudingshain, Schotten", latlng: LatLng(50.5240549, 9.1746119)),
  Mapping(name: "Rudlos, Lauterbach", latlng: LatLng(50.5977309, 9.4165147)),
  Mapping(
      name: "Rudolphshan, Hünfeld",
      latlng: LatLng(50.667556399999995, 9.69577669932988)),
  Mapping(
      name: "Ruhlkirchen, Antrifttal", latlng: LatLng(50.7951963, 9.1841106)),
  Mapping(
      name: "Rülfenrod, Gemünden (Felda)",
      latlng: LatLng(50.7033361, 9.0861527)),
  Mapping(name: "Rülfenrod, Gemünden", latlng: LatLng(50.7033361, 9.0861527)),
  Mapping(
      name: "Rumpenheim, Offenbach am Main",
      latlng: LatLng(50.131627, 8.7992697)),
  Mapping(name: "Runkel", latlng: LatLng(50.4058377, 8.1586131)),
  Mapping(name: "Runkel", latlng: LatLng(50.4058377, 8.1586131)),
  Mapping(
      name: "Runzhausen, Gladenbach", latlng: LatLng(50.7937798, 8.5599279)),
  Mapping(name: "Ruppertenrod, Mücke", latlng: LatLng(50.6237499, 9.0855998)),
  Mapping(
      name: "Ruppertsburg, Laubach",
      latlng: LatLng(50.514259550000006, 8.965934825470775)),
  Mapping(
      name: "Ruppertshain, Kelkheim (Taunus)",
      latlng: LatLng(50.17586155, 8.409684453576972)),
  Mapping(
      name: "Ruppertshain, Kelkheim",
      latlng: LatLng(50.17586155, 8.409684453576972)),
  Mapping(
      name: "Rupsroth, Hilders", latlng: LatLng(50.5458527, 9.934506546358564)),
  Mapping(name: "Rüsselsheim am Main", latlng: LatLng(49.9948956, 8.4118279)),
  Mapping(name: "Rüsselsheim am Main", latlng: LatLng(49.9948956, 8.4118279)),
  Mapping(
      name: "Rüsselsheim, Rüsselsheim am Main",
      latlng: LatLng(49.991701, 8.4138251)),
  Mapping(
      name: "Ruttershausen, Lollar",
      latlng: LatLng(50.660437, 8.703273361510515)),
  Mapping(name: "Saasen, Neuenstein", latlng: LatLng(50.9180958, 9.5551271)),
  Mapping(
      name: "Saasen, Reiskirchen",
      latlng: LatLng(50.604530499999996, 8.891299362908041)),
  Mapping(name: "Sababurg, Hofgeismar", latlng: LatLng(51.5437328, 9.5373196)),
  Mapping(
      name: "Sachsenberg, Lichtenfels (Hessen)",
      latlng: LatLng(51.1257272, 8.7876309)),
  Mapping(
      name: "Sachsenberg, Lichtenfels", latlng: LatLng(51.1257272, 8.7876309)),
  Mapping(
      name: "Sachsenhausen, Frankfurt am Main",
      latlng: LatLng(50.1002618, 8.6835988)),
  Mapping(
      name: "Sachsenhausen, Gilserberg", latlng: LatLng(50.932154, 9.095826)),
  Mapping(
      name: "Sachsenhausen, Waldeck", latlng: LatLng(51.2443119, 9.0068715)),
  Mapping(
      name: "Salmshausen, Schrecksbach",
      latlng: LatLng(50.8603476, 9.266357428049927)),
  Mapping(
      name: "Salmünster, Bad Soden-Salmünster",
      latlng: LatLng(50.2737152, 9.3688815)),
  Mapping(name: "Salz, Freiensteinau", latlng: LatLng(50.4262058, 9.3658894)),
  Mapping(name: "Salzberg, Neuenstein", latlng: LatLng(50.902248, 9.5043862)),
  Mapping(name: "Salzböden, Lollar", latlng: LatLng(50.6833129, 8.6852833)),
  Mapping(name: "Sand, Bad Emstal", latlng: LatLng(51.2453113, 9.259941)),
  Mapping(name: "Sandbach, Breuberg", latlng: LatLng(49.8188677, 9.0176163)),
  Mapping(
      name: "Sandberg, Gersfeld (Rhön)",
      latlng: LatLng(50.4710785, 9.96759809692168)),
  Mapping(
      name: "Sandberg, Gersfeld", latlng: LatLng(50.4710785, 9.96759809692168)),
  Mapping(
      name: "Sandershausen, Niestetal", latlng: LatLng(51.3210551, 9.5520461)),
  Mapping(name: "Sandlofs, Schlitz", latlng: LatLng(50.6946937, 9.5975302)),
  Mapping(
      name: "Sandwiese, Alsbach-Hähnlein",
      latlng: LatLng(49.7401932, 8.6035609)),
  Mapping(name: "Sannerz, Sinntal", latlng: LatLng(50.3223935, 9.5906587)),
  Mapping(
      name: "Sargenzell, Hünfeld",
      latlng: LatLng(50.6665238, 9.731112454944528)),
  Mapping(name: "Sarnau, Lahntal", latlng: LatLng(50.8660065, 8.7554108)),
  Mapping(
      name: "Sarrod, Steinau an der Straße",
      latlng: LatLng(50.3508132, 9.3971284)),
  Mapping(name: "Schaafheim", latlng: LatLng(49.9107, 9.0082)),
  Mapping(name: "Schaafheim", latlng: LatLng(49.9107, 9.0082)),
  Mapping(
      name: "Schachen, Gersfeld (Rhön)",
      latlng: LatLng(50.47355005, 9.91844909577894)),
  Mapping(
      name: "Schachen, Gersfeld",
      latlng: LatLng(50.47355005, 9.91844909577894)),
  Mapping(
      name: "Schachten, Grebenstein", latlng: LatLng(51.4339345, 9.3834985)),
  Mapping(name: "Schackau, Hofbieber", latlng: LatLng(50.5659188, 9.8701482)),
  Mapping(name: "Schadeck, Runkel", latlng: LatLng(50.4091466, 8.15759)),
  Mapping(
      name: "Schadenbach, Homberg (Ohm)",
      latlng: LatLng(50.6956821, 8.9724811)),
  Mapping(name: "Schadenbach, Homberg", latlng: LatLng(50.6956821, 8.9724811)),
  Mapping(name: "Schadges, Herbstein", latlng: LatLng(50.5683272, 9.4176433)),
  Mapping(name: "Schäferberg, Espenau", latlng: LatLng(51.3877468, 9.4392993)),
  Mapping(
      name: "Schannenbach, Lautertal (Odenwald)",
      latlng: LatLng(49.6902181, 8.7219303)),
  Mapping(
      name: "Schannenbach, Lautertal", latlng: LatLng(49.6895585, 8.7216153)),
  Mapping(
      name: "Scharbach, Grasellenbach", latlng: LatLng(49.6136645, 8.8247679)),
  Mapping(name: "Schauenburg", latlng: LatLng(51.2776974, 9.3482404)),
  Mapping(name: "Schellbach, Knüllwald", latlng: LatLng(50.9929221, 9.4529448)),
  Mapping(
      name: "Schellnhausen, Feldatal", latlng: LatLng(50.6659275, 9.1490246)),
  Mapping(name: "Schemmern, Waldkappel", latlng: LatLng(51.1121817, 9.8207189)),
  Mapping(name: "Schenklengsfeld", latlng: LatLng(50.8276584, 9.823959)),
  Mapping(name: "Schenklengsfeld", latlng: LatLng(50.8276584, 9.823959)),
  Mapping(
      name: "Schenksolz, Schenklengsfeld",
      latlng: LatLng(50.8428455, 9.8279306)),
  Mapping(
      name: "Schierstein, Wiesbaden", latlng: LatLng(50.0446538, 8.1959298)),
  Mapping(
      name: "Schiffelbach, Gemünden (Wohra)",
      latlng: LatLng(50.9504815, 8.9941486)),
  Mapping(
      name: "Schiffelbach, Gemünden", latlng: LatLng(50.9504815, 8.9941486)),
  Mapping(name: "Schimbach", latlng: LatLng(49.5725766, 8.7459229)),
  Mapping(name: "Schlangenbad", latlng: LatLng(50.0932804, 8.102596)),
  Mapping(name: "Schlangenbad", latlng: LatLng(50.0932804, 8.102596)),
  Mapping(
      name: "Schlechtenwegen, Herbstein",
      latlng: LatLng(50.5394175, 9.4268421)),
  Mapping(
      name: "Schletzenhausen, Hosenfeld",
      latlng: LatLng(50.5194539, 9.4898632)),
  Mapping(
      name: "Schletzenrod, Haunetal", latlng: LatLng(50.7546741, 9.6390217)),
  Mapping(
      name: "Schlierbach, Bad Endbach",
      latlng: LatLng(50.7730156, 8.46248244048165)),
  Mapping(
      name: "Schlierbach, Brachttal", latlng: LatLng(50.3046251, 9.2975972)),
  Mapping(
      name: "Schlierbach, Lindenfels", latlng: LatLng(49.6832088, 8.7653187)),
  Mapping(name: "Schlierbach, Neuental", latlng: LatLng(50.9650111, 9.1977831)),
  Mapping(
      name: "Schlierbach, Schaafheim", latlng: LatLng(49.9122913, 8.9730192)),
  Mapping(name: "Schlitz", latlng: LatLng(50.6866279, 9.5464764)),
  Mapping(name: "Schlitz", latlng: LatLng(50.6866279, 9.5464764)),
  Mapping(
      name: "Schlitzenhausen, Tann (Rhön)",
      latlng: LatLng(50.6633404, 10.0058794)),
  Mapping(
      name: "Schlitzenhausen, Tann", latlng: LatLng(50.6633404, 10.0058794)),
  Mapping(name: "Schloß-Nauses, Otzberg", latlng: LatLng(49.803453, 8.9560527)),
  Mapping(
      name: "Schloßborn, Glashütten",
      latlng: LatLng(50.1978591, 8.391642657713358)),
  Mapping(name: "Schlotzau, Burghaun", latlng: LatLng(50.6882558, 9.6465059)),
  Mapping(name: "Schlüchtern", latlng: LatLng(50.3485112, 9.5253904)),
  Mapping(name: "Schlüchtern", latlng: LatLng(50.3485112, 9.5253904)),
  Mapping(
      name: "Schmal-Beerbach, Lautertal",
      latlng: LatLng(49.7428984, 8.7060474)),
  Mapping(name: "Schmalnau, Ebersburg", latlng: LatLng(50.4533109, 9.7902262)),
  Mapping(
      name: "Schmillinghausen, Bad Arolsen",
      latlng: LatLng(51.4282452, 9.0261898)),
  Mapping(name: "Schmitten im Taunus", latlng: LatLng(50.2694775, 8.4440229)),
  Mapping(name: "Schmitten, Mücke", latlng: LatLng(50.5747922, 9.1048621)),
  Mapping(
      name: "Schmitten, Schmitten im Taunus",
      latlng: LatLng(50.2667366, 8.44172333677393)),
  Mapping(name: "Schmittlotheim, Vöhl", latlng: LatLng(51.1515602, 8.9022794)),
  Mapping(
      name: "Schneidhain, Königstein im Taunus",
      latlng: LatLng(50.169571149999996, 8.450561835306289)),
  Mapping(
      name: "Schnellrode, Spangenberg",
      latlng: LatLng(51.15298115, 9.697109695371227)),
  Mapping(
      name: "Schneppenhausen, Weiterstadt",
      latlng: LatLng(49.9281119, 8.5803519)),
  Mapping(name: "Schnorrenbach", latlng: LatLng(49.5563923, 8.7627397)),
  Mapping(name: "Schöffengrund", latlng: LatLng(50.4864244, 8.4722999)),
  Mapping(
      name: "Schöllenbach, Oberzent", latlng: LatLng(49.5666944, 9.0705637)),
  Mapping(name: "Schönau, Gilserberg", latlng: LatLng(50.9720338, 9.0731022)),
  Mapping(
      name: "Schönbach, Herborn",
      latlng: LatLng(50.667754849999994, 8.216039727227102)),
  Mapping(name: "Schönbach, Kirchhain", latlng: LatLng(50.8329196, 8.8557701)),
  Mapping(name: "Schönberg, Bensheim", latlng: LatLng(49.6931615, 8.6478186)),
  Mapping(
      name: "Schönberg, Kronberg im Taunus",
      latlng: LatLng(50.1832709, 8.5188619)),
  Mapping(
      name: "Schönberg, Schrecksbach", latlng: LatLng(50.8542547, 9.2966533)),
  Mapping(name: "Schönborn, Frielendorf", latlng: LatLng(50.930968, 9.2885826)),
  Mapping(
      name: "Schöneberg, Hofgeismar", latlng: LatLng(51.5236957, 9.4029215)),
  Mapping(name: "Schöneck", latlng: LatLng(49.2207124, 6.9240547)),
  Mapping(name: "Schönnen[7], Erbach", latlng: LatLng(49.6287726, 8.9960685)),
  Mapping(name: "Schönstadt, Cölbe", latlng: LatLng(50.883814, 8.8308494)),
  Mapping(
      name: "Schönstein, Gilserberg", latlng: LatLng(50.9924211, 9.0608815)),
  Mapping(name: "Schorbach, Ottrau", latlng: LatLng(50.8445689, 9.413716)),
  Mapping(name: "Schotten", latlng: LatLng(50.48726, 9.16192)),
  Mapping(name: "Schotten", latlng: LatLng(50.48726, 9.16192)),
  Mapping(name: "Schrecksbach", latlng: LatLng(50.8468297, 9.2834184)),
  Mapping(name: "Schrecksbach", latlng: LatLng(50.8468297, 9.2834184)),
  Mapping(
      name: "Schreufa, Frankenberg (Eder)",
      latlng: LatLng(51.0870647, 8.7993371)),
  Mapping(name: "Schreufa, Frankenberg", latlng: LatLng(51.0870647, 8.7993371)),
  Mapping(name: "Schröck, Marburg", latlng: LatLng(50.7861144, 8.83046)),
  Mapping(name: "Schupbach, Beselich", latlng: LatLng(50.4552534, 8.1698043)),
  Mapping(
      name: "Schwabendorf, Rauschenberg",
      latlng: LatLng(50.9010259, 8.8853375)),
  Mapping(name: "Schwabenrod, Alsfeld", latlng: LatLng(50.7825968, 9.258158)),
  Mapping(
      name: "Schwalbach am Taunus, Schwalbach am Taunus",
      latlng: LatLng(50.1475745, 8.5364393)),
  Mapping(name: "Schwalbach am Taunus", latlng: LatLng(50.1488011, 8.5361049)),
  Mapping(
      name: "Schwalbach, Schöffengrund",
      latlng: LatLng(50.49536815, 8.469613462116564)),
  Mapping(
      name: "Schwalefeld, Willingen (Upland)",
      latlng: LatLng(51.3079073, 8.6301728)),
  Mapping(
      name: "Schwalefeld, Willingen", latlng: LatLng(51.3079073, 8.6301728)),
  Mapping(
      name: "Schwalheim, Bad Nauheim", latlng: LatLng(50.3556543, 8.7654794)),
  Mapping(name: "Schwalmstadt", latlng: LatLng(50.9257352, 9.2020472)),
  Mapping(name: "Schwalmtal", latlng: LatLng(50.6886614, 9.3053664)),
  Mapping(name: "Schwanheim, Bensheim", latlng: LatLng(49.6982312, 8.5666814)),
  Mapping(
      name: "Schwanheim, Frankfurt am Main",
      latlng: LatLng(50.0853006, 8.5836267)),
  Mapping(name: "Schwarz, Grebenau", latlng: LatLng(50.7209717, 9.4209393)),
  Mapping(
      name: "Schwarzbach, Hofbieber", latlng: LatLng(50.6077908, 9.9015641)),
  Mapping(
      name: "Schwarzenberg, Melsungen", latlng: LatLng(51.1473495, 9.5634976)),
  Mapping(name: "Schwarzenborn, Cölbe", latlng: LatLng(50.8959114, 8.8605133)),
  Mapping(name: "Schwarzenborn", latlng: LatLng(50.0390136, 6.7113515)),
  Mapping(name: "Schwarzenborn", latlng: LatLng(50.0390136, 6.7113515)),
  Mapping(
      name: "Schwarzenfels, Sinntal", latlng: LatLng(50.2985544, 9.6744811)),
  Mapping(
      name: "Schwarzenhasel, Rotenburg an der Fulda",
      latlng: LatLng(51.020288, 9.7728049)),
  Mapping(name: "Schwebda, Meinhard", latlng: LatLng(51.1956259, 10.1033107)),
  Mapping(
      name: "Schweben, Flieden",
      latlng: LatLng(50.411630450000004, 9.610445562339208)),
  Mapping(
      name: "Schweinsberg, Stadtallendorf",
      latlng: LatLng(50.7678611, 8.9593868)),
  Mapping(
      name: "Schweinsbühl, Diemelsee", latlng: LatLng(51.3110351, 8.7472053)),
  Mapping(
      name: "Schwickartshausen, Nidda", latlng: LatLng(50.393519, 9.074983)),
  Mapping(
      name: "Schwickershausen, Bad Camberg",
      latlng: LatLng(50.3128855, 8.2966683)),
  Mapping(
      name: "Sebbeterode, Gilserberg", latlng: LatLng(50.9610713, 9.1027937)),
  Mapping(
      name: "Sechshelden, Haiger",
      latlng: LatLng(50.749795899999995, 8.244586084516659)),
  Mapping(
      name: "Seckbach, Frankfurt am Main",
      latlng: LatLng(50.1434285, 8.7258861)),
  Mapping(
      name: "Seckmauern, Lützelbach", latlng: LatLng(49.7899261, 9.1222271)),
  Mapping(name: "Seeheim-Jugenheim", latlng: LatLng(49.7598, 8.6632)),
  Mapping(
      name: "Seeheim, Seeheim-Jugenheim",
      latlng: LatLng(49.7699405, 8.6429463)),
  Mapping(name: "Seelbach, Haiger", latlng: LatLng(50.7648789, 8.1794145)),
  Mapping(
      name: "Seelbach, Herborn",
      latlng: LatLng(50.70159765, 8.342797328840234)),
  Mapping(
      name: "Seelbach, Lohra", latlng: LatLng(50.72050625, 8.577313825013476)),
  Mapping(name: "Seelbach, Villmar", latlng: LatLng(50.4172938, 8.2311912)),
  Mapping(
      name: "Seelenberg, Schmitten im Taunus",
      latlng: LatLng(50.2659719, 8.417782688617944)),
  Mapping(
      name: "Sehlen, Gemünden (Wohra)", latlng: LatLng(51.0091268, 8.9485145)),
  Mapping(name: "Sehlen, Gemünden", latlng: LatLng(51.0091268, 8.9485145)),
  Mapping(
      name: "Seibelsbach, Allendorf (Eder)",
      latlng: LatLng(51.0763132, 8.5034946)),
  Mapping(
      name: "Seibelsbach, Allendorf", latlng: LatLng(51.0763132, 8.5034946)),
  Mapping(
      name: "Seibelsdorf, Antrifttal", latlng: LatLng(50.7815539, 9.198455)),
  Mapping(name: "Seidenbach, Fürth", latlng: LatLng(49.6733029, 8.7325732)),
  Mapping(
      name: "Seidenbuch, Lindenfels", latlng: LatLng(49.6878328, 8.7415812)),
  Mapping(
      name: "Seidenroth, Steinau an der Straße",
      latlng: LatLng(50.2863954, 9.4567154)),
  Mapping(
      name: "Seiferts, Ehrenberg (Rhön)",
      latlng: LatLng(50.526106, 10.0153864)),
  Mapping(name: "Seiferts, Ehrenberg", latlng: LatLng(50.526106, 10.0153864)),
  Mapping(
      name: "Seifertshausen, Rotenburg an der Fulda",
      latlng: LatLng(51.049825, 9.7664027)),
  Mapping(
      name: "Seigertshausen, Neukirchen", latlng: LatLng(50.9112963, 9.360042)),
  Mapping(
      name: "Seilhofen, Driedorf",
      latlng: LatLng(50.6246552, 8.209827017610191)),
  Mapping(
      name: "Seitzenhahn, Taunusstein", latlng: LatLng(50.1249064, 8.120747)),
  Mapping(name: "Selbach, Waldeck", latlng: LatLng(51.2436965, 9.0541605)),
  Mapping(name: "Seligenstadt", latlng: LatLng(50.0441737, 8.9755128)),
  Mapping(name: "Seligenstadt", latlng: LatLng(50.0441737, 8.9755128)),
  Mapping(name: "Sellnrod, Mücke", latlng: LatLng(50.5815279, 9.0953832)),
  Mapping(name: "Selters (Taunus)", latlng: LatLng(50.3490889, 8.2649036)),
  Mapping(
      name: "Selters, Löhnberg",
      latlng: LatLng(50.51575305, 8.302049691929863)),
  Mapping(name: "Selters, Ortenberg", latlng: LatLng(50.3408617, 9.0377107)),
  Mapping(name: "Selters", latlng: LatLng(50.5203849, 7.7337742)),
  Mapping(name: "Semd, Groß-Umstadt", latlng: LatLng(49.8732243, 8.8892265)),
  Mapping(name: "Setzelbach, Rasdorf", latlng: LatLng(50.6930945, 9.9099837)),
  Mapping(
      name: "Seulberg, Friedrichsdorf", latlng: LatLng(50.2431047, 8.649535)),
  Mapping(
      name: "Sichenhausen, Schotten", latlng: LatLng(50.4780285, 9.2412408)),
  Mapping(
      name: "Sichertshausen, Fronhausen",
      latlng: LatLng(50.6895392, 8.732489212121314)),
  Mapping(
      name: "Sickels, Fulda", latlng: LatLng(50.53383145, 9.642015917721022)),
  Mapping(
      name: "Sickendorf, Lauterbach", latlng: LatLng(50.6387614, 9.3472516)),
  Mapping(
      name: "Sickenhofen, Babenhausen", latlng: LatLng(49.948114, 8.930758)),
  Mapping(
      name: "Siebertshausen, Frielendorf",
      latlng: LatLng(50.9783466, 9.3596273)),
  Mapping(name: "Sieblos, Poppenhausen", latlng: LatLng(50.5064696, 9.908413)),
  Mapping(
      name: "Siedelsbrunn, Wald-Michelbach",
      latlng: LatLng(49.53972145, 8.819520393244368)),
  Mapping(name: "Siegbach", latlng: LatLng(50.7440175, 8.4188042)),
  Mapping(name: "Sieglos, Hauneck", latlng: LatLng(50.8170329, 9.7340149)),
  Mapping(name: "Sielen, Trendelburg", latlng: LatLng(51.552034, 9.3795156)),
  Mapping(name: "Silberg, Dautphetal", latlng: LatLng(50.8628311, 8.5976124)),
  Mapping(
      name: "Silges, Nüsttal", latlng: LatLng(50.6370413, 9.81005563593688)),
  Mapping(
      name: "Silhöfer Aue/Westend, Wetzlar",
      latlng: LatLng(50.5494907, 8.4844695)),
  Mapping(
      name: "Simmersbach, Eschenburg",
      latlng: LatLng(50.8224324, 8.379814406157355)),
  Mapping(
      name: "Simmershausen, Fuldatal", latlng: LatLng(51.3701565, 9.5159061)),
  Mapping(
      name: "Simmershausen, Hilders", latlng: LatLng(50.5929602, 10.0336574)),
  Mapping(
      name: "Simtshausen, Münchhausen", latlng: LatLng(50.9411435, 8.7063324)),
  Mapping(
      name: "Sindersfeld, Kirchhain", latlng: LatLng(50.8685114, 8.8713154)),
  Mapping(
      name: "Sindlingen, Frankfurt am Main",
      latlng: LatLng(50.0798368, 8.5179804)),
  Mapping(
      name: "Singlis, Borken (Hessen)", latlng: LatLng(51.0588062, 9.3196224)),
  Mapping(name: "Singlis, Borken", latlng: LatLng(51.0588062, 9.3196224)),
  Mapping(
      name: "Sinkershausen, Gladenbach", latlng: LatLng(50.795521, 8.5992787)),
  Mapping(name: "Sinn", latlng: LatLng(50.6530604, 8.3304382)),
  Mapping(name: "Sinn", latlng: LatLng(50.6530604, 8.3304382)),
  Mapping(name: "Sinntal", latlng: LatLng(50.3169731, 9.666877)),
  Mapping(
      name: "Sipperhausen, Malsfeld", latlng: LatLng(51.0638253, 9.4785266)),
  Mapping(name: "Södel, Wölfersheim", latlng: LatLng(50.394223, 8.8069747)),
  Mapping(name: "Söhrewald", latlng: LatLng(51.2216728, 9.5845711)),
  Mapping(
      name: "Soisdorf, Eiterfeld",
      latlng: LatLng(50.76684245, 9.90324840900901)),
  Mapping(name: "Soislieden, Hohenroda", latlng: LatLng(50.7850484, 9.8938805)),
  Mapping(name: "Solms, Niederaula", latlng: LatLng(50.7690681, 9.5945484)),
  Mapping(name: "Solms", latlng: LatLng(50.5333914, 8.4073302)),
  Mapping(name: "Solz, Bebra", latlng: LatLng(51.0062485, 9.8798054)),
  Mapping(name: "Somborn, Freigericht", latlng: LatLng(50.1412642, 9.1154657)),
  Mapping(
      name: "Somplar, Allendorf (Eder)", latlng: LatLng(51.0961324, 8.666724)),
  Mapping(name: "Somplar, Allendorf", latlng: LatLng(51.0961324, 8.666724)),
  Mapping(
      name: "Sonderbach, Heppenheim", latlng: LatLng(49.6396346, 8.6884031)),
  Mapping(
      name: "Sondheim, Homberg (Efze)", latlng: LatLng(50.999161, 9.3849958)),
  Mapping(name: "Sondheim, Homberg", latlng: LatLng(50.999161, 9.3849958)),
  Mapping(name: "Sonnenberg, Wiesbaden", latlng: LatLng(50.1016836, 8.264657)),
  Mapping(name: "Sontra", latlng: LatLng(51.0831196, 9.9542845)),
  Mapping(name: "Sontra", latlng: LatLng(51.0831196, 9.9542845)),
  Mapping(name: "Sorga, Bad Hersfeld", latlng: LatLng(50.8689276, 9.7577566)),
  Mapping(
      name: "Sossenheim, Frankfurt am Main",
      latlng: LatLng(50.1201215, 8.5666158)),
  Mapping(
      name: "Spachbrücken, Reinheim", latlng: LatLng(49.8428454, 8.8292638)),
  Mapping(name: "Spangenberg", latlng: LatLng(51.1167072, 9.6667154)),
  Mapping(name: "Spangenberg", latlng: LatLng(51.1167072, 9.6667154)),
  Mapping(
      name: "Speckswinkel, Neustadt", latlng: LatLng(50.8701288, 9.0567124)),
  Mapping(name: "Spielberg, Brachttal", latlng: LatLng(50.3079937, 9.2680101)),
  Mapping(
      name: "Spieskappel, Frielendorf", latlng: LatLng(50.9644423, 9.3196746)),
  Mapping(
      name: "Sprendlingen, Dreieich", latlng: LatLng(50.0247652, 8.6936754)),
  Mapping(name: "Spreng", latlng: LatLng(40.7808906, -82.1562656)),
  Mapping(name: "Springen, Heidenrod", latlng: LatLng(50.1427368, 7.9845531)),
  Mapping(name: "St. Ottilien, Helsa", latlng: LatLng(51.2188265, 9.6465003)),
  Mapping(
      name: "Staden, Florstadt",
      latlng: LatLng(50.328695249999996, 8.910688824712324)),
  Mapping(
      name: "Stadtallendorf", latlng: LatLng(50.82595195, 9.036930305228982)),
  Mapping(
      name: "Stadtallendorf", latlng: LatLng(50.82595195, 9.036930305228982)),
  Mapping(name: "Städte", latlng: LatLng(48.7630326, 11.4271079)),
  Mapping(name: "Stadthosbach, Sontra", latlng: LatLng(51.0947921, 9.8890996)),
  Mapping(name: "Staffel, Lautertal", latlng: LatLng(49.7420392, 8.6971732)),
  Mapping(
      name: "Staffel, Limburg an der Lahn",
      latlng: LatLng(50.3978436, 8.0386225)),
  Mapping(
      name: "Stallenkandel, Wald-Michelbach",
      latlng: LatLng(49.5785328, 8.8013234)),
  Mapping(name: "Stammen, Trendelburg", latlng: LatLng(51.5627788, 9.4146822)),
  Mapping(
      name: "Stammheim, Florstadt",
      latlng: LatLng(50.3087623, 8.917612116730485)),
  Mapping(
      name: "Stangenrod, Grünberg",
      latlng: LatLng(50.6205675, 8.965033536483155)),
  Mapping(name: "Stärklos, Haunetal", latlng: LatLng(50.7666847, 9.6348021)),
  Mapping(name: "Staufenberg", latlng: LatLng(50.6616049, 8.7299749)),
  Mapping(name: "Staufenberg", latlng: LatLng(50.6616049, 8.7299749)),
  Mapping(name: "Stausebach, Kirchhain", latlng: LatLng(50.8415376, 8.903337)),
  Mapping(
      name: "Steckenroth, Hohenstein", latlng: LatLng(50.1887378, 8.124409)),
  Mapping(name: "Stedebach, Weimar", latlng: LatLng(50.7283603, 8.6732244)),
  Mapping(name: "Steeden, Runkel", latlng: LatLng(50.4160638, 8.127007)),
  Mapping(name: "Steens [26], Hofbieber", latlng: LatLng(50.568715, 9.9049194)),
  Mapping(name: "Steffenberg", latlng: LatLng(50.835262, 8.4782157)),
  Mapping(
      name: "Steigerts, Seeheim-Jugenheim",
      latlng: LatLng(49.7540933, 8.6893811)),
  Mapping(
      name: "Steina, Willingshausen", latlng: LatLng(50.8963216, 9.2639049)),
  Mapping(name: "Steinau an der Straße", latlng: LatLng(50.3556, 9.4227)),
  Mapping(name: "Steinau, Fischbachtal", latlng: LatLng(49.7473974, 8.7942401)),
  Mapping(name: "Steinau, Petersberg", latlng: LatLng(50.5928809, 9.7363975)),
  Mapping(
      name: "Steinau, Steinau an der Straße",
      latlng: LatLng(50.3116515, 9.4594009)),
  Mapping(
      name: "Steinbach (Taunus), Steinbach (Taunus)",
      latlng: LatLng(50.1574227, 8.5928565)),
  Mapping(name: "Steinbach (Taunus)", latlng: LatLng(50.1672827, 8.572208)),
  Mapping(name: "Steinbach, Burghaun", latlng: LatLng(50.7317244, 9.7403492)),
  Mapping(
      name: "Steinbach, Fernwald",
      latlng: LatLng(50.5542045, 8.768847620404758)),
  Mapping(
      name: "Steinbach, Fürth (Odenwald)",
      latlng: LatLng(49.6484006, 8.7804585)),
  Mapping(name: "Steinbach, Fürth", latlng: LatLng(49.441998, 10.8577789)),
  Mapping(name: "Steinbach, Hadamar", latlng: LatLng(50.471696, 8.1031464)),
  Mapping(
      name: "Steinbach, Haiger",
      latlng: LatLng(50.782970199999994, 8.175716416964981)),
  Mapping(
      name: "Steinbach, Michelstadt", latlng: LatLng(49.6847816, 8.9927107)),
  Mapping(name: "Steinbach", latlng: LatLng(47.821081, 7.153381)),
  Mapping(name: "Steinberg, Gedern", latlng: LatLng(50.4110228, 9.1501917)),
  Mapping(
      name: "Steinbrücken, Dietzhölztal", latlng: LatLng(50.831238, 8.333388)),
  Mapping(name: "Steinbuch, Michelstadt", latlng: LatLng(49.682971, 8.951313)),
  Mapping(
      name: "Steindorf, Homberg (Efze)", latlng: LatLng(50.961644, 9.4364443)),
  Mapping(name: "Steindorf, Homberg", latlng: LatLng(50.961644, 9.4364443)),
  Mapping(
      name: "Steindorf, Wetzlar",
      latlng: LatLng(50.54326245, 8.461096798466919)),
  Mapping(
      name: "Steinfischbach, Waldems",
      latlng: LatLng(50.2765773, 8.343628671696575)),
  Mapping(name: "Steinfurt, Herbstein", latlng: LatLng(50.5248305, 9.4045579)),
  Mapping(name: "Steinfurth, Bad Nauheim", latlng: LatLng(50.40015, 8.7461314)),
  Mapping(name: "Steinhaus, Petersberg", latlng: LatLng(50.5954346, 9.7478071)),
  Mapping(name: "Steinheim, Hanau", latlng: LatLng(50.1117308, 8.9055181)),
  Mapping(
      name: "Steinheim, Hungen", latlng: LatLng(50.4452886, 8.924247995102043)),
  Mapping(
      name: "Steinperf, Steffenberg", latlng: LatLng(50.8199221, 8.4812707)),
  Mapping(
      name: "Steinwand, Poppenhausen", latlng: LatLng(50.5243644, 9.8662141)),
  Mapping(
      name: "Stephanshausen, Geisenheim",
      latlng: LatLng(50.0353655, 7.9483666)),
  Mapping(name: "Sterbfritz, Sinntal", latlng: LatLng(50.3102576, 9.6241495)),
  Mapping(
      name: "Sterkelshausen, Alheim", latlng: LatLng(51.0102043, 9.6477566)),
  Mapping(name: "Sterzhausen, Lahntal", latlng: LatLng(50.8619406, 8.7032657)),
  Mapping(
      name: "Stettbach, Seeheim-Jugenheim",
      latlng: LatLng(49.7479353, 8.6755572)),
  Mapping(
      name: "Stierbach [27], Brensbach", latlng: LatLng(49.7466006, 8.8877308)),
  Mapping(
      name: "Stierstadt, Oberursel (Taunus)",
      latlng: LatLng(50.185593, 8.5781339)),
  Mapping(name: "Stierstadt, Oberursel", latlng: LatLng(50.185593, 8.5781339)),
  Mapping(name: "Stöckels, Petersberg", latlng: LatLng(50.5700708, 9.735352)),
  Mapping(
      name: "Stockhausen, Grünberg",
      latlng: LatLng(50.5936316, 9.024139268133268)),
  Mapping(
      name: "Stockhausen, Herbstein", latlng: LatLng(50.5615832, 9.4473204)),
  Mapping(
      name: "Stockhausen, Leun", latlng: LatLng(50.5563017, 8.325373857493037)),
  Mapping(name: "Stockheim, Glauburg", latlng: LatLng(50.3237597, 9.0166907)),
  Mapping(name: "Stockheim, Michelstadt", latlng: LatLng(49.668228, 9.0027939)),
  Mapping(
      name: "Stockstadt am Rhein, Stockstadt am Rhein",
      latlng: LatLng(49.8091902, 8.4722557)),
  Mapping(name: "Stockstadt am Rhein", latlng: LatLng(49.8063487, 8.4602546)),
  Mapping(
      name: "Stolzenbach, Borken (Hessen)",
      latlng: LatLng(51.0126338, 9.2954541)),
  Mapping(name: "Stolzenbach, Borken", latlng: LatLng(51.0126338, 9.2954541)),
  Mapping(
      name: "Stolzhausen, Waldkappel", latlng: LatLng(51.0940373, 9.7842422)),
  Mapping(
      name: "Stoppelberger Hohl, Wetzlar",
      latlng: LatLng(50.5444201, 8.5092544)),
  Mapping(
      name: "Stork, Flieden", latlng: LatLng(50.42218115, 9.496303928618913)),
  Mapping(
      name: "Stormbruch, Diemelsee",
      latlng: LatLng(51.364109400000004, 8.72248783898634)),
  Mapping(name: "Storndorf, Schwalmtal", latlng: LatLng(50.6561325, 9.2643905)),
  Mapping(name: "Stornfels, Nidda", latlng: LatLng(50.4874384, 9.0355588)),
  Mapping(name: "Strebendorf, Romrod", latlng: LatLng(50.6863541, 9.2430105)),
  Mapping(name: "Streitberg, Brachttal", latlng: LatLng(50.3232261, 9.2575062)),
  Mapping(
      name: "Streithain [28], Hirzenhain",
      latlng: LatLng(50.4308194, 9.1403612)),
  Mapping(
      name: "Strinz-Margarethä, Hohenstein",
      latlng: LatLng(50.2061574, 8.1365859)),
  Mapping(
      name: "Strinz-Trinitatis, Hünstetten",
      latlng: LatLng(50.2353718, 8.1565653)),
  Mapping(name: "Strothe, Korbach", latlng: LatLng(51.2827659, 8.9370699)),
  Mapping(name: "Struth, Flieden", latlng: LatLng(50.4193053, 9.5373554)),
  Mapping(name: "Stryck", latlng: LatLng(51.2794918, 8.6228618)),
  Mapping(
      name: "Stumpertenrod, Feldatal", latlng: LatLng(50.6163528, 9.1805548)),
  Mapping(name: "Sturzkopf, Wetzlar", latlng: LatLng(50.5412462, 8.5245471)),
  Mapping(name: "Sudeck, Diemelsee", latlng: LatLng(51.3435323, 8.763978)),
  Mapping(name: "Südstadt, Kassel", latlng: LatLng(51.3054394, 9.4834727)),
  Mapping(
      name: "Sulzbach (Taunus), Sulzbach (Taunus)",
      latlng: LatLng(50.1358894, 8.5187329)),
  Mapping(name: "Sulzbach (Taunus)", latlng: LatLng(50.1326128, 8.5279513)),
  Mapping(name: "Sulzbach", latlng: LatLng(48.0356915, 7.2011423)),
  Mapping(name: "Süß, Nentershausen", latlng: LatLng(50.9886802, 9.971446)),
  Mapping(
      name: "Süsterfeld-Helleböhn, Kassel",
      latlng: LatLng(51.2968101, 9.4503102)),
  Mapping(name: "Tann (Rhön)", latlng: LatLng(50.636953, 10.0040118)),
  Mapping(name: "Tann, Ludwigsau", latlng: LatLng(50.9204306, 9.7023401)),
  Mapping(name: "Tann", latlng: LatLng(50.636953, 10.0040118)),
  Mapping(name: "Taunusstein", latlng: LatLng(50.1393843, 8.1505676)),
  Mapping(
      name: "Tempelsee, Offenbach am Main",
      latlng: LatLng(50.0740242, 8.783516024343598)),
  Mapping(
      name: "Thaiden, Ehrenberg (Rhön)",
      latlng: LatLng(50.5423994, 10.0149769)),
  Mapping(name: "Thaiden, Ehrenberg", latlng: LatLng(50.5423994, 10.0149769)),
  Mapping(name: "Thalau, Ebersburg", latlng: LatLng(50.438404, 9.7730751)),
  Mapping(name: "Thalheim, Dornburg", latlng: LatLng(50.4867701, 8.0115874)),
  Mapping(name: "Thalitter, Vöhl", latlng: LatLng(51.2178335, 8.8936939)),
  Mapping(name: "Theobaldshof", latlng: LatLng(50.6688146, 10.0402625)),
  Mapping(name: "Thurnhosbach, Sontra", latlng: LatLng(51.0990528, 9.873898)),
  Mapping(
      name: "Tiefenbach, Braunfels",
      latlng: LatLng(50.5293538, 8.335674960202944)),
  Mapping(name: "Tiefengruben, Neuhof", latlng: LatLng(50.4731317, 9.6474173)),
  Mapping(
      name: "Todenhausen, Frielendorf", latlng: LatLng(50.9744078, 9.3030801)),
  Mapping(name: "Todenhausen, Wetter", latlng: LatLng(50.9256651, 8.7055773)),
  Mapping(name: "Torkamp Lemgo", latlng: LatLng(52.04073925, 8.90403655)),
  Mapping(
      name: "Trais-Horloff, Hungen",
      latlng: LatLng(50.44943205, 8.890398278202902)),
  Mapping(name: "Trais, Münzenberg", latlng: LatLng(50.465506, 8.7897671)),
  Mapping(name: "Traisa, Mühltal", latlng: LatLng(49.8406707, 8.7016358)),
  Mapping(
      name: "Traisbach[30], Hofbieber", latlng: LatLng(50.5929661, 9.7859685)),
  Mapping(
      name: "Tränkhof, Poppenhausen", latlng: LatLng(50.4985062, 9.8934438)),
  Mapping(name: "Trätzhof, Fulda", latlng: LatLng(50.5830164, 9.6280259)),
  Mapping(name: "Trautheim, Mühltal", latlng: LatLng(49.8326608, 8.6902447)),
  Mapping(name: "Trebur", latlng: LatLng(49.9249814, 8.4055158)),
  Mapping(name: "Trebur", latlng: LatLng(49.9249814, 8.4055158)),
  Mapping(
      name: "Treis, Staufenberg",
      latlng: LatLng(50.65987245, 8.785791031553655)),
  Mapping(name: "Treisbach, Wetter", latlng: LatLng(50.9156347, 8.6488677)),
  Mapping(
      name: "Treisberg, Schmitten im Taunus",
      latlng: LatLng(50.2898909, 8.435062579296524)),
  Mapping(
      name: "Treischfeld, Eiterfeld",
      latlng: LatLng(50.75304395, 9.883880959033759)),
  Mapping(name: "Trendelburg", latlng: LatLng(51.5735358, 9.422415)),
  Mapping(name: "Trendelburg", latlng: LatLng(51.5735358, 9.422415)),
  Mapping(name: "Treysa, Schwalmstadt", latlng: LatLng(50.9124295, 9.1895201)),
  Mapping(
      name: "Tringenstein, Siegbach",
      latlng: LatLng(50.766869299999996, 8.411433684538633)),
  Mapping(
      name: "Trockenbach, Schrecksbach", latlng: LatLng(50.8537739, 9.3018801)),
  Mapping(
      name: "Trockenerfurth, Borken (Hessen)",
      latlng: LatLng(51.040215, 9.2511847)),
  Mapping(name: "Trockenerfurth, Borken", latlng: LatLng(51.040215, 9.2511847)),
  Mapping(
      name: "Trohe, Buseck",
      latlng: LatLng(50.609616700000004, 8.753194210328285)),
  Mapping(name: "Tromm, Grasellenbach", latlng: LatLng(49.6085755, 8.8142632)),
  Mapping(name: "Trösel, Gorxheimertal", latlng: LatLng(49.5275761, 8.7485343)),
  Mapping(
      name: "Trubenhausen, Großalmerode",
      latlng: LatLng(51.2678684, 9.8350073)),
  Mapping(
      name: "Trutzhain, Schwalmstadt", latlng: LatLng(50.9023155, 9.273553)),
  Mapping(name: "Twiste, Twistetal", latlng: LatLng(51.3358508, 8.9661145)),
  Mapping(name: "Twistetal", latlng: LatLng(51.321351, 8.9607277)),
  Mapping(
      name: "Übernthal, Siegbach",
      latlng: LatLng(50.7251932, 8.425863405363298)),
  Mapping(
      name: "Uckersdorf, Herborn",
      latlng: LatLng(50.69623035, 8.269676966684624)),
  Mapping(name: "Udenborn, Wabern", latlng: LatLng(51.0912315, 9.3025585)),
  Mapping(name: "Udenhain, Brachttal", latlng: LatLng(50.3163116, 9.3332062)),
  Mapping(name: "Udenhausen, Grebenau", latlng: LatLng(50.7149457, 9.4480544)),
  Mapping(
      name: "Udenhausen, Grebenstein", latlng: LatLng(51.4641992, 9.4644542)),
  Mapping(name: "Ueberau, Reinheim", latlng: LatLng(49.8239642, 8.8470168)),
  Mapping(
      name: "Uengsterode, Großalmerode", latlng: LatLng(51.2505978, 9.8278158)),
  Mapping(
      name: "Uerzell, Steinau an der Straße",
      latlng: LatLng(50.3927862, 9.431889)),
  Mapping(name: "Uffhausen, Großenlüder", latlng: LatLng(50.579201, 9.5297931)),
  Mapping(
      name: "Ufhausen, Eiterfeld",
      latlng: LatLng(50.7759351, 9.855712035181842)),
  Mapping(name: "Ulfa, Nidda", latlng: LatLng(50.4630912, 9.0070187)),
  Mapping(name: "Ulfen, Sontra", latlng: LatLng(51.0432296, 10.0165815)),
  Mapping(name: "Üllershausen, Schlitz", latlng: LatLng(50.6449992, 9.5778579)),
  Mapping(
      name: "Ulm, Greifenstein", latlng: LatLng(50.58131, 8.317974058320953)),
  Mapping(
      name: "Ulmbach, Steinau an der Straße",
      latlng: LatLng(50.3684507, 9.421224)),
  Mapping(name: "Ulrichstein", latlng: LatLng(50.5759667, 9.1929639)),
  Mapping(name: "Ulrichstein", latlng: LatLng(50.5759667, 9.1929639)),
  Mapping(name: "Ungedanken, Fritzlar", latlng: LatLng(51.1222337, 9.2206992)),
  Mapping(
      name: "Unhausen, Herleshausen", latlng: LatLng(51.0229541, 10.0753279)),
  Mapping(name: "Unshausen, Wabern", latlng: LatLng(51.083155, 9.3729098)),
  Mapping(
      name: "Unter-Abtsteinach, Abtsteinach",
      latlng: LatLng(49.5313653, 8.787867)),
  Mapping(
      name: "Unter-Flockenbach, Gorxheimertal",
      latlng: LatLng(49.5334654, 8.7270045)),
  Mapping(
      name: "Unter-Hainbrunn, Hirschhorn (Neckar)",
      latlng: LatLng(49.4844325, 8.9021145)),
  Mapping(
      name: "Unter-Hainbrunn, Hirschhorn",
      latlng: LatLng(49.4844325, 8.9021145)),
  Mapping(
      name: "Unter-Hambach, Heppenheim", latlng: LatLng(49.6511153, 8.6501233)),
  Mapping(name: "Unter-Mengelbach", latlng: LatLng(49.5866475, 8.7884941)),
  Mapping(
      name: "Unter-Mossau, Mossautal", latlng: LatLng(49.6447766, 8.931835)),
  Mapping(
      name: "Unter-Ostern, Reichelsheim (Odenwald)",
      latlng: LatLng(49.6945955, 8.8609703)),
  Mapping(
      name: "Unter-Ostern, Reichelsheim",
      latlng: LatLng(49.6945955, 8.8609703)),
  Mapping(
      name: "Unter-Scharbach, Grasellenbach",
      latlng: LatLng(49.6122394, 8.8438654)),
  Mapping(
      name: "Unter-Schmitten, Nidda", latlng: LatLng(50.4362733, 9.0227103)),
  Mapping(
      name: "Unter-Schönmattenwag, Wald-Michelbach",
      latlng: LatLng(49.5276418, 8.8649165)),
  Mapping(
      name: "Unter-Schwarz, Schlitz", latlng: LatLng(50.7426656, 9.5864055)),
  Mapping(
      name: "Unter-Seibertenrod, Ulrichstein",
      latlng: LatLng(50.6059185, 9.148557)),
  Mapping(
      name: "Unter-Sensbach, Oberzent", latlng: LatLng(49.5352605, 9.0119897)),
  Mapping(
      name: "Unter-Sorg, Schwalmtal", latlng: LatLng(50.6926133, 9.3033738)),
  Mapping(
      name: "Unter-Wegfurth, Schlitz", latlng: LatLng(50.7566619, 9.5776733)),
  Mapping(
      name: "Unter-Widdersheim, Nidda", latlng: LatLng(50.4300001, 8.9177569)),
  Mapping(
      name: "Unterbernhards, Hilders",
      latlng: LatLng(50.59253995, 9.950514103710663)),
  Mapping(name: "Untergeis, Neuenstein", latlng: LatLng(50.896092, 9.6242859)),
  Mapping(name: "Unterhaun, Hauneck", latlng: LatLng(50.8352455, 9.7180956)),
  Mapping(
      name: "Unterliederbach, Frankfurt am Main",
      latlng: LatLng(50.1104064, 8.5322471)),
  Mapping(
      name: "Unterneurode, Philippsthal",
      latlng: LatLng(50.8632666, 9.9114414)),
  Mapping(name: "Unterneustadt, Kassel", latlng: LatLng(51.3143491, 9.5092304)),
  Mapping(
      name: "Unterreichenbach, Birstein",
      latlng: LatLng(50.3695019, 9.3246629)),
  Mapping(
      name: "Unterrieden, Witzenhausen", latlng: LatLng(51.3414882, 9.884601)),
  Mapping(name: "Unterrosphe, Wetter", latlng: LatLng(50.8891728, 8.7724968)),
  Mapping(
      name: "Untersotzbach, Birstein", latlng: LatLng(50.3396839, 9.323966)),
  Mapping(
      name: "Unterstoppel, Haunetal", latlng: LatLng(50.7461014, 9.7093232)),
  Mapping(
      name: "Unterweisenborn, Schenklengsfeld",
      latlng: LatLng(50.7984115, 9.8344992)),
  Mapping(name: "Urberach, Rödermark", latlng: LatLng(49.973352, 8.7981281)),
  Mapping(name: "Usenborn, Ortenberg", latlng: LatLng(50.3613675, 9.1163484)),
  Mapping(name: "Usingen", latlng: LatLng(50.3342403, 8.5369972)),
  Mapping(
      name: "Usseln, Willingen (Upland)", latlng: LatLng(51.2815772, 8.665754)),
  Mapping(name: "Usseln, Willingen", latlng: LatLng(51.2815772, 8.665754)),
  Mapping(
      name: "Utphe, Hungen",
      latlng: LatLng(50.445931599999994, 8.876584723239304)),
  Mapping(name: "Uttershausen, Wabern", latlng: LatLng(51.0830488, 9.3346672)),
  Mapping(
      name: "Uttrichshausen, Kalbach", latlng: LatLng(50.4128189, 9.7290199)),
  Mapping(name: "Ützhausen, Schlitz", latlng: LatLng(50.6433104, 9.5127416)),
  Mapping(
      name: "Vaake, Reinhardshagen",
      latlng: LatLng(51.47947945, 9.614924072547169)),
  Mapping(name: "Vadenrod, Schwalmtal", latlng: LatLng(50.6638839, 9.2736937)),
  Mapping(name: "Vaitshain, Grebenhain", latlng: LatLng(50.4981782, 9.3573433)),
  Mapping(name: "Vasbeck, Diemelsee", latlng: LatLng(51.3857284, 8.8929558)),
  Mapping(
      name: "Veckerhagen, Reinhardshagen",
      latlng: LatLng(51.495082, 9.6017865)),
  Mapping(
      name: "Veitsteinbach, Kalbach",
      latlng: LatLng(50.3864169, 9.639982329181969)),
  Mapping(name: "Vellmar-West, Vellmar", latlng: LatLng(51.34911, 9.4581736)),
  Mapping(name: "Vellmar", latlng: LatLng(51.3622487, 9.4692331)),
  Mapping(
      name: "Velmeden, Hessisch Lichtenau",
      latlng: LatLng(51.2169419, 9.7969933)),
  Mapping(name: "Verna, Frielendorf", latlng: LatLng(50.9973649, 9.3367105)),
  Mapping(
      name: "Vernawahlshausen, Wesertal",
      latlng: LatLng(51.6256999, 9.6223153)),
  Mapping(name: "Vetzberg, Biebertal", latlng: LatLng(50.6198686, 8.6139982)),
  Mapping(
      name: "Vielbrunn, Michelstadt", latlng: LatLng(49.7120462, 9.0998583)),
  Mapping(name: "Vierbach, Wehretal", latlng: LatLng(51.1682912, 9.9391711)),
  Mapping(
      name: "Viermünden, Frankenberg (Eder)",
      latlng: LatLng(51.1009304, 8.827685)),
  Mapping(
      name: "Viermünden, Frankenberg", latlng: LatLng(51.1009304, 8.827685)),
  Mapping(name: "Viernheim, Viernheim", latlng: LatLng(49.5328435, 8.5852755)),
  Mapping(name: "Viernheim", latlng: LatLng(49.5401174, 8.5788029)),
  Mapping(name: "Vierstöck", latlng: LatLng(49.7138543, 8.8936819)),
  Mapping(name: "Viesebeck, Wolfhagen", latlng: LatLng(51.3567051, 9.1341015)),
  Mapping(
      name: "Villingen, Hungen",
      latlng: LatLng(50.500066950000004, 8.956022385961145)),
  Mapping(name: "Villmar", latlng: LatLng(50.3919037, 8.1916139)),
  Mapping(
      name: "Vöckelsbach, Mörlenbach", latlng: LatLng(49.5662825, 8.7704985)),
  Mapping(
      name: "Vockenhausen, Eppstein", latlng: LatLng(50.1479714, 8.3780284)),
  Mapping(name: "Vockenrod, Antrifttal", latlng: LatLng(50.7760264, 9.231259)),
  Mapping(
      name: "Vockerode-Dinkelberg, Spangenberg",
      latlng: LatLng(51.1383398, 9.7184305)),
  Mapping(name: "Vockerode, Meißner", latlng: LatLng(51.2088766, 9.9061958)),
  Mapping(name: "Vöhl", latlng: LatLng(51.1795627, 8.9276296)),
  Mapping(name: "Vöhl", latlng: LatLng(51.1795627, 8.9276296)),
  Mapping(
      name: "Volkartshain, Grebenhain", latlng: LatLng(50.4470223, 9.2801803)),
  Mapping(name: "Völkershain, Knüllwald", latlng: LatLng(50.97121, 9.4755242)),
  Mapping(
      name: "Völkershausen, Wanfried", latlng: LatLng(51.1608592, 10.160965)),
  Mapping(
      name: "Volkhardinghausen, Bad Arolsen",
      latlng: LatLng(51.3253157, 9.0529029)),
  Mapping(name: "Volkmarsen", latlng: LatLng(51.4230543, 9.0971197)),
  Mapping(name: "Volkmarsen", latlng: LatLng(51.4230543, 9.0971197)),
  Mapping(
      name: "Vollmarshausen, Lohfelden", latlng: LatLng(51.2602719, 9.5641547)),
  Mapping(name: "Vollmerz, Schlüchtern", latlng: LatLng(50.3389784, 9.5985205)),
  Mapping(
      name: "Vollnkirchen, Hüttenberg",
      latlng: LatLng(50.48630245, 8.552393435193615)),
  Mapping(
      name: "Volpertshausen, Hüttenberg",
      latlng: LatLng(50.501138350000005, 8.538586731993245)),
  Mapping(name: "Völzberg, Birstein", latlng: LatLng(50.4532764, 9.2989648)),
  Mapping(name: "Vonhausen, Büdingen", latlng: LatLng(50.2577563, 9.102008)),
  Mapping(
      name: "Vorderer Westen, Kassel", latlng: LatLng(51.3169034, 9.4652003)),
  Mapping(name: "Wabern", latlng: LatLng(51.0941418, 9.3292408)),
  Mapping(name: "Wabern", latlng: LatLng(51.0941418, 9.3292408)),
  Mapping(name: "Wachenbuchen, Maintal", latlng: LatLng(50.168825, 8.8586483)),
  Mapping(name: "Wächtersbach", latlng: LatLng(50.2544683, 9.2924223)),
  Mapping(name: "Wächtersbach", latlng: LatLng(50.2544683, 9.2924223)),
  Mapping(name: "Wagenfurth, Körle", latlng: LatLng(51.1766654, 9.5011693)),
  Mapping(
      name: "Wahlen, Grasellenbach",
      latlng: LatLng(49.61100195, 8.86467144035689)),
  Mapping(name: "Wahlen, Kirtorf", latlng: LatLng(50.8084362, 9.1259891)),
  Mapping(name: "Wahlershausen, Kassel", latlng: LatLng(51.3156353, 9.4395011)),
  Mapping(
      name: "Wahlert, Bad Soden-Salmünster",
      latlng: LatLng(50.3160978, 9.3642687)),
  Mapping(name: "Wahlshausen, Oberaula", latlng: LatLng(50.8528454, 9.4895434)),
  Mapping(name: "Wahnhausen, Fuldatal", latlng: LatLng(51.3634758, 9.5636959)),
  Mapping(
      name: "Walburg, Hessisch Lichtenau",
      latlng: LatLng(51.199753, 9.7669795)),
  Mapping(
      name: "Wald-Amorbach, Breuberg", latlng: LatLng(49.8484699, 9.0238812)),
  Mapping(
      name: "Wald-Erlenbach, Heppenheim",
      latlng: LatLng(49.6436454, 8.7242553)),
  Mapping(name: "Wald-Michelbach", latlng: LatLng(49.573415, 8.8229151)),
  Mapping(name: "Wald-Michelbach", latlng: LatLng(49.573415, 8.8229151)),
  Mapping(name: "Waldacker, Rödermark", latlng: LatLng(50.0026507, 8.8157505)),
  Mapping(
      name: "Waldau (Kassel), Kassel", latlng: LatLng(51.2906624, 9.5186869)),
  Mapping(name: "Waldau, Kassel", latlng: LatLng(51.2906624, 9.5186869)),
  Mapping(
      name: "Waldaubach, Driedorf",
      latlng: LatLng(50.663578900000005, 8.124467051846358)),
  Mapping(
      name: "Waldbrunn (Westerwald)", latlng: LatLng(49.7627937, 9.7981785)),
  Mapping(name: "Waldbrunn", latlng: LatLng(49.7586, 9.80361)),
  Mapping(
      name: "Waldeck (Kernstadt), Waldeck",
      latlng: LatLng(51.11853325, 9.119699179282737)),
  Mapping(name: "Waldeck", latlng: LatLng(51.2425113, 9.0381211)),
  Mapping(name: "Waldeck", latlng: LatLng(51.2425113, 9.0381211)),
  Mapping(name: "Waldems", latlng: LatLng(50.2687109, 8.3700563)),
  Mapping(
      name: "Waldensberg, Wächtersbach", latlng: LatLng(50.3045031, 9.2263593)),
  Mapping(
      name: "Waldernbach, Mengerskirchen",
      latlng: LatLng(50.5367083, 8.1436512)),
  Mapping(name: "Waldgirmes, Lahnau", latlng: LatLng(50.5872058, 8.549731)),
  Mapping(name: "Waldhausen, Weilburg", latlng: LatLng(50.5002623, 8.2506302)),
  Mapping(
      name: "Waldheim, Offenbach am Main",
      latlng: LatLng(50.1154649, 8.8062031)),
  Mapping(name: "Waldkappel", latlng: LatLng(51.1351872, 9.8568782)),
  Mapping(name: "Waldkappel", latlng: LatLng(51.1351872, 9.8568782)),
  Mapping(
      name: "Waldrode, Linsengericht", latlng: LatLng(50.1490146, 9.1978827)),
  Mapping(
      name: "Waldsiedlung, Altenstadt", latlng: LatLng(50.2722026, 8.9699023)),
  Mapping(name: "Waldsolms", latlng: LatLng(50.4427741, 8.4944012)),
  Mapping(name: "Wallau, Biedenkopf", latlng: LatLng(50.9281956, 8.4742411)),
  Mapping(
      name: "Wallau, Hofheim am Taunus", latlng: LatLng(50.0614075, 8.3723765)),
  Mapping(name: "Wallbach, Brensbach", latlng: LatLng(49.7628553, 8.9096903)),
  Mapping(name: "Wallbach, Hünstetten", latlng: LatLng(50.2502682, 8.1972271)),
  Mapping(
      name: "Walldorf, Mörfelden-Walldorf",
      latlng: LatLng(50.0044913, 8.5817868)),
  Mapping(
      name: "Wallenfels, Siegbach",
      latlng: LatLng(50.77882835, 8.439564156070345)),
  Mapping(name: "Wallenrod, Lauterbach", latlng: LatLng(50.6640286, 9.3280085)),
  Mapping(
      name: "Wallenstein, Knüllwald", latlng: LatLng(50.9548057, 9.4852073)),
  Mapping(name: "Wallernhausen, Nidda", latlng: LatLng(50.3938553, 9.0173366)),
  Mapping(name: "Wallersdorf, Grebenau", latlng: LatLng(50.7500255, 9.483819)),
  Mapping(
      name: "Wallerstädten, Groß-Gerau", latlng: LatLng(49.9048847, 8.4529199)),
  Mapping(
      name: "Wallrabenstein, Hünstetten",
      latlng: LatLng(50.2672415, 8.2316478)),
  Mapping(name: "Wallroth, Schlüchtern", latlng: LatLng(50.395533, 9.4974132)),
  Mapping(name: "Walluf", latlng: LatLng(50.0403592, 8.1585795)),
  Mapping(
      name: "Walsdorf, Idstein",
      latlng: LatLng(50.258448900000005, 8.284755856113513)),
  Mapping(
      name: "Waltersbrück, Neuental", latlng: LatLng(50.9960705, 9.2108246)),
  Mapping(name: "Wambach, Schlangenbad", latlng: LatLng(50.1085487, 8.0981778)),
  Mapping(name: "Wanfried", latlng: LatLng(51.1714, 10.1841616)),
  Mapping(name: "Wanfried", latlng: LatLng(51.1714, 10.1841616)),
  Mapping(
      name: "Wangershausen, Frankenberg (Eder)",
      latlng: LatLng(51.0894706, 8.7352131)),
  Mapping(
      name: "Wangershausen, Frankenberg",
      latlng: LatLng(51.0894706, 8.7352131)),
  Mapping(name: "Wartenberg", latlng: LatLng(52.5753945, 13.5175821)),
  Mapping(name: "Warzenbach, Wetter", latlng: LatLng(50.8870963, 8.6475709)),
  Mapping(name: "Waschenbach, Mühltal", latlng: LatLng(49.8045761, 8.7079528)),
  Mapping(
      name: "Wasenberg, Willingshausen", latlng: LatLng(50.8737683, 9.1893264)),
  Mapping(
      name: "Waßmuthshausen, Homberg (Efze)",
      latlng: LatLng(50.9964925, 9.413857)),
  Mapping(
      name: "Waßmuthshausen, Homberg", latlng: LatLng(50.9964925, 9.413857)),
  Mapping(name: "Wattenbach, Söhrewald", latlng: LatLng(51.2127913, 9.5935115)),
  Mapping(name: "Wattenheim, Biblis", latlng: LatLng(49.6851204, 8.4100764)),
  Mapping(name: "Watzelhain, Heidenrod", latlng: LatLng(50.140191, 8.0070207)),
  Mapping(
      name: "Watzenborn-Steinberg, Pohlheim",
      latlng: LatLng(50.530967649999994, 8.717154153967352)),
  Mapping(name: "Watzhahn, Taunusstein", latlng: LatLng(50.1618729, 8.1235699)),
  Mapping(name: "Webern, Modautal", latlng: LatLng(49.7532913, 8.7555311)),
  Mapping(
      name: "Weckesheim, Reichelsheim (Wetterau)",
      latlng: LatLng(50.3630822, 8.8422775)),
  Mapping(
      name: "Weckesheim, Reichelsheim", latlng: LatLng(50.3604002, 8.8421627)),
  Mapping(name: "Wega, Bad Wildungen", latlng: LatLng(51.130007, 9.1751353)),
  Mapping(name: "Wehen, Taunusstein", latlng: LatLng(50.152338, 8.1836014)),
  Mapping(name: "Wehlheiden, Kassel", latlng: LatLng(51.3057409, 9.4628604)),
  Mapping(name: "Wehrda, Haunetal", latlng: LatLng(50.73952, 9.6627437)),
  Mapping(name: "Wehrda, Marburg", latlng: LatLng(50.8377277, 8.7584905)),
  Mapping(name: "Wehren, Fritzlar", latlng: LatLng(51.1692888, 9.2961183)),
  Mapping(name: "Wehretal", latlng: LatLng(51.1439454, 9.9969066)),
  Mapping(name: "Wehrheim", latlng: LatLng(50.3012792, 8.5837524)),
  Mapping(name: "Wehrheim", latlng: LatLng(50.3012792, 8.5837524)),
  Mapping(name: "Wehrshausen, Marburg", latlng: LatLng(50.8114947, 8.725365)),
  Mapping(
      name: "Wehrshausen, Schenklengsfeld",
      latlng: LatLng(50.8069956, 9.8858802)),
  Mapping(name: "Weichersbach, Sinntal", latlng: LatLng(50.3132551, 9.6693441)),
  Mapping(
      name: "Weickartshain, Grünberg",
      latlng: LatLng(50.573084, 9.014978068738898)),
  Mapping(
      name: "Weidelbach, Haiger",
      latlng: LatLng(50.816186099999996, 8.274030655415945)),
  Mapping(
      name: "Weidelbach, Spangenberg", latlng: LatLng(51.1354017, 9.7517116)),
  Mapping(
      name: "Weiden, Bad Sooden-Allendorf",
      latlng: LatLng(51.252729650000006, 10.003488151149003)),
  Mapping(
      name: "Weidenau, Freiensteinau", latlng: LatLng(50.4512995, 9.4411267)),
  Mapping(
      name: "Weidenhausen [22], Marburg",
      latlng: LatLng(50.8066522, 8.7755528)),
  Mapping(
      name: "Weidenhausen, Gladenbach",
      latlng: LatLng(50.7490807, 8.531590758545647)),
  Mapping(
      name: "Weidenhausen, Hüttenberg",
      latlng: LatLng(50.512266800000006, 8.549625772748788)),
  Mapping(name: "Weidenhausen, Meißner", latlng: LatLng(51.2057849, 9.9718706)),
  Mapping(name: "Weiershausen, Weimar", latlng: LatLng(50.7850695, 8.6644879)),
  Mapping(
      name: "Weifenbach, Biedenkopf", latlng: LatLng(50.9427905, 8.5014565)),
  Mapping(name: "Weiher, Mörlenbach", latlng: LatLng(49.5870806, 8.7653572)),
  Mapping(
      name: "Weilbach, Flörsheim am Main",
      latlng: LatLng(50.043234749999996, 8.433765598289419)),
  Mapping(name: "Weilburg", latlng: LatLng(50.4823062, 8.2669053)),
  Mapping(name: "Weilburg", latlng: LatLng(50.4823062, 8.2669053)),
  Mapping(name: "Weilers, Wächtersbach", latlng: LatLng(50.2793374, 9.3130602)),
  Mapping(name: "Weilmünster", latlng: LatLng(50.4327301, 8.3728157)),
  Mapping(name: "Weilrod", latlng: LatLng(50.3333, 8.41667)),
  Mapping(name: "Weimar (Lahn)", latlng: LatLng(50.7542308, 8.7111101)),
  Mapping(name: "Weimar, Ahnatal", latlng: LatLng(51.3651222, 9.3917415)),
  Mapping(name: "Weimar", latlng: LatLng(50.9810486, 11.3296637)),
  Mapping(name: "Weinbach", latlng: LatLng(50.438099, 8.2910665)),
  Mapping(name: "Weinbach", latlng: LatLng(50.438099, 8.2910665)),
  Mapping(name: "Weiperfelden, Waldsolms", latlng: LatLng(50.41866, 8.5589431)),
  Mapping(name: "Weiperz, Sinntal", latlng: LatLng(50.3060424, 9.5969287)),
  Mapping(
      name: "Weipoltshausen, Lohra",
      latlng: LatLng(50.698290650000004, 8.599454764599582)),
  Mapping(name: "Weiskirchen, Rodgau", latlng: LatLng(50.0527824, 8.8879569)),
  Mapping(
      name: "Weißehütte [32], Wesertal", latlng: LatLng(51.5662116, 9.5945397)),
  Mapping(
      name: "Weißenbach, Großalmerode", latlng: LatLng(51.2547477, 9.8490793)),
  Mapping(name: "Weißenborn, Ottrau", latlng: LatLng(50.8221551, 9.434641)),
  Mapping(name: "Weißenborn, Sontra", latlng: LatLng(51.0759956, 9.9638715)),
  Mapping(name: "Weißenborn", latlng: LatLng(50.9238132, 11.8808984)),
  Mapping(name: "Weißenborn", latlng: LatLng(50.9238132, 11.8808984)),
  Mapping(
      name: "Weißenhasel, Nentershausen",
      latlng: LatLng(51.0372987, 9.9341558)),
  Mapping(
      name: "Weißkirchen, Oberursel (Taunus)",
      latlng: LatLng(50.1821328, 8.5967342)),
  Mapping(
      name: "Weißkirchen, Oberursel", latlng: LatLng(50.1821328, 8.5967342)),
  Mapping(
      name: "Weiten-Gesäß, Michelstadt", latlng: LatLng(49.7038417, 9.0462227)),
  Mapping(name: "Weiterode, Bebra", latlng: LatLng(50.9553121, 9.8110251)),
  Mapping(
      name: "Weitershain, Grünberg",
      latlng: LatLng(50.6679408, 8.947695140479372)),
  Mapping(
      name: "Weitershausen, Gladenbach", latlng: LatLng(50.8099278, 8.6283216)),
  Mapping(name: "Weiterstadt", latlng: LatLng(49.9178, 8.5924)),
  Mapping(name: "Weiterstadt", latlng: LatLng(49.9178, 8.5924)),
  Mapping(name: "Welcherod, Frielendorf", latlng: LatLng(50.987259, 9.3088363)),
  Mapping(
      name: "Welferode, Homberg (Efze)", latlng: LatLng(51.0313278, 9.4666622)),
  Mapping(name: "Welferode, Homberg", latlng: LatLng(51.0313278, 9.4666622)),
  Mapping(name: "Welkers, Eichenzell", latlng: LatLng(50.4787539, 9.722325)),
  Mapping(name: "Wellen, Edertal", latlng: LatLng(51.1451281, 9.1790803)),
  Mapping(
      name: "Welleringhausen, Willingen (Upland)",
      latlng: LatLng(51.272651, 8.7330743)),
  Mapping(
      name: "Welleringhausen, Willingen", latlng: LatLng(51.272651, 8.7330743)),
  Mapping(name: "Wellerode, Söhrewald", latlng: LatLng(51.2373562, 9.57244)),
  Mapping(name: "Wellingerode, Meißner", latlng: LatLng(51.2187836, 9.9640404)),
  Mapping(
      name: "Wembach-Hahn, Ober-Ramstadt",
      latlng: LatLng(49.8093447, 8.782842159423904)),
  Mapping(
      name: "Wendershausen, Tann (Rhön)",
      latlng: LatLng(50.6296646, 10.019209172638316)),
  Mapping(name: "Wendershausen, Tann", latlng: LatLng(50.6325322, 10.0171995)),
  Mapping(
      name: "Wendershausen, Witzenhausen",
      latlng: LatLng(51.3204243, 9.8808216)),
  Mapping(
      name: "Wenigenhasungen, Wolfhagen",
      latlng: LatLng(51.3323051, 9.2454027)),
  Mapping(name: "Wenings, Gedern", latlng: LatLng(50.3854987, 9.1965822)),
  Mapping(name: "Wenkbach, Weimar", latlng: LatLng(50.7466115, 8.718153)),
  Mapping(
      name: "Wenzigerode, Bad Zwesten", latlng: LatLng(51.0864455, 9.175721)),
  Mapping(name: "Werdorf, Aßlar", latlng: LatLng(50.607607, 8.42506226227436)),
  Mapping(name: "Werkel, Fritzlar", latlng: LatLng(51.1546303, 9.30894)),
  Mapping(
      name: "Werleshausen, Witzenhausen",
      latlng: LatLng(51.3256887, 9.9149889)),
  Mapping(
      name: "Wermertshausen, Ebsdorfergrund",
      latlng: LatLng(50.6963346, 8.9048457)),
  Mapping(
      name: "Wernborn, Usingen",
      latlng: LatLng(50.358889700000006, 8.571837492900077)),
  Mapping(name: "Wernges, Lauterbach", latlng: LatLng(50.6765676, 9.4224932)),
  Mapping(
      name: "Wernswig, Homberg (Efze)", latlng: LatLng(50.9950961, 9.3649488)),
  Mapping(name: "Wernswig, Homberg", latlng: LatLng(50.9950961, 9.3649488)),
  Mapping(name: "Wersau, Brensbach", latlng: LatLng(49.7773997, 8.8623191)),
  Mapping(name: "Werschau, Brechen", latlng: LatLng(50.3471451, 8.1635048)),
  Mapping(name: "Weschnitz", latlng: LatLng(49.6233401, 8.5957991)),
  Mapping(name: "Wesertal", latlng: LatLng(51.602936, 9.5997418)),
  Mapping(name: "Wesertor, Kassel", latlng: LatLng(51.3238297, 9.5158911)),
  Mapping(
      name: "Westend, Frankfurt am Main", latlng: LatLng(50.118164, 8.6625889)),
  Mapping(
      name: "Westerfeld, Neu-Anspach", latlng: LatLng(50.3125538, 8.5232109)),
  Mapping(name: "Westuffeln, Calden", latlng: LatLng(51.4353781, 9.3258945)),
  Mapping(name: "Wethen, Diemelstadt", latlng: LatLng(51.4910636, 9.0764254)),
  Mapping(name: "Wettenberg", latlng: LatLng(50.6372722, 8.648955)),
  Mapping(name: "Wetter (Hessen)", latlng: LatLng(50.903916, 8.7288444)),
  Mapping(name: "Wetter", latlng: LatLng(51.3879463, 7.3951553)),
  Mapping(
      name: "Wetterburg, Bad Arolsen", latlng: LatLng(51.3829218, 9.0577215)),
  Mapping(
      name: "Wetterfeld, Laubach",
      latlng: LatLng(50.54585325, 8.95111905981361)),
  Mapping(name: "Wettesingen, Breuna", latlng: LatLng(51.4519149, 9.1867713)),
  Mapping(name: "Wettges, Birstein", latlng: LatLng(50.4126762, 9.3397663)),
  Mapping(name: "Wettsaasen, Mücke", latlng: LatLng(50.6310609, 9.0626595)),
  Mapping(name: "Wetzlar [33], Wetzlar", latlng: LatLng(50.565262, 8.5039213)),
  Mapping(name: "Wetzlar", latlng: LatLng(50.5525346, 8.5074406)),
  Mapping(name: "Wetzlos, Haunetal", latlng: LatLng(50.7583309, 9.6299313)),
  Mapping(name: "Weyer, Villmar", latlng: LatLng(50.3672567, 8.2237273)),
  Mapping(
      name: "Weyhers, Ebersburg",
      latlng: LatLng(50.48738015, 9.794203307581604)),
  Mapping(name: "Wichdorf, Niedenstein", latlng: LatLng(51.2261425, 9.3035301)),
  Mapping(
      name: "Wichmannshausen, Sontra",
      latlng: LatLng(51.10566335, 9.964183862125807)),
  Mapping(name: "Wichte, Morschen", latlng: LatLng(51.0516329, 9.5930748)),
  Mapping(name: "Wickenrode, Helsa", latlng: LatLng(51.2581027, 9.7303888)),
  Mapping(
      name: "Wicker, Flörsheim am Main",
      latlng: LatLng(50.02736445, 8.39770869251931)),
  Mapping(
      name: "Wickers, Hilders",
      latlng: LatLng(50.53646285000001, 9.986698154848998)),
  Mapping(
      name: "Wickersrode, Hessisch Lichtenau",
      latlng: LatLng(51.1541486, 9.7393607)),
  Mapping(name: "Wickstadt, Niddatal", latlng: LatLng(50.3065883, 8.8418098)),
  Mapping(
      name: "Widdershausen, Heringen", latlng: LatLng(50.9077349, 10.013051)),
  Mapping(
      name: "Wiebelsbach, Groß-Umstadt", latlng: LatLng(49.8219157, 8.9427217)),
  Mapping(name: "Wiera, Schwalmstadt", latlng: LatLng(50.8813446, 9.1399721)),
  Mapping(
      name: "Wiesbaden-Mitte, Wiesbaden",
      latlng: LatLng(50.08287585, 8.241461999764246)),
  Mapping(
      name: "Wiesbaden-Nordost, Wiesbaden",
      latlng: LatLng(50.0847149, 8.24759334454254)),
  Mapping(
      name: "Wiesbaden-Rheingauviertel/Hollerborn, Wiesbaden",
      latlng: LatLng(50.07474845, 8.207565674950747)),
  Mapping(
      name: "Wiesbaden-Südost, Wiesbaden",
      latlng: LatLng(50.077540150000004, 8.246201224142103)),
  Mapping(
      name: "Wiesbaden-Westend/Bleichstraße, Wiesbaden",
      latlng: LatLng(50.080347, 8.230648197606422)),
  Mapping(
      name: "Wiesbaden, Landeshauptstadt",
      latlng: LatLng(50.0391743, 8.263759115588911)),
  Mapping(name: "Wiesbaden", latlng: LatLng(50.0820384, 8.2416556)),
  Mapping(
      name: "Wieseck, Gießen",
      latlng: LatLng(50.614268499999994, 8.711966789651907)),
  Mapping(name: "Wiesen, Hofbieber", latlng: LatLng(50.5846651, 9.782117)),
  Mapping(
      name: "Wiesenbach, Breidenbach", latlng: LatLng(50.8997738, 8.4262196)),
  Mapping(name: "Wiesenfeld, Burgwald", latlng: LatLng(51.0057023, 8.7502858)),
  Mapping(name: "Wiesental, Butzbach", latlng: LatLng(50.3803319, 8.6140042)),
  Mapping(name: "Wildeck", latlng: LatLng(50.9517487, 9.9658863)),
  Mapping(
      name: "Wildsachsen, Hofheim am Taunus",
      latlng: LatLng(50.1170363, 8.36184)),
  Mapping(
      name: "Wilhelmsdorf, Usingen",
      latlng: LatLng(50.34687115, 8.477836320784023)),
  Mapping(
      name: "Wilhelmshausen, Fuldatal", latlng: LatLng(51.4049861, 9.5802838)),
  Mapping(
      name: "Wilhelmshütte, Dautphetal", latlng: LatLng(50.8661951, 8.5503146)),
  Mapping(
      name: "Willersdorf, Frankenberg (Eder)",
      latlng: LatLng(51.025582, 8.852875)),
  Mapping(
      name: "Willersdorf, Frankenberg", latlng: LatLng(51.025582, 8.852875)),
  Mapping(
      name: "Willershausen, Herleshausen",
      latlng: LatLng(51.0362979, 10.1807792)),
  Mapping(
      name: "Willershausen, Rosenthal (Hessen)",
      latlng: LatLng(51.0009582, 8.8663339)),
  Mapping(
      name: "Willershausen, Rosenthal", latlng: LatLng(51.0009582, 8.8663339)),
  Mapping(name: "Willingen (Upland)", latlng: LatLng(51.2953614, 8.609738)),
  Mapping(name: "Willingen", latlng: LatLng(49.2806022, 6.6317962)),
  Mapping(
      name: "Willingshain, Kirchheim", latlng: LatLng(50.8692693, 9.5108927)),
  Mapping(
      name: "Willingshausen, Willingshausen",
      latlng: LatLng(50.8448348, 9.181149268824896)),
  Mapping(name: "Willingshausen", latlng: LatLng(50.861196, 9.2116383)),
  Mapping(name: "Willofs, Schlitz", latlng: LatLng(50.6805173, 9.473832)),
  Mapping(name: "Wilmshausen, Bensheim", latlng: LatLng(49.6954443, 8.6613432)),
  Mapping(
      name: "Wilsbach, Bischoffen",
      latlng: LatLng(50.70383095, 8.548901267635326)),
  Mapping(name: "Wilsenroth, Dornburg", latlng: LatLng(50.5235131, 8.0248483)),
  Mapping(
      name: "Wincherode, Neukirchen", latlng: LatLng(50.8399722, 9.3382763)),
  Mapping(
      name: "Windeck, Rüdesheim am Rhein",
      latlng: LatLng(49.9962298, 7.9342575)),
  Mapping(name: "Windecken, Nidderau", latlng: LatLng(50.2223837, 8.8792511)),
  Mapping(
      name: "Winden, Weilrod",
      latlng: LatLng(50.380223900000004, 8.383952943804506)),
  Mapping(name: "Windhain, Mücke", latlng: LatLng(50.6599303, 9.0122994)),
  Mapping(name: "Windhausen, Feldatal", latlng: LatLng(50.6518356, 9.2010636)),
  Mapping(
      name: "Wingershausen, Schotten", latlng: LatLng(50.4670453, 9.1315952)),
  Mapping(
      name: "Wingsbach, Taunusstein", latlng: LatLng(50.1664673, 8.1491781)),
  Mapping(name: "Winkel, Lindenfels", latlng: LatLng(49.6940066, 8.7636422)),
  Mapping(
      name: "Winkel, Oestrich-Winkel", latlng: LatLng(50.0029526, 8.020638)),
  Mapping(
      name: "Winkels, Mengerskirchen",
      latlng: LatLng(50.5487675, 8.176285593346778)),
  Mapping(name: "Winnen, Allendorf", latlng: LatLng(50.6947435, 8.8299807)),
  Mapping(
      name: "Winnerod, Reiskirchen",
      latlng: LatLng(50.6094416, 8.863611829027718)),
  Mapping(
      name: "Winterkasten, Lindenfels", latlng: LatLng(49.7057471, 8.7855559)),
  Mapping(
      name: "Winterscheid, Gilserberg", latlng: LatLng(50.9279259, 9.0409072)),
  Mapping(name: "Wippenbach, Ortenberg", latlng: LatLng(50.3568563, 9.0405159)),
  Mapping(
      name: "Wippershain, Schenklengsfeld",
      latlng: LatLng(50.8314972, 9.7710842)),
  Mapping(name: "Wirbelau, Runkel", latlng: LatLng(50.4443139, 8.2219525)),
  Mapping(
      name: "Wirmighausen, Diemelsee", latlng: LatLng(51.3465398, 8.8270395)),
  Mapping(
      name: "Wirtheim, Biebergemünd", latlng: LatLng(50.2226675, 9.2639004)),
  Mapping(name: "Wisper, Heidenrod", latlng: LatLng(50.1566713, 7.9786821)),
  Mapping(
      name: "Wissels, Künzell", latlng: LatLng(50.5408428, 9.7599775444884)),
  Mapping(
      name: "Wisselsheim, Bad Nauheim", latlng: LatLng(50.3766625, 8.7643962)),
  Mapping(name: "Wisselsrod, Dipperz", latlng: LatLng(50.5360861, 9.7781289)),
  Mapping(
      name: "Wissenbach, Eschenburg",
      latlng: LatLng(50.79675805, 8.319834444308011)),
  Mapping(name: "Wißmar, Wettenberg", latlng: LatLng(50.6348015, 8.6788029)),
  Mapping(
      name: "Wittelsberg, Ebsdorfergrund", latlng: LatLng(50.75935, 8.855036)),
  Mapping(
      name: "Wittgenborn, Wächtersbach", latlng: LatLng(50.2853398, 9.2632853)),
  Mapping(name: "Wittges, Hofbieber", latlng: LatLng(50.5868632, 9.873347)),
  Mapping(name: "Witzenhausen", latlng: LatLng(51.3331901, 9.8434192)),
  Mapping(name: "Witzenhausen", latlng: LatLng(51.3331901, 9.8434192)),
  Mapping(
      name: "Wixhausen, Darmstadt",
      latlng: LatLng(49.93706775, 8.682490373530383)),
  Mapping(name: "Wohnbach, Wölfersheim", latlng: LatLng(50.4290623, 8.8310109)),
  Mapping(name: "Wohnfeld, Ulrichstein", latlng: LatLng(50.5729952, 9.1246791)),
  Mapping(name: "Wohra, Wohratal", latlng: LatLng(50.9353378, 8.9463864)),
  Mapping(name: "Wohratal", latlng: LatLng(50.9361888, 8.9391866)),
  Mapping(name: "Wolf, Büdingen", latlng: LatLng(50.3092212, 9.0882273)),
  Mapping(
      name: "Wölf, Eiterfeld",
      latlng: LatLng(50.789130650000004, 9.803367544532595)),
  Mapping(
      name: "Wolfenhausen, Weilmünster", latlng: LatLng(50.3818557, 8.3186741)),
  Mapping(name: "Wolferborn, Büdingen", latlng: LatLng(50.3304079, 9.1953231)),
  Mapping(
      name: "Wolferode, Stadtallendorf", latlng: LatLng(50.8928014, 8.9866497)),
  Mapping(
      name: "Wolfershausen, Felsberg", latlng: LatLng(51.1843725, 9.4447018)),
  Mapping(
      name: "Wolfershausen, Felsberg", latlng: LatLng(51.1843725, 9.4447018)),
  Mapping(
      name: "Wölfershausen, Heringen", latlng: LatLng(50.8757572, 9.9907079)),
  Mapping(name: "Wölfersheim", latlng: LatLng(50.4019069, 8.8151385)),
  Mapping(name: "Wölfersheim", latlng: LatLng(50.4019069, 8.8151385)),
  Mapping(name: "Wolferts, Dipperz", latlng: LatLng(50.5376943, 9.8620311)),
  Mapping(name: "Wolfgang, Hanau", latlng: LatLng(50.1227647, 8.9593727)),
  Mapping(
      name: "Wolfgruben, Dautphetal", latlng: LatLng(50.8726837, 8.5448024)),
  Mapping(name: "Wolfhagen", latlng: LatLng(51.3333355, 9.1968854)),
  Mapping(name: "Wolfhagen", latlng: LatLng(51.3333355, 9.1968854)),
  Mapping(
      name: "Wolfsanger-Hasenhecke, Kassel",
      latlng: LatLng(51.33609, 9.5400569)),
  Mapping(name: "Wolfshausen, Weimar", latlng: LatLng(50.7336107, 8.7390211)),
  Mapping(
      name: "Wolfskaute, Rauschenberg", latlng: LatLng(50.898212, 8.8999709)),
  Mapping(
      name: "Wolfskehlen, Riedstadt", latlng: LatLng(49.8537166, 8.4985096)),
  Mapping(name: "Wolfterode, Meißner", latlng: LatLng(51.2234295, 9.9164601)),
  Mapping(name: "Wölfterode, Sontra", latlng: LatLng(51.020813, 10.0101908)),
  Mapping(name: "Wollmar, Münchhausen", latlng: LatLng(50.9718408, 8.6829469)),
  Mapping(name: "Wollmerschied, Lorch", latlng: LatLng(50.1165538, 7.8603309)),
  Mapping(name: "Wollrode, Guxhagen", latlng: LatLng(51.2116731, 9.5102687)),
  Mapping(name: "Wöllstadt", latlng: LatLng(50.2825991, 8.7598863)),
  Mapping(
      name: "Wolzhausen, Breidenbach", latlng: LatLng(50.8670932, 8.4736542)),
  Mapping(
      name: "Wommelshausen, Bad Endbach",
      latlng: LatLng(50.7655619, 8.4948398)),
  Mapping(name: "Wommen, Herleshausen", latlng: LatLng(51.0142699, 10.12093)),
  Mapping(name: "Worfelden, Büttelborn", latlng: LatLng(49.9290357, 8.5493555)),
  Mapping(
      name: "Wörsdorf, Idstein",
      latlng: LatLng(50.244397899999996, 8.25429538234403)),
  Mapping(name: "Wrexen, Diemelstadt", latlng: LatLng(51.5090795, 8.9975827)),
  Mapping(
      name: "Wülmersen, Trendelburg", latlng: LatLng(51.6079835, 9.4329799)),
  Mapping(name: "Wünschbach", latlng: LatLng(47.2083378, 15.6071627)),
  Mapping(
      name: "Wünschen-Moos, Grebenhain", latlng: LatLng(50.5066226, 9.4241131)),
  Mapping(name: "Würges, Bad Camberg", latlng: LatLng(50.2831311, 8.2790599)),
  Mapping(name: "Würzberg, Michelstadt", latlng: LatLng(49.6492801, 9.0809883)),
  Mapping(name: "Wurzelbach, Lautertal", latlng: LatLng(49.7416001, 8.7081696)),
  Mapping(
      name: "Wüstems, Waldems",
      latlng: LatLng(50.255152100000004, 8.387665382971338)),
  Mapping(name: "Wüstensachsen", latlng: LatLng(50.4994621, 10.0025598)),
  Mapping(
      name: "Wüstfeld, Schenklengsfeld", latlng: LatLng(50.8241822, 9.8096987)),
  Mapping(
      name: "Wüstwillenroth, Birstein", latlng: LatLng(50.4222625, 9.3260962)),
  Mapping(name: "Zahmen, Grebenhain", latlng: LatLng(50.5125827, 9.4325421)),
  Mapping(name: "Zeilbach, Feldatal", latlng: LatLng(50.6389411, 9.1536568)),
  Mapping(name: "Zeilhard, Reinheim", latlng: LatLng(49.8449803, 8.7904808)),
  Mapping(
      name: "Zeilsheim, Frankfurt am Main",
      latlng: LatLng(50.0955649, 8.4947834)),
  Mapping(name: "Zell, Bad König", latlng: LatLng(49.7202352, 8.9943016)),
  Mapping(name: "Zell, Bensheim", latlng: LatLng(49.6751508, 8.6442677)),
  Mapping(name: "Zell, Fulda", latlng: LatLng(50.51339395, 9.625473215947439)),
  Mapping(name: "Zell, Romrod", latlng: LatLng(50.7275006, 9.2000877)),
  Mapping(name: "Zella, Willingshausen", latlng: LatLng(50.8754341, 9.255194)),
  Mapping(
      name: "Zellhausen, Mainhausen", latlng: LatLng(50.0142413, 8.9932502)),
  Mapping(name: "Zennern, Wabern", latlng: LatLng(51.1099183, 9.315984)),
  Mapping(
      name: "Zeppelinheim, Neu-Isenburg",
      latlng: LatLng(50.0345008, 8.6140713)),
  Mapping(name: "Ziegelhütte, Sinntal", latlng: LatLng(50.3487998, 9.7150672)),
  Mapping(
      name: "Ziegenhagen, Witzenhausen", latlng: LatLng(51.3652664, 9.7539507)),
  Mapping(
      name: "Ziegenhain, Schwalmstadt", latlng: LatLng(50.9112278, 9.2391073)),
  Mapping(name: "Zierenberg", latlng: LatLng(51.3678614, 9.3001694)),
  Mapping(name: "Zierenberg", latlng: LatLng(51.3678614, 9.3001694)),
  Mapping(name: "Zimmersrode, Neuental", latlng: LatLng(51.0087961, 9.2264185)),
  Mapping(name: "Zipfen, Otzberg", latlng: LatLng(49.831206, 8.9206445)),
  Mapping(
      name: "Zirkenbach, Fulda", latlng: LatLng(50.5217684, 9.641289476507804)),
  Mapping(name: "Zorn, Heidenrod", latlng: LatLng(50.1602098, 7.9165502)),
  Mapping(name: "Zotzenbach, Rimbach", latlng: LatLng(49.6053102, 8.761914)),
  Mapping(name: "Züntersbach, Sinntal", latlng: LatLng(50.3129424, 9.731573)),
  Mapping(name: "Züschen, Fritzlar", latlng: LatLng(51.1737776, 9.2256175)),
  Mapping(name: "Zwergen, Liebenau", latlng: LatLng(51.4816539, 9.298378)),
  Mapping(name: "Zwingenberg", latlng: LatLng(49.7247617, 8.612855)),
  Mapping(name: "Zwingenberg", latlng: LatLng(49.7247617, 8.612855)),
];

List<String> fehlende = [];
