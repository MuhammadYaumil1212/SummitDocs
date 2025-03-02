import 'Data/signin/repositories/signin_repository.dart';
import 'Data/signin/sources/signin_service.dart';
import 'Domain/signin/repositories/signin_repository.dart';
import 'core/network/dio_client.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());
  //services
  sl.registerSingleton<SigninService>(SigninServiceImpl());
  //repositories
  sl.registerSingleton<SigninRepository>(SigninRepositoryImpl());
  //usecases
}
