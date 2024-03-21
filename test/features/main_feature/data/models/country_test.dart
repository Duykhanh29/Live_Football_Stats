import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:live_football_stats/features/main_feature/data/models/country.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main() {
  CountryModel countryModel = CountryModel(id: 60, name: "spain");
  test("SHould get country model", () {
    //assert
    expect(countryModel, isA<CountryModel>());
  });
  group("from json", () {
    test(
        "Should successfully deserialize a JSON map into a CountryModel object and ensure that the resulting object matches the expected ",
        () {
      /// Arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('league/a_country.json'));

      /// Act
      final result = CountryModel.fromJson(jsonMap);
      print('Result: $result');
      print('Expected: $countryModel');

      /// Assert
      expect(result.id, countryModel.id);
      expect(result.name, countryModel.name);
    });
  });
  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        /// Arrange
        final result = countryModel.toJson();

        /// Act
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('league/a_country.json'));

        /// Assert
        expect(result, jsonMap);
      },
    );
  });
}
