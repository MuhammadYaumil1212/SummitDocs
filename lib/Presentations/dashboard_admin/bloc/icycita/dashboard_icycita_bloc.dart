import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_icycita_event.dart';
part 'dashboard_icycita_state.dart';

class DashboardIcycitaBloc
    extends Bloc<DashboardIcycitaEvent, DashboardIcycitaState> {
  DashboardIcycitaBloc() : super(DashboardIcycitaInitial()) {
    on<DashboardIcycitaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
