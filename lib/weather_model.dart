class WeatherModel {
  final int? id;
  final String name;
  final WeatherCoord coord;
  final WeatherMain main;
  final int? dt;
  final WeatherWind wind;
  final WeatherSys sys;
  final dynamic rain;
  final dynamic snow;
  final WeatherClouds clouds;
  final List<WeatherCondition> weather;

  WeatherModel({
    required this.id,
    required this.name,
    required this.coord,
    required this.main,
    required this.dt,
    required this.wind,
    required this.sys,
    required this.rain,
    required this.snow,
    required this.clouds,
    required this.weather,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      id: json['id'],
      name: json['name'],
      coord: WeatherCoord.fromJson(json['coord']),
      main: WeatherMain.fromJson(json['main']),
      dt: json['dt'] ?? 0,
      wind: WeatherWind.fromJson(json['wind']),
      sys: WeatherSys.fromJson(json['sys']),
      rain: json['rain'] ?? '',
      snow: json['snow'] ?? '',
      clouds: WeatherClouds.fromJson(json['clouds']),
      weather: (json['weather'] as List<dynamic>)
          .map((item) => WeatherCondition.fromJson(item))
          .toList(),
    );
  }
}

class WeatherCoord {
  final double lat;
  final double lon;

  WeatherCoord({required this.lat, required this.lon});

  factory WeatherCoord.fromJson(Map<String, dynamic> json) {
    return WeatherCoord(lat: json['lat'], lon: json['lon']);
  }
}

class WeatherMain {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int? pressure;
  final int? humidity;
  final int? seaLevel;
  final int? groundLevel;

  WeatherMain({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.groundLevel,
  });

  factory WeatherMain.fromJson(Map<String, dynamic> json) {
    return WeatherMain(
      temp: json['temp'],
      feelsLike: json['feels_like'],
      tempMin: json['temp_min'],
      tempMax: json['temp_max'],
      pressure: json['pressure'],
      humidity: json['humidity'],
      seaLevel: json['sea_level'],
      groundLevel: json['grnd_level'],
    );
  }
}

class WeatherWind {
  final double speed;
  final int? deg;

  WeatherWind({required this.speed, required this.deg});

  factory WeatherWind.fromJson(Map<String, dynamic> json) {
    return WeatherWind(speed: json['speed'], deg: json['deg']);
  }
}

class WeatherSys {
  final String country;

  WeatherSys({required this.country});

  factory WeatherSys.fromJson(Map<String, dynamic> json) {
    return WeatherSys(country: json['country']);
  }
}

class WeatherClouds {
  final int? all;

  WeatherClouds({required this.all});

  factory WeatherClouds.fromJson(Map<String, dynamic> json) {
    return WeatherClouds(all: json['all']);
  }
}

class WeatherCondition {
  final int? id;
  final String main;
  final String description;
  final String icon;

  WeatherCondition({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherCondition.fromJson(Map<String, dynamic> json) {
    return WeatherCondition(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}
