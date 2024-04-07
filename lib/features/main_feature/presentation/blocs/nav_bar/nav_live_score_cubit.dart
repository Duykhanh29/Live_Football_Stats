import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavLiveScoreCubit extends Cubit<bool> {
  bool isLiveMode = true;
  NavLiveScoreCubit() : super(true);
  void updateValue(bool value) {
    emit(value);
  }
}
