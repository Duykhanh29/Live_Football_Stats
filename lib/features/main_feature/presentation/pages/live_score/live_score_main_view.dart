import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/constants/app_text_style.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/live_score.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/live_score/live_score_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/live_score/live_score_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/live_score/live_score_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/nav_bar/nav_bar_cubit.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/nav_bar/nav_live_score_cubit.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/live_score/upcoming_matches_page.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/live_score/live_score_card.dart';

import '../../widgets/live_score/live_score_widget.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class LiveScoreMainView extends StatefulWidget {
  LiveScoreMainView({super.key});

  @override
  State<LiveScoreMainView> createState() => _LiveScoreMainViewState();
}

class _LiveScoreMainViewState extends State<LiveScoreMainView> {
  BannerAd? bannerAd;

  bool _isBannerLoaded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialBanner();
  }

  _initialBanner() async {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: "ca-app-pub-3940256099942544/9214589741",
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              _isBannerLoaded = true;
              bannerAd = ad as BannerAd;
            });
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
            print(error);
          },
          onAdClosed: (ad) {
            setState(() {
              _isBannerLoaded = false;
            });
          },
        ),
        request: AdRequest());
    await bannerAd!.load();
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        // centerTitle: true,
        title: Text(
          "Livescore",
          style: AppTextStyles.appBarTexStyle(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              "Live",
              style: AppTextStyles.actionAppBarTextStyle(),
            ),
          ),
          BlocBuilder<NavLiveScoreCubit, bool>(builder: (context, state) {
            return
                //  Switch(
                //   value: state,
                //   onChanged: (value) {
                //     BlocProvider.of<NavLiveScoreCubit>(context).updateValue(value);
                //   },
                // );

                Padding(
              padding: const EdgeInsets.only(right: 15),
              child: FlutterSwitch(
                activeToggleColor: AppColors.liveColor,
                activeColor: AppColors.eventColor1,
                inactiveColor: AppColors.greyBorder,
                width: 65.0,
                height: 30.0,
                valueFontSize: 16.0,
                toggleSize: 30.0,
                value: state,
                borderRadius: 15.0,
                padding: 4.0,
                showOnOff: true,
                onToggle: (value) {
                  BlocProvider.of<NavLiveScoreCubit>(context)
                      .updateValue(value);
                  if (value) {
                    BlocProvider.of<LiveScoreBloc>(context)
                        .add(LiveScoreFetched());
                  } else {
                    // BlocProvider.of(context);
                  }
                },
              ),
            );
          })
        ],
      ),
      body: BlocConsumer<NavbarCubit, int>(
        builder: (context, state) {
          if (state == 1) {
            return BlocBuilder<NavLiveScoreCubit, bool>(
              builder: (context, state) {
                return RefreshIndicator(
                  child: state
                      ? const LiveScoreWidget()
                      : const UpcomingMatchesPage(),
                  onRefresh: () async {
                    if (state) {
                      BlocProvider.of<LiveScoreBloc>(context)
                          .add(LiveScoreFetched());
                    }
                  },
                );
                // if (state) {
                //    const LiveScoreWidget();
                // } else {
                //    const UpcomingMatchesPage();
                // }
              },
            );
          } else {
            return const SizedBox();
          }
        },
        listener: (context, state) {
          if (state != 1) {
            EasyLoading.dismiss();
          }
        },
      ),
      bottomNavigationBar: _isBannerLoaded && bannerAd != null
          ? SizedBox(
              height: bannerAd!.size.height.toDouble(),
              width: bannerAd!.size.width.toDouble(),
              child: AdWidget(ad: bannerAd!),
            )
          : const SizedBox(),
    );
  }
}
