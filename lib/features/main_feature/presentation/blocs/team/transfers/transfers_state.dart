import 'package:equatable/equatable.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/transfer.dart';

import '../../../../../../core/error/failures.dart';

class TransferState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TransferInitial extends TransferState {}

class TransferLoading extends TransferState {}

class TransferFetchSuccess extends TransferState {
  Transfer transfers;
  TransferFetchSuccess({required this.transfers});
  @override
  // TODO: implement props
  List<Object?> get props => [transfers];
}

class TransferFetchFail extends TransferState {
  Failure? failure;
  TransferFetchFail({this.failure});
  @override
  // TODO: implement props
  List<Object?> get props => [failure];
}
