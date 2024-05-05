import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/injection/injection_container.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/standing.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/table/table_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/table/table_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/table/table_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/team/team_main_view.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/table/group_table_view.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/table/table_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../core/constants/image_data.dart';
import '../../../../../core/helper/error_helper.dart';

class TableOfLeagueScreen extends StatelessWidget {
  TableOfLeagueScreen({super.key, required this.leagueId});
  int leagueId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            BlocProvider(
              create: (context) =>
                  sl.get<TableBloc>()..add(TableFetched(leagueId: leagueId)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: BlocBuilder<TableBloc, TableState>(
                  builder: (context, state) {
                    if (state is TableFetchSuccess) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: state.standingEntities.stage[0].hasGroups
                              ? GroupTableView(
                                  stage: state.standingEntities.stage[0])
                              :
                              //  TableWidget(
                              //     standings:
                              //         state.standingEntities.stage[0].standings)
                              DataTableWidget(
                                  standings: state
                                      .standingEntities.stage[0].standings
                                      .map((e) => e as Standing)
                                      .toList()),
                        ),
                      );
                    } else if (state is TableFetchFail) {
                      return ErrorHelper.basicErrorWidget();
                    } else {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: LoadingAnimationWidget.discreteCircle(
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DataTableWidget extends StatelessWidget {
  DataTableWidget({super.key, required this.standings});
  List<Standing> standings;
  List<Standing> list = [
    Standing(
        position: 1,
        teamId: 123,
        teamName: "ABC",
        positionAttribute: "positionAttribute",
        gamesPlayed: 12,
        points: 28,
        wins: 11,
        draws: 1,
        losses: 0,
        goalsFor: 28,
        goalsAgainst: 6),
    Standing(
        position: 1,
        teamId: 123,
        teamName: "ABC",
        positionAttribute: "positionAttribute",
        gamesPlayed: 12,
        points: 28,
        wins: 11,
        draws: 1,
        losses: 0,
        goalsFor: 28,
        goalsAgainst: 6),
    Standing(
        position: 1,
        teamId: 123,
        teamName: "ABC",
        positionAttribute: "positionAttribute",
        gamesPlayed: 12,
        points: 28,
        wins: 11,
        draws: 1,
        losses: 0,
        goalsFor: 28,
        goalsAgainst: 6),
    Standing(
        position: 1,
        teamId: 123,
        teamName: "ABC",
        positionAttribute: "positionAttribute",
        gamesPlayed: 12,
        points: 28,
        wins: 11,
        draws: 1,
        losses: 0,
        goalsFor: 28,
        goalsAgainst: 6),
    Standing(
        position: 1,
        teamId: 123,
        teamName: "ABC",
        positionAttribute: "positionAttribute",
        gamesPlayed: 12,
        points: 28,
        wins: 11,
        draws: 1,
        losses: 0,
        goalsFor: 28,
        goalsAgainst: 6)
  ];
  @override
  Widget build(BuildContext context) {
    final columns = [
      'Position',
      'Club ',
      'Games',
      "Wins",
      'Draws',
      "Losses",
      "GF",
      "GA",
      "GD",
      "Points"
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DataTable(
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.appBorder, width: 1)),
          // sortAscending: isAscending,
          // sortColumnIndex: sortColumnIndex,
          columns: getColumns(columns),
          rows: getRows(standings, context),
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton.icon(
          icon: Image.asset(
            ImageData.excelImage,
            height: 20,
            width: 20,
          ),
          onPressed: () {},
          label: const Text('Export to Excel'),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton.icon(
          icon: Image.asset(
            ImageData.pdfImage,
            height: 15,
            width: 15,
          ),
          onPressed: () async {
            //   exportDataGridToPdf();
          },
          label: const Text('Export to PDF'),
        )
      ],
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
            // onSort: onSort,
          ))
      .toList();
  List<DataRow> getRows(List<Standing> standings, BuildContext context) =>
      standings.map((Standing standing) {
        final cells = [
          standing.position,
          standing.teamName,
          standing.gamesPlayed,
          standing.wins,
          standing.draws,
          standing.losses,
          standing.goalsFor,
          standing.goalsAgainst,
          standing.goalsFor - standing.goalsAgainst,
          standing.points
        ];

        return DataRow(
          cells: getCells(cells),
          // onSelectChanged: (value) {
          //   Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) {
          //       return TeamMainView(teamID: standing.teamId);
          //     },
          //   ));
          // },
        );
      }).toList();
  List<DataCell> getCells(List<dynamic> cells) => cells
      .map((data) =>
          DataCell(GestureDetector(onTap: () {}, child: Text('$data'))))
      .toList();
}
