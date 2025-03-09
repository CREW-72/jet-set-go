class TravelTip {
  final String title;
  final List<String> tips;

  TravelTip({
    required this.title,
    required this.tips,
  });

  factory TravelTip.fromJson(Map<String, dynamic> json) {
    return TravelTip(
      title: json['title'],
      tips: List<String>.from(json['tips']),
    );
  }
}