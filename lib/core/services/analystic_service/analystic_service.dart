import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:intl/intl.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';

class AnalysticService {
  final FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;
  FirebaseAnalyticsObserver getAnalysticObserver() =>
      FirebaseAnalyticsObserver(analytics: firebaseAnalytics);

  // Login event
  Future<void>? analyticsLogin(String uid) async =>
      await firebaseAnalytics.logEvent(
        name: 'LoginEvent',
        parameters: {"LoginEvent": "LoginEvent", "loginUser": uid},
      );
  // Signup event
  Future<void>? analyticsSignup({required AuthOption authOption}) async =>
      await firebaseAnalytics.logEvent(name: 'SignupEvent', parameters: {
        "SignupEvent": "SingupEvent",
        "authOption": AuthOptionValues.reverse[authOption]
      });
  Future<void> analysticLogout(String uid) async {
    await firebaseAnalytics.logEvent(
      name: 'LogoutEvent',
      parameters: {'logoutUser': uid},
    );
  }

  Future<void> setUserID(String uid) async {
    await firebaseAnalytics.setUserId(id: uid);
  }

  Future<void> addToWishList() async {
    await firebaseAnalytics.logAddToWishlist();
  }

  Future<void> logAppOpen(DateTime time) async {
    String formatted = DateFormat('HH:mm:ss dd/MM/yyyy').format(time);
    await firebaseAnalytics.logAppOpen(parameters: {'time': formatted});
  }

  Future<void> logLogin(
      {required AuthOption authOption, required String uid}) async {
    await firebaseAnalytics.logLogin(
      loginMethod: AuthOptionValues.reverse[authOption],
      parameters: {
        "LoginEvent": "LoginEvent",
        "loginUser": uid,
      },
    );
  }

  Future<void> logSignUp({required AuthOption authOption}) async {
    await firebaseAnalytics.logSignUp(
      signUpMethod: AuthOptionValues.reverse[authOption]!,
    );
  }

  Future<void> selectContent(
      {required LogContentType logContentType, required int id}) async {
    await firebaseAnalytics.logSelectContent(
        contentType: LogContentTypeValues.reverse[logContentType]!,
        itemId: id.toString());
  }
}
