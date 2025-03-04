import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../commons/constants/string.dart';
import '../../../commons/widgets/app_text.dart';
import '../../../core/helper/navigation/app_navigation.dart';
import '../../home/pages/home_screen.dart';
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
                Center(
                  child: Image.asset(
                    AppString.logoApp,
                    width: 200,
                    height: 200,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: AppText(
                    text: AppString.ApplicationName,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.poppins(),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
