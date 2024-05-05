import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_football_stats/core/helper/divider_helper.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/standing.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/table/group_table_widget.dart';

class GroupTableView extends StatefulWidget {
  GroupTableView({super.key, required this.stage});
  Stage stage;
  @override
  State<GroupTableView> createState() => _GroupTableViewState();
}

class _GroupTableViewState extends State<GroupTableView> {
  PageController pageController = PageController();
  bool isLastPage = false;
  int page = 0;
  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //     color: Colors.grey,
      //     border: Border.all(color: Colors.pink),
      //     borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width,
      child:
          // Row(
          //   children: [
          // Container(
          //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
          //   width: MediaQuery.of(context).size.width * 0.08,
          //   child: InkWell(
          //     child: const Icon(Icons.arrow_back_ios_new_rounded),
          //     onTap: () {
          //       if (page > 0) {
          //         setState(() {
          //           page--;
          //         });
          //         pageController.jumpToPage(page);
          //       }
          //     },
          //   ),
          // ),
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                List<GroupStandingEntities> list = widget.stage.standings
                    .map((e) => e as GroupStandingEntities)
                    .toList();
                return GroupTableWidget(groupStandingEntities: list[index]);
              },
              separatorBuilder: (context, index) =>
                  DividerHelper.sizedboxDivider(),
              itemCount: widget.stage.standings.length),
      // Container(
      //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      //   width: MediaQuery.of(context).size.width * 0.08,
      //   child: InkWell(
      //     child: const Icon(Icons.arrow_forward_ios_rounded),
      //     onTap: () {
      //       if (page < widget.stage.standings.length) {
      //         setState(() {
      //           page++;
      //         });
      //         pageController.jumpToPage(page);
      //       }
      //     },
      //   ),
      // ),
      //   ],
      // ),
    );
  }
}
