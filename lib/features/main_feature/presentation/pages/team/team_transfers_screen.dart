import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/team/transfers/transfers_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/team/transfers/transfers_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/team/transfers/transfers_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/teams/transfer_card.dart';

class TeamTransferScreen extends StatefulWidget {
  TeamTransferScreen({super.key, required this.teamID});
  int teamID;

  @override
  State<TeamTransferScreen> createState() => _TeamTransferScreenState();
}

class _TeamTransferScreenState extends State<TeamTransferScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<TransferBloc>()
        .add(TransferFetched(transferID: widget.teamID));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransferBloc, TransferState>(
      builder: (context, state) {
        if (state is TransferFetchSuccess) {
          return ListView.separated(
              itemBuilder: (context, index) {
                if (index < state.transfers.transfers.transfersIn.length) {
                  return TransferCard(
                    teamName: state.transfers.name,
                    typeOfTransfer: TypeOfTransfer.TransferIn,
                    transfersElement:
                        state.transfers.transfers.transfersIn[index],
                  );
                } else {
                  return TransferCard(
                    teamName: state.transfers.name,
                    typeOfTransfer: TypeOfTransfer.TransferOut,
                    transfersElement: state.transfers.transfers.transfersOut[
                        index - state.transfers.transfers.transfersIn.length],
                  );
                }
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
              itemCount: state.transfers.transfers.transfersIn.length +
                  state.transfers.transfers.transfersOut.length);
        } else if (state is TransferFetchFail) {
          return Center(
            child: Text(state.message ?? "Something went wrong"),
          );
        } else {
          return Container();
        }
      },
      listener: (context, state) {
        if (state is TransferInitial || state is TransferLoading) {
          EasyLoading.show();
        } else {
          EasyLoading.dismiss();
        }
      },
    );
  }
}
