import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:osrm_map_part/config/app_constants.dart';

import '../../../services/osrm/model/ortsnamen_mapping.dart';

class OrtsnamenAutoCompleteWidget extends StatelessWidget {
  AppConstants appConstants = AppConstants();
  bool showBorder = true;
  String labelText = "Ortsname";
  String initalValue = "Hochschule Fulda";
  MapController? mapController = MapController();
  Function(LatLng)? setMarker;
  Function(String) onSelected;

  String text = "Hochschule Fulda";

  OrtsnamenAutoCompleteWidget(
      {required this.onSelected,
      this.initalValue = "Hochschule Fulda",
      this.mapController,
      this.setMarker,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Autocomplete<Mapping>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        return generateOptionen(textEditingValue.text);
      },
      displayStringForOption: (Mapping option) => option.name,
      fieldViewBuilder: (BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted) {
        //return CustomFormTextField(formKey: formKey);
        return TextField(
          controller: fieldTextEditingController,
          focusNode: fieldFocusNode,
          style: const TextStyle(fontWeight: FontWeight.bold),
          onChanged: (entry) {
            text = entry;
          },
          onSubmitted: (entry) {
            print("Dieser Eintrag: ${entry}");
          },
          decoration: InputDecoration(
            isDense: true,
            //hintText: "Ortsname",
            labelText: labelText,
            filled: true,
            fillColor: Colors.white,
            focusColor: Colors.white,
            hoverColor: Colors.white,
            errorStyle: TextStyle(
              color: Colors.black,
              fontSize: 10,
            ),
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: showBorder
                  ? BorderSide(
                      width: 2,
                      color: appConstants.turquoise,
                    )
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide: showBorder
                  ? BorderSide(
                      width: 2,
                    )
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
      initialValue: TextEditingValue(text: initalValue),
      onSelected: (Mapping selection) {
        print('Selected: ${selection.name}');
        onSelected(selection.name);
        text = selection.name;

        // falls Karte, setzte den Punkt
        if (mapController != null) {
          mapController!.move(selection.latlng, 13);
          setMarker!(selection.latlng);
        }
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<Mapping> onSelected,
          Iterable<Mapping> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 300,
                height: 300,
                color: appConstants.turquoise,
                child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: min(options.length, 100),
                  itemBuilder: (BuildContext context, int index) {
                    final Mapping option = options.elementAt(index);

                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: ListTile(
                        title: Text(option.toString(),
                            style: const TextStyle(color: Colors.white)),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _normalizeSearchTerm(TextEditingValue textEditingValue) {
    return textEditingValue.text
        .toLowerCase()
        .replaceAll(RegExp('[^a-zöäüß]'), ' ')
        .replaceAll("  ", " ")
        .replaceAll("  ", " ")
        .replaceAll("  ", " ")
        .trim();
  }

  String getValue() {
    return text;
  }
}
