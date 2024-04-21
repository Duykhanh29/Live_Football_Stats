import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:live_football_stats/core/constants/app_routes_name.dart';
import 'package:live_football_stats/core/injection/injection_container.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: sl.get<FirebaseAuth>().authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user != null) {
            // Người dùng đã đăng nhập, chuyển hướng đến MainView
            print('Autho');
            WidgetsBinding.instance.addPostFrameCallback((_) {
              GoRouter.of(context).goNamed(AppRoutesName.mainView);
            });
          } else {
            // Người dùng chưa đăng nhập, chuyển hướng đến LoginPage
            print('Unauthor');
            WidgetsBinding.instance.addPostFrameCallback((_) {
              GoRouter.of(context).goNamed(AppRoutesName.loginPage);
            });
          }
        }
        return const SizedBox();
      },
    );
  }
}
