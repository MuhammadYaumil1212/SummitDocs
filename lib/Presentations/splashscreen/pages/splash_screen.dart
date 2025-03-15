import 'package:SummitDocs/Presentations/home_admin/pages/icicyta/home_icycita_screen.dart';
import 'package:SummitDocs/Presentations/home_admin/pages/icodsa/home_icodsa_screen.dart';
import 'package:SummitDocs/Presentations/home_super_admin/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../commons/constants/string.dart';
import '../../../core/helper/navigation/app_navigation.dart';
import '../../signin/pages/signin_screen.dart';
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
            SigninScreen(),
          );
        }
        if (state is Icodsa) {
          AppNavigator.pushReplacement(
            context,
            transitionType: TransitionType.fade,
            HomeIcodsaScreen(),
          );
        }
        if (state is Icicyta) {
          AppNavigator.pushReplacement(
            context,
            transitionType: TransitionType.fade,
            HomeIcycitaScreen(),
          );
        }
        if (state is SuperAdmin) {
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
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppString.logoApp,
                        width: 45,
                        height: 45,
                      ),
                      const SizedBox(width: 10),
                      SvgPicture.asset(
                        AppString.logoTextApp,
                        width: 35,
                        height: 35,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
