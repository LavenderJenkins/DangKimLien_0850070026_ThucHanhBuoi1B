import 'dart:async';

import 'package:bloc_learning/blocs/weather_event.dart';
import 'package:bloc_learning/blocs/weather_state.dart';
import 'package:bloc_learning/weather_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<SearchWeatherEvent>((event, emit) async {
      emit(WeatherLoading());

      try {
        final weatherData =
            await WeatherRepository().fetchWeatherByLocation(event.location);
        print(weatherData);
        emit(WeatherLoaded(weatherData));
      } catch (error) {
        emit(WeatherError('Please try another location'));
      }
    });
  }
}
