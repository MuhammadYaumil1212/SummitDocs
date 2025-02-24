part of 'splashscreen_cubit.dart';

@immutable
sealed class SplashscreenState {}

final class SplashscreenInitial extends SplashscreenState {}

final class Authenticated extends SplashscreenState {}

final class UnAuthenticated extends SplashscreenState {}
