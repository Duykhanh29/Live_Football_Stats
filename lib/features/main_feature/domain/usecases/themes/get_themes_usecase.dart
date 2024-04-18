import 'package:hive_flutter/hive_flutter.dart';
import 'package:live_football_stats/core/injection/injection_container.dart';

import '../../../../../core/constants/string_constants.dart';

abstract class GetThemeUsecase {
  Future<bool?> getCurrentTheme();
  Future<void> changeTheme(bool value);
}

class GetThemeUseCaseImpl extends GetThemeUsecase {
  @override
  Future<bool?> getCurrentTheme() async {
    final box = await Hive.openBox<bool>(StringConstants.themesBoxKey);
    return box.get(StringConstants.themesKey);
  }

  @override
  Future<void> changeTheme(bool value) async {
    final box = await Hive.openBox<bool>(StringConstants.themesBoxKey);
    await box.put(StringConstants.themesKey, value);
  }
}
