import 'package:equatable/equatable.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/head_to_head.dart';

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
  String? message;
  HeadToHeadFetchFail({this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
