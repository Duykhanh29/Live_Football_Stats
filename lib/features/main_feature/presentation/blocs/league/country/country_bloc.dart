import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/leagues/get_all_country_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/leagues/get_country_uc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/country/contry_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/country/country_event.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  GetCountryUseCase? countryUseCase;
  GetAllCountryUseCase? allCountryUseCase;
  CountryBloc({required this.allCountryUseCase, required this.countryUseCase})
      : super(CountryInitial()) {
    on<AllCountryFetched>(onAllCountryFetchedEvent);
  }
  Future onAllCountryFetchedEvent(
      AllCountryFetched event, Emitter<CountryState> emit) async {
    try {
      final result = await allCountryUseCase!.call();
      if (result != null) {
        result.fold((l) => emit(CountryFetchFail(message: l.message)),
            (r) => emit(AllCountryFetchSuccess(allCountry: r)));
      } else {
        emit(CountryFetchFail());
      }
    } catch (e) {
      emit(CountryFetchFail());
    }
  }
}
