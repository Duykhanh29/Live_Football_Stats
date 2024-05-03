import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:live_football_stats/core/constants/image_data.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/favourite/favourite_team_card.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_routes_name.dart';
import '../../../../../core/constants/app_text_style.dart';
import '../../../domain/entities/favourite/favourite_team_entity.dart';
import '../../blocs/favourite/favourite_team/favourite_team_bloc.dart';
import '../../blocs/favourite/favourite_team/favourite_team_state.dart';

class FavouriteTeamGridView extends StatefulWidget {
  const FavouriteTeamGridView({super.key});

  @override
  State<FavouriteTeamGridView> createState() => _FavouriteTeamGridViewState();
}

class _FavouriteTeamGridViewState extends State<FavouriteTeamGridView> {
  RewardedInterstitialAd? _rewardedInterstitialAd;
  int _numRewardedInterstitialLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;
  void _createRewardedInterstitialAd() {
    RewardedInterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/5354046379'
            : 'ca-app-pub-3940256099942544/6978759866',
        request: AdRequest(),
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          onAdLoaded: (RewardedInterstitialAd ad) {
            setState(() {
              print('$ad loaded.');
              _rewardedInterstitialAd = ad;
              _numRewardedInterstitialLoadAttempts = 0;
            });
          },
          onAdFailedToLoad: (LoadAdError error) {
            setState(() {
              print('RewardedInterstitialAd failed to load: $error');
              _rewardedInterstitialAd = null;
              _numRewardedInterstitialLoadAttempts += 1;
              if (_numRewardedInterstitialLoadAttempts <
                  maxFailedLoadAttempts) {
                _createRewardedInterstitialAd();
              }
            });
          },
        ));
  }

  void _showRewardedInterstitialAd() {
    if (_rewardedInterstitialAd == null) {
      print('Warning: attempt to show rewarded interstitial before loaded.');
      return;
    }
    _rewardedInterstitialAd!.fullScreenContentCallback =
        FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedInterstitialAd ad) =>
          print('$ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedInterstitialAd();
      },
      onAdFailedToShowFullScreenContent:
          (RewardedInterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedInterstitialAd();
      },
    );

    _rewardedInterstitialAd!.setImmersiveMode(true);
    _rewardedInterstitialAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    _rewardedInterstitialAd = null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _createRewardedInterstitialAd();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _rewardedInterstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteTeamBloc, FavouriteTeamState>(
      builder: (context, state) {
        if (state is FavouriteTeamFetchedSucess) {
          final FavouriteTeamEntity teamEntity = state.favouriteTeam;
          return Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration:
                  BoxDecoration(border: Border.all(color: AppColors.appBorder)),
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.38 - 10),
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Favourite Teams",
                          style: AppTextStyles.headingTextStyle(),
                        ),
                        TextButton(
                          onPressed: () {
                            _showRewardedInterstitialAd();
                            context
                                .pushNamed(AppRoutesName.listFavouriteTeamPage);
                          },
                          child: const Text(
                            "See all",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  teamEntity.teams != null && teamEntity.teams!.isNotEmpty
                      ? Expanded(
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            itemBuilder: (context, index) {
                              return AFavouriteTeamCard(
                                team: teamEntity.teams![index],
                              );
                            },
                            scrollDirection: Axis.horizontal,
                            itemCount: teamEntity.teams!.length > 10
                                ? 10
                                : teamEntity.teams!.length,
                          ),
                        )
                      : Center(
                          child: Image.asset(
                            ImageData.emptyImage,
                            height: 100,
                            width: 100,
                          ),
                        ),
                ],
              ));
        } else if (state is FavouriteTeamFetchedFail) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: MediaQuery.of(context).size.height * 0.24,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration:
                BoxDecoration(border: Border.all(color: AppColors.greyBorder)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Favourite Teams",
                    style: AppTextStyles.headingTextStyle()),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    ImageData.emptyImage,
                    height: 100,
                    width: 100,
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          );
        }
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
        );
      },
    );
  }
}
