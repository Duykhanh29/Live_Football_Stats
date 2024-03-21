import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/team/get_transfer_uc.dart';

import 'package:live_football_stats/features/main_feature/presentation/blocs/team/transfers/transfers_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/team/transfers/transfers_state.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  GetTransferUseCase transferUseCase;
  TransferBloc({required this.transferUseCase}) : super(TransferInitial()) {
    on<TransferFetched>(onTransferFetchedEvent);
  }
  Future onTransferFetchedEvent(
      TransferFetched event, Emitter<TransferState> emit) async {
    try {
      emit(TransferLoading());
      final result = await transferUseCase.call(event.transferID);
      if (result != null) {
        result.fold((l) => emit(TransferFetchFail(message: l.message)),
            (r) => emit(TransferFetchSuccess(transfers: r)));
      } else {
        emit(TransferFetchFail());
      }
    } catch (e) {
      emit(TransferFetchFail());
    }
  }
}
