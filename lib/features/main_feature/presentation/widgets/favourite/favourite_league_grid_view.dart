import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/constants/app_routes_name.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/favourite/favourite_league_card.dart';

import '../../../../../core/constants/app_text_style.dart';
import '../../../../../core/constants/image_data.dart';
import '../../../domain/entities/favourite/favourite_league_entity.dart';
import '../../blocs/favourite/favourite_league/favourite_league_bloc.dart';
import '../../blocs/favourite/favourite_league/favourite_league_state.dart';

class FavouriteLeagueGridView extends StatefulWidget {
  const FavouriteLeagueGridView({super.key});

  @override
  State<FavouriteLeagueGridView> createState() =>
      _FavouriteLeagueGridViewState();
}

class _FavouriteLeagueGridViewState extends State<FavouriteLeagueGridView> {
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
    return BlocBuilder<FavouriteLeagueBloc, FavouriteLeagueState>(
      builder: (context, state) {
        if (state is FavouriteLeagueFetchedSucess) {
          final FavouriteLeagueEntity favouriteLeagueEntity =
              state.favouriteLeague;
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.38 - 10),
            decoration:
                BoxDecoration(border: Border.all(color: AppColors.thirdBorder)),
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
                      Text("Favourite Leagues",
                          style: AppTextStyles.headingTextStyle()),
                      TextButton(
                        onPressed: () {
                          _showRewardedInterstitialAd();
                          context
                              .pushNamed(AppRoutesName.listFavouriteLeaguePage);
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
                favouriteLeagueEntity.leagues != null &&
                        favouriteLeagueEntity.leagues!.isNotEmpty
                    ? Expanded(
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return AFavouriteLeagueCard(
                              league: favouriteLeagueEntity.leagues![index],
                            );
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: favouriteLeagueEntity.leagues!.length > 10
                              ? 10
                              : favouriteLeagueEntity.leagues!.length,
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
            ),
          );
        } else if (state is FavouriteLeagueFetchedFail) {
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
                Text("Favourite Leagues",
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
