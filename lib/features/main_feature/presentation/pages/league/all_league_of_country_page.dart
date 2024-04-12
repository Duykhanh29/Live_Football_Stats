import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/constants/app_text_style.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/core/helper/error_helper.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/leagues/leagues_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/leagues/leagues_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/leagues/leagues_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/leagues/a_league_card.dart';

class AllLeagueOfCountryPage extends StatefulWidget {
  AllLeagueOfCountryPage({super.key, required this.country});
  Country country;

  @override
  State<AllLeagueOfCountryPage> createState() => _AllLeagueOfCountryPageState();
}

class _AllLeagueOfCountryPageState extends State<AllLeagueOfCountryPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<LeaguesBloc>(context)
        .add(LeaguesOfACountryFetched(widget.country.id!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: Text(
          widget.country.name!,
          style: AppTextStyles.appBarTexStyle(),
        ),
        leading: SizedBox(
          // padding: const EdgeInsets.only(top: 15),
          width: 40,
          height: 40,

          child: InkWell(
            onTap: () {
              // Navigator.of(context).pop();
              GoRouter.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              // color: MyTheme.white,
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: BlocConsumer<LeaguesBloc, LeaguesState>(
          builder: (context, state) {
            if (state is LeaguesFetchSuccess) {
              return ListView.separated(
                  itemBuilder: (context, index) =>
                      LeagueCard(league: state.listLeague[index]),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 5,
                      ),
                  itemCount: state.listLeague.length);
            } else if (state is LeaguesFetchFail) {
              if (state.failure is TooManyRequestsFailure &&
                  state.failure!.message != null) {
                return ErrorHelper.errorWidgetWithMsg(state.failure!.message!);
              }

              return ErrorHelper.basicErrorWidget();
            } else {
              return const SizedBox();
            }
          },
          listener: (context, state) {
            if (state is LeaguesLoading || state is InitialLeagues) {
              EasyLoading.show();
            } else {
              EasyLoading.dismiss();
            }
          },
        ),
      ),
    );
  }
}
