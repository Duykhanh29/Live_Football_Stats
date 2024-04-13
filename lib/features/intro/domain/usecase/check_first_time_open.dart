import 'package:live_football_stats/core/constants/string_constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class CheckFirstTimeOpen {
  Future<bool?> checkIfUserLoggedIn();
}

class CheckFirstTimeOpenImpl extends CheckFirstTimeOpen {
  @override
  Future<bool?> checkIfUserLoggedIn() async {
    var box = await Hive.openBox<bool>(StringConstants.initAppBoxKey);
    bool? isFirstTime = box.get(StringConstants.initAppKey);
    return isFirstTime;
  }
}
