import 'package:openapi/api.dart';

class Challenge {
  String uuid = "";
  String description = "";

  List<ChallengeInfoAllOfUsers> users = [];
  /* List of records, specific to the kind */
  List<ChallengePlankRecord> records = [];

  Challenge({this.uuid, this.description, this.users, this.records});

  Challenge.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['description'] = this.description;
    return data;
  }

  Challenge.empty() {
    uuid = "";
    description = "";
    users = [];
    records = [];
  }
}
