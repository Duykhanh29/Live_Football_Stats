import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../domain/entities/match.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match_preview.dart'
    as preview;

@immutable
class PreviewMatchState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialPreviewMatch extends PreviewMatchState {}

class MatchPreviewFetchSuccess extends PreviewMatchState {
  final preview.MatchPreview? match;
  MatchPreviewFetchSuccess(this.match);
  @override
  // TODO: implement props
  List<Object?> get props => [match];
}

class PreviewMatchLoading extends PreviewMatchState {}

class PreviewMatchFetchFail extends PreviewMatchState {}
