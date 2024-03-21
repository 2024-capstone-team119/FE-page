class Schedule {
  String title;
  Schedule(this.title);

  @override
  String toString() => title;
}

Map<DateTime, dynamic> scheduleList = {
  DateTime(2024, 3, 21): [
    Schedule('2024 IU HER WORLD TOUR CONCERT IN SEOUL'),
    Schedule('2024 박지윤 콘서트 Love is my song'),
    Schedule('2024 TXT FANLIVE PRESENT X TOGETHER'),
  ],
  DateTime(2024, 3, 24): [
    Schedule('에릭남 내한공연 ERIC NAM Live in Seoul'),
    Schedule('2024 Whee In 1ST WORLD TOUR WHEE IN THE MOOD BEYOND'),
  ],
  DateTime(2024, 3, 25): [
    Schedule('ITZY 2ND WORLD TOUR <BORN TO BE> in SEOUL'),
  ],
  DateTime(2024, 3, 29): [
    Schedule('T Factory x B tv 콘썰트 필모톡 with 이동휘'),
    Schedule('애쉬밴드의 Melting Jazz'),
  ],
};
