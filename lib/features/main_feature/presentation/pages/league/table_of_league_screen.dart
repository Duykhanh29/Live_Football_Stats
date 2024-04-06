import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/standing.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/table/table_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/table/table_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/table/table_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/team/team_main_view.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TableOfLeagueScreen extends StatefulWidget {
  TableOfLeagueScreen({super.key, required this.leagueId});
  int leagueId;

  @override
  State<TableOfLeagueScreen> createState() => _TableOfLeagueScreenState();
}

class _TableOfLeagueScreenState extends State<TableOfLeagueScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TableBloc>().add(TableFetched(leagueId: widget.leagueId));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: BlocBuilder<TableBloc, TableState>(
              builder: (context, state) {
                if (state is TableFetchSuccess) {
                  return DataTableWidget(
                      standings: state.standingEntities.stage[0].standings);
                } else if (state is TableFetchFail) {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
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
            )),
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

    return DataTable(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.appBorder, width: 1)),
      // sortAscending: isAscending,
      // sortColumnIndex: sortColumnIndex,
      columns: getColumns(columns),
      rows: getRows(standings, context),
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
