import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/helper/divider_helper.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/favourite/league_widget.dart';
import '../../../../../core/constants/app_text_style.dart';
import '../../../../../core/helper/error_helper.dart';
import '../../../../auth/presentation/blocs/auth/auth_bloc.dart';
import '../../../../auth/presentation/blocs/auth/auth_state.dart';
import '../../blocs/favourite/favourite_league/favourite_league_bloc.dart';
import '../../blocs/favourite/favourite_league/favourite_league_state.dart';

class ListFavouriteLeaguePage extends StatelessWidget {
  const ListFavouriteLeaguePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        centerTitle: true,
        title: Text(
          "Favourite Teams",
          style: AppTextStyles.appBarTexStyle(),
        ),
        leading: Container(
          // padding: const EdgeInsets.only(top: 15),
          width: 40,
          height: 40,

          child: InkWell(
            onTap: () {
              //        Navigator.of(context).pop();
              context.pop();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            if (authState is AuthorizedState) {
              return BlocConsumer<FavouriteLeagueBloc, FavouriteLeagueState>(
                builder: (context, state) {
                  if (state is FavouriteLeagueFetchedSucess) {
                    final data = state.favouriteLeague;
                    return CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      slivers: [
                        SliverList.separated(
                          itemBuilder: (context, index) {
                            return LeagueWidget(
                                leagueDataEntity: data.leagues![index],
                                uid: authState.user!.userID!);
                          },
                          separatorBuilder: (context, index) =>
                              DividerHelper.sizedboxDivider(),
                          itemCount: data.leagues!.length,
                        )
                      ],
                    );
                  } else if (state is FavouriteLeagueFetchedFail) {
                    return Center(
                      child:
                          ErrorHelper.errorWidgetWithMsg(state.message ?? ""),
                    );
                  }
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  );
                },
                listener: (context, state) {
                  if (state is LoadingFavouriteLeague) {
                    EasyLoading.show();
                  } else {
                    EasyLoading.dismiss();
                  }
                },
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
