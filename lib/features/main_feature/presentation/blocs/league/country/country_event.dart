import 'package:equatable/equatable.dart';

class CountryEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AllCountryFetched extends CountryEvent {}

class CountryFetched extends CountryEvent {
  int countryId;
  CountryFetched({required this.countryId});
  @override
  // TODO: implement props
  List<Object?> get props => [countryId];
}
