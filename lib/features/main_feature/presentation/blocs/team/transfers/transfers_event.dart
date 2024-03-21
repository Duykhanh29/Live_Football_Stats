import 'package:equatable/equatable.dart';

class TransferEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TransferFetched extends TransferEvent {
  int transferID;
  TransferFetched({required this.transferID});
  @override
  // TODO: implement props
  List<Object?> get props => [transferID];
}
