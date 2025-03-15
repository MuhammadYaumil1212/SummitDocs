import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_icodsa_event.dart';
part 'dashboard_icodsa_state.dart';

class DashboardIcodsaBloc
    extends Bloc<DashboardIcodsaEvent, DashboardIcodsaState> {
  DashboardIcodsaBloc() : super(DashboardIcodsaInitial()) {
    on<DashboardIcodsaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
