part of 'splashscreen_cubit.dart';

@immutable
sealed class SplashscreenState {}

final class SplashscreenInitial extends SplashscreenState {}

final class UnAuthenticated extends SplashscreenState {}

final class Icodsa extends SplashscreenState {}

final class Icicyta extends SplashscreenState {}

final class SuperAdmin extends SplashscreenState {}
