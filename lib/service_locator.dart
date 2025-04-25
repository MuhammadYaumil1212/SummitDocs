import 'package:SummitDocs/Data/home/repositories/home_repository_impl.dart';
import 'package:SummitDocs/Data/home/sources/homes_services.dart';
import 'package:SummitDocs/Data/transfer_virtual/models/detail_bank_transfer.dart';
import 'package:SummitDocs/Data/transfer_virtual/repositories/transfer_virtual_repository_impl.dart';
import 'package:SummitDocs/Data/transfer_virtual/sources/transfer_virtual_services.dart';
import 'package:SummitDocs/Domain/home/repositories/home_repository.dart';
import 'package:SummitDocs/Domain/home/usecases/loa_usecase.dart';
import 'package:SummitDocs/Domain/signin/usecases/signin_usecase.dart';
import 'package:SummitDocs/Domain/transfer_virtual/repositories/transfer_virtual_repository.dart';
import 'package:SummitDocs/Domain/transfer_virtual/usecase/delete_bank_transfer.dart';
import 'package:SummitDocs/Domain/transfer_virtual/usecase/save_bank_transfer_usecase.dart';
import 'package:SummitDocs/Domain/transfer_virtual/usecase/transfer_virtual_usecase.dart';

import 'Data/signin/repositories/signin_repository.dart';
import 'Data/signin/sources/signin_service.dart';
import 'Domain/signin/repositories/signin_repository.dart';
import 'Domain/transfer_virtual/usecase/detail_bank_transfer_usecase.dart';
import 'core/network/dio_client.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());
  //services
  sl.registerSingleton<SigninService>(SigninServiceImpl());
  sl.registerSingleton<HomesServices>(HomeServicesImpl());
  sl.registerSingleton<TransferVirtualServices>(TransferVirtualServicesImpl());
  //repositories
  sl.registerSingleton<SigninRepository>(SigninRepositoryImpl());
  sl.registerSingleton<HomeRepository>(HomeRepositoryImpl());
  sl.registerSingleton<TransferVirtualRepository>(
      TransferVirtualRepositoryImpl());
  //usecases
  sl.registerSingleton<SigninUsecase>(SigninUsecase());
  sl.registerSingleton<LOAUsecase>(LOAUsecase());
  sl.registerSingleton<TransferVirtualUsecase>(TransferVirtualUsecase());
  sl.registerSingleton<SaveBankTransferUsecase>(SaveBankTransferUsecase());
  sl.registerSingleton<DeleteBankTransferUsecase>(DeleteBankTransferUsecase());
  sl.registerSingleton<DetailBankTransferUsecase>(DetailBankTransferUsecase());
}
