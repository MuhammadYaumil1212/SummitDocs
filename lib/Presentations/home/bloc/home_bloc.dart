import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../core/network/network_cubit.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final NetworkCubit internetCubit = NetworkCubit();

  HomeBloc() : super(HomeInitial()) {
    on<CheckNetwork>((event, emit) {
      internetCubit.stream.listen((status) {
        if (status == InternetConnectionStatus.connected) {
          add(NetworkStatusChanged(connected: true));
        } else {
          add(NetworkStatusChanged(connected: false));
        }
      });
    });

    on<NetworkStatusChanged>((event, emit) {
      if (event.connected) {
        emit(NetworkAvailable());
      } else {
        emit(NetworkUnavailable(message: 'Koneksi Terputus'));
      }
    });
  }

  @override
  Future<void> close() {
    internetCubit.close();
    return super.close();
  }
}
