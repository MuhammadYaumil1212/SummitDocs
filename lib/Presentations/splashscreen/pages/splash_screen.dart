import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/helper/navigation/app_navigation.dart';
import '../../home/pages/home_screen.dart';
import '../bloc/splashscreen_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashscreenCubit, SplashscreenState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          AppNavigator.pushReplacement(
            context,
            transitionType: TransitionType.fade,
            HomeScreen(),
          );
        }
        if (state is Authenticated) {
          AppNavigator.pushReplacement(
            context,
            transitionType: TransitionType.fade,
            HomeScreen(),
          );
        }
      },
      child: Scaffold(
        body: BlocBuilder<SplashscreenCubit, SplashscreenState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: FlutterLogo(size: 100),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
