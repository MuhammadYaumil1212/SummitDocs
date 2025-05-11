import 'package:SummitDocs/Data/LoA/repositories/Loa_Repository_impl.dart';
import 'package:SummitDocs/Data/LoA/sources/Loa_services.dart';
import 'package:SummitDocs/Data/home/repositories/home_repository_impl.dart';
import 'package:SummitDocs/Data/home/sources/homes_services.dart';
import 'package:SummitDocs/Data/invoice/repository/Invoice_repository_impl.dart';
import 'package:SummitDocs/Data/invoice/sources/invoice_services.dart';
import 'package:SummitDocs/Data/manage_account/repositories/manage_repository_impl.dart';
import 'package:SummitDocs/Data/manage_account/sources/manage_account_services.dart';
import 'package:SummitDocs/Data/receipt/repository/receipt_repository.dart';
import 'package:SummitDocs/Data/receipt/sources/receipt_services.dart';
import 'package:SummitDocs/Data/settings/repositories/settings_repository.dart';
import 'package:SummitDocs/Data/settings/source/settings_services.dart';
import 'package:SummitDocs/Data/transfer_virtual/repositories/transfer_virtual_repository_impl.dart';
import 'package:SummitDocs/Data/transfer_virtual/sources/transfer_virtual_services.dart';
import 'package:SummitDocs/Domain/LoA/repositories/Loa_repository.dart';
import 'package:SummitDocs/Domain/LoA/usecase/create_loa_usecase.dart';
import 'package:SummitDocs/Domain/LoA/usecase/get_all_loa_usecase.dart';
import 'package:SummitDocs/Domain/home/repositories/home_repository.dart';
import 'package:SummitDocs/Domain/home/usecases/get_invoice_icicyta.dart';
import 'package:SummitDocs/Domain/home/usecases/get_invoice_icodsa_usecase.dart';
import 'package:SummitDocs/Domain/home/usecases/get_loa_icicyta_usecase.dart';
import 'package:SummitDocs/Domain/home/usecases/get_loa_icodsa_usecase.dart';
import 'package:SummitDocs/Domain/invoice/repository/invoice_repository.dart';
import 'package:SummitDocs/Domain/invoice/usecase/get_all_invoice_icicyta_usecase.dart';
import 'package:SummitDocs/Domain/invoice/usecase/update_invoice_icicyta_usecase.dart';
import 'package:SummitDocs/Domain/invoice/usecase/update_invoice_icodsa_usecase.dart';
import 'package:SummitDocs/Domain/manage_account/repositories/manage_account_repository.dart';
import 'package:SummitDocs/Domain/manage_account/usecase/create_account_usecase.dart';
import 'package:SummitDocs/Domain/manage_account/usecase/delete_account_usecase.dart';
import 'package:SummitDocs/Domain/manage_account/usecase/get_all_users_usecase.dart';
import 'package:SummitDocs/Domain/receipt/repositories/receipt_repository.dart';
import 'package:SummitDocs/Domain/receipt/usecase/get_all_receipt_icicyta_usecase.dart';
import 'package:SummitDocs/Domain/settings/repositories/settings_repository.dart';
import 'package:SummitDocs/Domain/settings/usecases/create_signature_usecase.dart';
import 'package:SummitDocs/Domain/settings/usecases/update_password_usecase.dart';
import 'package:SummitDocs/Domain/signin/usecases/signin_usecase.dart';
import 'package:SummitDocs/Domain/transfer_virtual/repositories/transfer_virtual_repository.dart';
import 'package:SummitDocs/Domain/transfer_virtual/usecase/delete_bank_transfer.dart';
import 'package:SummitDocs/Domain/transfer_virtual/usecase/delete_virtual_account_usecase.dart';
import 'package:SummitDocs/Domain/transfer_virtual/usecase/get_transfer_virtual_account_usecase.dart';
import 'package:SummitDocs/Domain/transfer_virtual/usecase/save_bank_transfer_usecase.dart';
import 'package:SummitDocs/Domain/transfer_virtual/usecase/save_virtual_account_usecase.dart';
import 'package:SummitDocs/Domain/transfer_virtual/usecase/transfer_virtual_usecase.dart';

