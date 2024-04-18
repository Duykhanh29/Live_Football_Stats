import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/themes/get_themes_usecase.dart';

class ThemesCubit extends Cubit<bool> {
  GetThemeUsecase
      getThemeUseCase; // Thay GetThemeUseCaseImpl bằng tên lớp hoặc phương thức của bạn

  ThemesCubit({required this.getThemeUseCase}) : super(true) {
    _init();
  }
  Future<void> _init() async {
    final bool? currentTheme = await getThemeUseCase.getCurrentTheme();
    if (currentTheme != null) {
      emit(currentTheme);
    } else {
      emit(true);
    }
  }

  bool _isDark = false;
  bool get isDark => _isDark;
  Future<void> changeTheme(bool value) async {
    // _isDark = value;
    await getThemeUseCase.changeTheme(value);
    emit(value);
    // Emit will change the state of our theme (Must use)
  }
}
