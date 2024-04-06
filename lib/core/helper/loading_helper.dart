import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingHelper {
  LoadingHelper._();
  static Widget basicLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  static Widget staggeredDotsWaveLoading() {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Colors.black,
        size: 30,
      ),
    );
  }
}
