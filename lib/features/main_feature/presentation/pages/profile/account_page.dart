import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/constants/app_text_style.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/themes/themes_cubit.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        centerTitle: true,
        title: Text(
          "Account",
          style: AppTextStyles.appBarTexStyle(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BlocBuilder<ThemesCubit, bool>(
              builder: (context, state) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SwitchListTile(
                  dense: true,
                  value: state,
                  onChanged: (value) async {
                    await context.read<ThemesCubit>().changeTheme(value);
                  },
                  activeColor: AppColors.cardColor,
                  title: Text(state ? "ON" : "OFF"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
