abstract class WeatherEvent {}

class SearchWeatherEvent extends WeatherEvent {
  final String location;

  SearchWeatherEvent(this.location);
}
