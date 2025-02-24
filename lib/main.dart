import 'package:berkas_conference/Presentations/splashscreen/bloc/splashscreen_cubit.dart';
import 'package:berkas_conference/Presentations/splashscreen/pages/splash_screen.dart';
import 'package:berkas_conference/core/network/network_cubit.dart';
import 'package:berkas_conference/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/theme/app_theme.dart';
import 'core/helper/storage/AppStorage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await AppStorage.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashscreenCubit>(
          create: (context) => SplashscreenCubit()..appStarted(),
        ),
        BlocProvider<NetworkCubit>(
          create: (context) => NetworkCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
