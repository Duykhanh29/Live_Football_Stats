import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/constants/app_routes_name.dart';
import 'package:live_football_stats/core/constants/app_text_style.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/nav_bar/nav_bar_cubit.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/league/all_league_page.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/leagues/list_league_widget.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/leagues/top_leagues_widget.dart';

class LeagueMainView extends StatefulWidget {
  const LeagueMainView({super.key});

  @override
  State<LeagueMainView> createState() => _LeagueMainViewState();
}

class _LeagueMainViewState extends State<LeagueMainView> {
  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;
  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/5224354917'
            : 'ca-app-pub-3940256099942544/1712485313',
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            setState(() {
              print('$ad loaded.');
              _rewardedAd = ad;
              _numRewardedLoadAttempts = 0;
            });
          },
          onAdFailedToLoad: (LoadAdError error) {
            setState(() {
              print('RewardedAd failed to load: $error');
              _rewardedAd = null;
              _numRewardedLoadAttempts += 1;
              if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
                _createRewardedAd();
              }
            });
          },
        ));
  }

  void _showRewardedAd() {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    _rewardedAd = null;
  }

  @override
  void initState() {
    _createRewardedAd();
    super.initState();
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        centerTitle: true,
        title: Text(
          "Leagues",
          style: AppTextStyles.appBarTexStyle(),
        ),
      ),
      body: BlocConsumer<NavbarCubit, int>(
        builder: (context, state) {
          if (state == 2) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                        padding:
                            const EdgeInsets.only(top: 10, bottom: 5, left: 10),
                        child: Text(
                          "Top leagues",
                          style: AppTextStyles.headingTextStyle(),
                        )),
                  ),
                  TopLeaguesWidget(),
                  SliverToBoxAdapter(
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 5, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              _showRewardedAd();
                              GoRouter.of(context)
                                  .pushNamed(AppRoutesName.allLeaguePage);
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (context) {
                              //     return const AllLeaguePage();
                              //   },
                              // ));
                            },
                            child: const Text(
                              "See all league",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                        padding:
                            const EdgeInsets.only(top: 10, bottom: 5, left: 10),
                        child: Text(
                          "All country",
                          style: AppTextStyles.headingTextStyle(),
                        )),
                  ),
                  const ListLeagueWidget(),
                ],
              ),
              //  Column(
              //   children: [
              //     // Expanded(child: TopLeaguesWidget()),
              //     //
              //     const Expanded(child: ListLeagueWidget()),
              //   ],
              // ),
            );
          } else {
            return const SizedBox();
          }
        },
        listener: (context, state) {
          if (state != 2) {
            EasyLoading.dismiss();
          }
        },
      ),
    );
  }
}
