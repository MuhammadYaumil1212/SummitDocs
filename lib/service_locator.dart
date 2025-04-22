import 'package:SummitDocs/Data/home/repositories/home_repository_impl.dart';
import 'package:SummitDocs/Data/home/sources/homes_services.dart';
import 'package:SummitDocs/Domain/home/repositories/home_repository.dart';
import 'package:SummitDocs/Domain/home/usecases/loa_usecase.dart';
import 'package:SummitDocs/Domain/signin/usecases/signin_usecase.dart';

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
  sl.registerSingleton<HomesServices>(HomeServicesImpl());
  //repositories
  sl.registerSingleton<SigninRepository>(SigninRepositoryImpl());
  sl.registerSingleton<HomeRepository>(HomeRepositoryImpl());
  //usecases
  sl.registerSingleton<SigninUsecase>(SigninUsecase());
  sl.registerSingleton<LOAUsecase>(LOAUsecase());
}
