import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavbarCubit extends Cubit<int> {
  final PersistentTabController pageController = PersistentTabController();
  NavbarCubit() : super(0);
  void updateIndex(int index) {
    emit(index);
  }
}
