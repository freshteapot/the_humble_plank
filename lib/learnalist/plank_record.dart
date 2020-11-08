class PlankRecord {
  bool showIntervals;
  int intervalTime;
  int beginningTime;
  int currentTime;
  int timerNow;
  int intervalTimerNow;
  int laps;

  PlankRecord(
      {this.showIntervals,
      this.intervalTime,
      this.beginningTime,
      this.currentTime,
      this.timerNow,
      this.intervalTimerNow,
      this.laps});

  PlankRecord.fromJson(Map<String, dynamic> json) {
    showIntervals = json['showIntervals'];
    intervalTime = json['intervalTime'];
    beginningTime = json['beginningTime'];
    currentTime = json['currentTime'];
    timerNow = json['timerNow'];
    intervalTimerNow = json['intervalTimerNow'];
    laps = json['laps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['showIntervals'] = this.showIntervals;
    data['intervalTime'] = this.intervalTime;
    data['beginningTime'] = this.beginningTime;
    data['currentTime'] = this.currentTime;
    data['timerNow'] = this.timerNow;
    data['intervalTimerNow'] = this.intervalTimerNow;
    data['laps'] = this.laps;
    return data;
  }
}
