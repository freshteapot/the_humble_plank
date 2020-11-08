import 'dart:convert';
import 'package:openapi/api.dart';

class PlankHistory {
  List<Plank> records;

  PlankHistory();

  PlankHistory.loadJson(String jsonString) {
    records = List<Plank>();
    List decoded = jsonDecode(jsonString);
    for (var rawRecord in decoded) {
      records.add(Plank.fromJson(rawRecord));
    }
  }
}
