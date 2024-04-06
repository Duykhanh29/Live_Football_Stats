import 'package:flutter/material.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';

import 'package:live_football_stats/features/main_feature/domain/entities/transfer.dart';

class TransferCard extends StatelessWidget {
  TransferCard(
      {super.key,
      required this.teamName,
      required this.transfersElement,
      required this.typeOfTransfer});
  String teamName;
  TransfersInElement transfersElement;
  TypeOfTransfer typeOfTransfer;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.appBorder),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: const Text(
                  "DONE DEAL",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  transfersElement.transferDate,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: typeOfTransfer == TypeOfTransfer.TransferIn
                      ? Text(
                          transfersElement.fromTeam!.name,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        )
                      : Text(
                          teamName,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Text(
                          transfersElement.playerName,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.green),
                            padding: const EdgeInsets.all(2),
                            child: transfersElement.transferType ==
                                    TransferType.TRANSFER_FEE
                                ? Text(
                                    "${transfersElement.transferAmount} ${transfersElement.transferCurrency}")
                                : Text(transfersElement.transferType.name)),
                      ),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: 20,
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: typeOfTransfer == TypeOfTransfer.TransferIn
                      ? Text(
                          teamName,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        )
                      : Text(
                          transfersElement.toTeam!.name,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
