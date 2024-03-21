import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavLeagueCubit extends Cubit<int> {
  NavLeagueCubit() : super(0);
  TabController? tabController;
  void updateIndex(int index) {
    emit(index);
  }
}
