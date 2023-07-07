// To parse this JSON data, do
//
//     final userConfig = userConfigFromJson(jsonString);

import 'dart:convert';

import 'package:latlong2/latlong.dart';

List<UserConfig> userConfigListFromJson(String str) =>
    List<UserConfig>.from(json.decode(str).map((x) => UserConfig.fromJson(x)));

String userConfigListToJson(List<UserConfig> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

UserConfig userConfigFromJson(String str) =>
    UserConfig.fromJson(json.decode(str));

String userConfigToJson(UserConfig data) => json.encode(data.toJson());

class UserConfig {
  UserConfig({
    required this.version,
    required this.user,
    required this.profile,
  });

  String version;
  User user;
  Profile? profile;

  UserConfig.empty({
    this.version = "",
    this.user = const User.empty(),
    required this.profile,
  });

  bool isValid() {
    return user.uuid.isNotEmpty;
  }

  factory UserConfig.fromJson(Map<String, dynamic> json) => UserConfig(
        version: json["version"],
        user: User.fromJson(json["user"]),
        profile: Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "user": user.toJson(),
        "profile": profile!.toJson(),
      };
}

class Profile {
  Profile({
    required this.profilId,
    required this.uuid,
    required this.displayName,
    required this.avatarid,
    required this.tier,
    required this.rauchen,
    required this.bewertung,
    required this.fahrzeug,
    required this.kmgefahren,
    required this.punktegesammelt,
    required this.uebermich,
    required this.abholpunkt,
    required this.lat,
    required this.lng,
    required this.geschlecht,
  });

  int profilId;
  String uuid;
  String displayName;
  int avatarid;
  bool tier;
  bool rauchen;
  double bewertung;
  List<String> fahrzeug;
  double kmgefahren;
  int punktegesammelt;

  double lat;
  double lng;
  String abholpunkt;
  String uebermich;
  int geschlecht;

  Profile.empty({
    this.profilId = 0,
    this.uuid = "",
    this.displayName = "",
    this.avatarid = 1,
    this.tier = false,
    this.rauchen = false,
    this.bewertung = 0.0,
    this.fahrzeug = const [],
    this.kmgefahren = 0.0,
    this.punktegesammelt = 0,
    this.lat = 0,
    this.lng = 0,
    this.abholpunkt = "Abholpunkt",
    this.uebermich = "ueber mich",
    this.geschlecht = 3,
  });

  void setFahrzeuge(List<String> values) {
    fahrzeug.clear();
    fahrzeug.addAll(values);
  }

  void setHomeLatLng(LatLng latlng) {
    this.lat = latlng.latitude;
    this.lng = latlng.longitude;
  }

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        profilId: json["profilId"],
        uuid: json["uuid"],
        displayName: json["displayName"],
        avatarid: json["avatarid"],
        tier: json["tier"],
        rauchen: json["rauchen"],
        bewertung: json["bewertung"]?.toDouble(),
        fahrzeug: List<String>.from(json["fahrzeug"].map((x) => x)),
        kmgefahren: json["kmgefahren"]?.toDouble(),
        punktegesammelt: json["punktegesammelt"],
        uebermich: json["uebermich"],
        abholpunkt: json["abholpunkt"],
        lat: json["lat"],
        lng: json["lng"],
        geschlecht: json["geschlecht"],
      );

  Map<String, dynamic> toJson() => {
        "profilId": profilId,
        "uuid": uuid,
        "displayName": displayName,
        "avatarid": avatarid,
        "tier": tier,
        "rauchen": rauchen,
        "bewertung": bewertung,
        "fahrzeug": List<dynamic>.from(fahrzeug.map((x) => x)),
        "kmgefahren": kmgefahren,
        "punktegesammelt": punktegesammelt,
        "uebermich": uebermich,
        "abholpunkt": abholpunkt,
        "lat": lat,
        "lng": lng,
        "geschlecht": geschlecht,
      };
}

class User {
  User({
    required this.fdnummer,
    required this.vorname,
    required this.nachname,
    required this.passwort,
    required this.email,
    required this.geburtsdatum,
    required this.uuid,
    required this.id,
    required this.profilId,
  });

  final String fdnummer;
  final String vorname;
  final String nachname;
  final String passwort;
  final String email;
  final String geburtsdatum;
  final String uuid;
  final int id;
  final int profilId;

  const User.empty({
    this.fdnummer = "",
    this.vorname = "",
    this.nachname = "",
    this.passwort = "",
    this.email = "",
    this.geburtsdatum = "",
    this.uuid = "",
    this.id = 0,
    this.profilId = 0,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        fdnummer: json["fdnummer"],
        vorname: json["vorname"],
        nachname: json["nachname"],
        passwort: json["passwort"],
        email: json["email"],
        geburtsdatum: json["geburtsdatum"],
        uuid: json["uuid"],
        id: json["id"],
        profilId: json["profilId"],
      );

  Map<String, dynamic> toJson() => {
        "fdnummer": fdnummer,
        "vorname": vorname,
        "nachname": nachname,
        "passwort": passwort,
        "email": email,
        "geburtsdatum": geburtsdatum,
        "uuid": uuid,
        "id": id,
        "profilId": profilId,
      };
}
