import 'package:SummitDocs/Domain/manage_account/entity/user_entity.dart';
import 'package:SummitDocs/Domain/manage_account/usecase/create_account_usecase.dart';
import 'package:SummitDocs/Domain/manage_account/usecase/get_all_users_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../Data/manage_account/models/create_account_params.dart';
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

    on<CreateAccount>((event, emit) async {
      emit(LoadingSubmit(isLoading: true));

      final params = CreateAccountParams(
        name: event.name,
        username: event.username,
        email: event.email,
        password: event.password,
        role: event.role,
      );
      final submit = await sl<CreateAccountUsecase>().call(params: params);
      submit.fold((error) {
        final List<String> errorMessages = [];
        error.forEach((key, value) {
          for (var entry in error.entries) {
            final value = entry.value;
            if (value is List) {
              for (var msg in value) {
                if (msg is String) {
                  errorMessages.add(msg);
                }
              }
            }
          }
        });
        emit(FailedSubmit(errorMessage: errorMessages));
      }, (data) {
        emit(SuccessSubmit(successMessage: data));
      });
    });
  }
}
