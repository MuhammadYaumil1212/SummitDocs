part of 'dashboard_icodsa_bloc.dart';

sealed class DashboardIcodsaState extends Equatable {
  const DashboardIcodsaState();
}

final class DashboardIcodsaInitial extends DashboardIcodsaState {
  @override
  List<Object> get props => [];
}

final class LoadingTableLoa extends DashboardIcodsaState {
  final isLoading;
  LoadingTableLoa({this.isLoading = false});
  @override
  List<Object> get props => [isLoading];
}

final class SuccessTableLoa extends DashboardIcodsaState {
  final List<LoaEntityHome> data;
  SuccessTableLoa({required this.data});
  @override
  List<Object> get props => [data];
}

final class FailedTableLoa extends DashboardIcodsaState {
  final String message;
  FailedTableLoa({required this.message});
  @override
  List<Object> get props => [message];
}

final class LoadingTableInvoice extends DashboardIcodsaState {
  final isLoading;
  LoadingTableInvoice({this.isLoading = false});
  @override
  List<Object> get props => [isLoading];
}

final class SuccessTableInvoice extends DashboardIcodsaState {
  final List<InvoiceEntity> data;
  SuccessTableInvoice({required this.data});
  @override
  List<Object> get props => [data];
}

final class FailedTableInvoice extends DashboardIcodsaState {
  final String message;
  FailedTableInvoice({required this.message});
  @override
  List<Object> get props => [message];
}
