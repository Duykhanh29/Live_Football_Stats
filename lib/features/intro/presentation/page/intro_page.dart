import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/constants/app_routes.dart';
import 'package:live_football_stats/core/constants/app_routes_name.dart';
import 'package:live_football_stats/core/constants/string_constants.dart';
import 'package:live_football_stats/features/intro/presentation/widgets/page_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage extends StatefulWidget {
  IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  PageController pageController = PageController();
  bool isLastPage = false;
  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(bottom: 70, left: 10, right: 10, top: 30),
        child: PageView(
          controller: pageController,
          onPageChanged: (value) {
            if (value == 2) {
              setState(() {
                isLastPage = true;
              });
            }
          },
          children: [
            PageItem(
                color: AppColors.backgroundColor,
                title: "Live fooball stats",
                subtitle:
                    "Real-Time Updates & Player Insights for Football Fanatics",
                image: ""),
            PageItem(
                color: AppColors.secondaryColor,
                title: "MatchWatch: Your Football Stat Hub",
                subtitle:
                    "Stay Ahead of the Game with Live Updates & In-Depth Analysis",
                image: ""),
            PageItem(
                color: AppColors.thirdColor,
                title: "GoalTrack: Your Live Football Companion",
                subtitle:
                    "Experience the Thrill of Every Moment with Real-Time Updates",
                image: ""),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? Container(
              height: 70,
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(
                      const Size.fromHeight(70),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.lighterCardColor)),
                onPressed: () async {
                  final box =
                      await Hive.openBox<bool>(StringConstants.initAppBoxKey);
                  await box.put(StringConstants.initAppKey, true);
                  goRouter.goNamed(AppRoutesName.loginPage);
                },
                child: const Center(child: Icon(CupertinoIcons.forward_fill)),
              ),
            )
          : Container(
              height: 70,
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      pageController.jumpToPage(2);
                    },
                    child: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: 3,
                      effect: WormEffect(
                          spacing: 15,
                          dotColor: AppColors.appBorder,
                          activeDotColor: AppColors.darkBackgroundColor),
                      onDotClicked: (index) => pageController.animateToPage(
                          index,
                          duration: const Duration(microseconds: 500),
                          curve: Curves.easeIn),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      pageController.nextPage(
                          duration: const Duration(microseconds: 500),
                          curve: Curves.bounceInOut);
                    },
                    child: const Icon(Icons.arrow_forward_ios_rounded),
                  )
                ],
              ),
            ),
    );
  }
}
