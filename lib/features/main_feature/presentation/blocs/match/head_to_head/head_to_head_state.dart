import 'package:equatable/equatable.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/head_to_head.dart';

import '../../../../../../core/error/failures.dart';

class HeadToHeadState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HeadToHeadInitial extends HeadToHeadState {}

class HeadToHeadLoading extends HeadToHeadState {}

class HeadToHeadFetchSuccess extends HeadToHeadState {
  HeadToHead headToHead;
  HeadToHeadFetchSuccess({required this.headToHead});
  @override
  // TODO: implement props
  List<Object?> get props => [headToHead];
}

class HeadToHeadFetchFail extends HeadToHeadState {
  Failure? failure;
  HeadToHeadFetchFail({this.failure});
  @override
  // TODO: implement props
  List<Object?> get props => [failure];
}
