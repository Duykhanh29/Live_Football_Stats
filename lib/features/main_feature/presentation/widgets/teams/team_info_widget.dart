import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team.dart';

import '../../../../../core/constants/app_colors.dart';

class TeamInfoWidget extends StatelessWidget {
  TeamInfoWidget({super.key, required this.team});
  Team team;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.thirdBorder),
          borderRadius: BorderRadius.circular(15)),
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 5, bottom: 5),
            child: Text(
              "Team information",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          const Divider(
            color: Colors.grey,
            height: 0.6,
          ),
          ListTile(
            onTap: () {
              // if (leagueResponse != null) {
              //   context.pushNamed(AppRoutesName.leaguePage,
              //       extra: leagueResponse!.id);
              // }
            },
            leading: const Icon(Ionicons.person_circle),
            title: const Text(
              "Name",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              team.name ?? "",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.public_rounded),
            title: const Text(
              "Country",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              team.country != null ? team.country?.name ?? "" : "",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.flag_circle_rounded),
            title: const Text(
              "Nation/Club",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              team.isNation ? "Nation" : "Club",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.place_rounded),
            title: const Text(
              "Stadium",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              "${team.stadium!.name} - ${team.stadium!.city}",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
