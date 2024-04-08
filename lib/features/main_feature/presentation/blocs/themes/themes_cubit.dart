import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemesCubit extends Cubit<bool> {
  ThemesCubit() : super(true);
  bool _isDark = false;
  bool get isDark => _isDark;
  void changeTheme(bool value) {
    _isDark = value;
    emit(value);
    // Emit will change the state of our theme (Must use)
  }
}
