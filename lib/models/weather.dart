class Weather {
  final String condition;
  final String temperature;
  final String feelsLike;

  Weather({
    required this.condition,
    required this.temperature,
    required this.feelsLike,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      condition: json['current_condition'][0]['weatherDesc'][0]['value'],
      temperature: json['current_condition'][0]['temp_C'],
      feelsLike: json['current_condition'][0]['FeelsLikeC'],
    );
  }
}
