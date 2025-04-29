import 'package:SummitDocs/Domain/manage_account/entity/user_entity.dart';
import 'package:SummitDocs/Domain/manage_account/usecase/get_all_users_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../service_locator.dart';

part 'manage_account_event.dart';
part 'manage_account_state.dart';

class ManageAccountBloc extends Bloc<ManageAccountEvent, ManageAccountState> {
  List<UserEntity> _allUsers = [];

  ManageAccountBloc() : super(ManageAccountInitial()) {
    // Event: Load semua akun
    on<LoadManageAccount>((event, emit) async {
      emit(LoadingTable(isLoading: true));
      final result = await sl<GetAllUsersUsecase>().call();

      result.fold(
        (error) {
          emit(LoadingTable(isLoading: false));
          emit(FailedTable(errorMessage: error));
        },
        (data) {
          _allUsers = data;
          emit(LoadingTable(isLoading: false));
          emit(TableLoaded(userList: data));
        },
      );
    });

    // Event: Filter berdasarkan roleId
    on<FilterAccountByRole>((event, emit) {
      final filtered = _allUsers
          .where((user) => event.roleIds.contains(user.roleId))
          .toList();
      emit(TableLoaded(userList: filtered));
    });
  }
}
