import 'package:bloc_learning/blocs/weather_bloc.dart';
import 'package:bloc_learning/blocs/weather_event.dart';
import 'package:bloc_learning/blocs/weather_state.dart';
import 'package:bloc_learning/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remixicon/remixicon.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => WeatherBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 200,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: buildSearchForm(context),
        ),
        body: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WeatherLoaded) {
              return buildWeatherData(context, state.weather);
            } else if (state is WeatherError) {
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Remix.error_warning_line,
                      color: Colors.red,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ));
  }

  Widget buildSearchForm(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: _locationController,
            decoration: const InputDecoration(
              hintText: 'Enter location',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final location = _locationController.text;
              weatherBloc.add(SearchWeatherEvent(location));
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  Map<String, IconData> icons = {
    'clear sky': Remix.sun_line,
    'few clouds': Remix.sun_cloudy_line,
    'scattered clouds': Remix.cloud_line,
    'overcast clouds': Remix.sun_cloudy_fill,
    'broken clouds': Remix.foggy_line,
    'shower rain': Remix.showers_line,
    'rain': Remix.rainy_line,
    'thunderstorm': Remix.thunderstorms_line,
    'snow': Remix.snowy_line,
    'mist': Remix.foggy_line,
  };

  Widget buildWeatherData(BuildContext context, WeatherModel weatherData) {
    print(weatherData);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Remix.map_pin_2_line),
              const SizedBox(width: 10),
              Text(
                'Location: ${weatherData.name}',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icons[weatherData.weather![0].description]),
              const SizedBox(width: 10),
              Text(
                'Temperature: ${(weatherData.main.temp - 273.15).toStringAsFixed(2)}°C',
                style: const TextStyle(fontSize: 20),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Remix.temp_hot_line),
              const SizedBox(width: 10),
              Text(
                'Feel like: ${(weatherData.main.feelsLike - 273.15).toStringAsFixed(2)}°C',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Remix.information_line),
              const SizedBox(width: 10),
              Text(
                'Description: ${weatherData.weather![0].description}',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
