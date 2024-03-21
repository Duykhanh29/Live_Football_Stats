import 'package:equatable/equatable.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';

class CountryState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CountryInitial extends CountryState {}

class CountryLoading extends CountryState {}

class AllCountryFetchSuccess extends CountryState {
  List<Country>? allCountry;
  AllCountryFetchSuccess({required this.allCountry});
  @override
  // TODO: implement props
  List<Object?> get props => [allCountry];
}

class CountryFetchSuccess extends CountryState {
  Country? country;
  CountryFetchSuccess({required this.country});
  @override
  // TODO: implement props
  List<Object?> get props => [country];
}

class CountryFetchFail extends CountryState {
  String? message;
  CountryFetchFail({this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
