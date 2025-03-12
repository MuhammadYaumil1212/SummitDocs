import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_admin_event.dart';
part 'dashboard_admin_state.dart';

class DashboardAdminBloc
    extends Bloc<DashboardAdminEvent, DashboardAdminState> {
  DashboardAdminBloc() : super(DashboardAdminInitial()) {
    on<DashboardAdminEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
