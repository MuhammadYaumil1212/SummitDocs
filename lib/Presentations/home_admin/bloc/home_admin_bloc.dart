import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../core/network/network_cubit.dart';

part 'home_admin_event.dart';
part 'home_admin_state.dart';

class HomeAdminBloc extends Bloc<HomeAdminEvent, HomeAdminState> {
  HomeAdminBloc() : super(HomeAdminInitial()) {
    final NetworkCubit internetCubit = NetworkCubit();
    on<HomeAdminEvent>((event, emit) {
      // TODO: implement event handler
    });
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
}