import 'Data/signin/repositories/signin_repository.dart';
import 'Data/signin/sources/signin_service.dart';
import 'Domain/LoA/usecase/create_loa_icodsa_usecase.dart';
import 'Domain/LoA/usecase/get_all_loa_icodsa_usecase.dart';
import 'Domain/invoice/usecase/get_all_invoice_icodsa_usecase.dart';
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
  sl.registerSingleton<ManageAccountServices>(ManageAccountServicesImpl());
  sl.registerSingleton<SettingsServices>(SettingServicesImpl());
  sl.registerSingleton<LoaServices>(LoaServicesImpl());
  sl.registerSingleton<InvoiceServices>(InvoiceServicesImpl());
  sl.registerSingleton<ReceiptServices>(ReceiptServicesImpl());

  //repositories
  sl.registerSingleton<SigninRepository>(SigninRepositoryImpl());
  sl.registerSingleton<HomeRepository>(HomeRepositoryImpl());
  sl.registerSingleton<TransferVirtualRepository>(
    TransferVirtualRepositoryImpl(),
  );
  sl.registerSingleton<ManageAccountRepository>(ManageAccountRepositoryImpl());
  sl.registerSingleton<SettingsRepository>(SettingsRepositoryImpl());
  sl.registerSingleton<LoaRepository>(LoaRepositoryImpl());
  sl.registerSingleton<InvoiceRepository>(InvoiceRepositoryImpl());
  sl.registerSingleton<ReceiptRepository>(ReceiptRepositoryImpl());

  //usecases
  sl.registerSingleton<SigninUsecase>(SigninUsecase());
  sl.registerSingleton<GetLoaIcicytaUsecase>(GetLoaIcicytaUsecase());
  sl.registerSingleton<TransferVirtualUsecase>(TransferVirtualUsecase());
  sl.registerSingleton<SaveBankTransferUsecase>(SaveBankTransferUsecase());
  sl.registerSingleton<DeleteBankTransferUsecase>(DeleteBankTransferUsecase());
  sl.registerSingleton<DetailBankTransferUsecase>(DetailBankTransferUsecase());
  sl.registerSingleton<GetTransferVirtualAccountUsecase>(
    GetTransferVirtualAccountUsecase(),
  );
  sl.registerSingleton<SaveVirtualAccountUsecase>(SaveVirtualAccountUsecase());
  sl.registerSingleton<DeleteVirtualAccountUsecase>(
    DeleteVirtualAccountUsecase(),
  );
  sl.registerSingleton<GetAllUsersUsecase>(GetAllUsersUsecase());
  sl.registerSingleton<CreateAccountUsecase>(CreateAccountUsecase());
  sl.registerSingleton<DeleteAccountUsecase>(DeleteAccountUsecase());
  sl.registerSingleton<CreateSignatureUsecase>(CreateSignatureUsecase());
  sl.registerSingleton<UpdatePasswordUsecase>(UpdatePasswordUsecase());
  sl.registerSingleton<GetAllLoaUsecase>(GetAllLoaUsecase());
  sl.registerSingleton<CreateLoaUsecase>(CreateLoaUsecase());
  sl.registerSingleton<GetAllLoaIcodsaUsecase>(GetAllLoaIcodsaUsecase());
  sl.registerSingleton<GetAllInvoiceIcicytaUsecase>(
      GetAllInvoiceIcicytaUsecase());
  sl.registerSingleton<UpdateInvoiceIcicytaUsecase>(
      UpdateInvoiceIcicytaUsecase());
  sl.registerSingleton<GetAllReceiptIcicytaUsecase>(
      GetAllReceiptIcicytaUsecase());
  sl.registerSingleton<GetInvoiceIcodsaUsecase>(GetInvoiceIcodsaUsecase());
  sl.registerSingleton<GetInvoiceIcicytaUsecase>(GetInvoiceIcicytaUsecase());
  sl.registerSingleton<GetLoaIcodsaUsecase>(GetLoaIcodsaUsecase());
  sl.registerSingleton<CreateLoaIcodsaUsecase>(CreateLoaIcodsaUsecase());
  sl.registerSingleton<GetAllInvoiceIcodsaUsecase>(
      GetAllInvoiceIcodsaUsecase());
  sl.registerSingleton<UpdateInvoiceIcodsaUsecase>(
      UpdateInvoiceIcodsaUsecase());
}
