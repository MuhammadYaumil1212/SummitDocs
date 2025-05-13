part of 'dashboard_icycita_bloc.dart';

sealed class DashboardIcycitaState extends Equatable {
  const DashboardIcycitaState();
}

final class DashboardIcycitaInitial extends DashboardIcycitaState {
  @override
  List<Object> get props => [];
}

//invoice
final class LoadingTable extends DashboardIcycitaState {
  final isLoading;
  LoadingTable({this.isLoading = false});
  @override
  List<Object> get props => [isLoading];
}

final class SuccessTable extends DashboardIcycitaState {
  final List<InvoiceEntity> data;
  SuccessTable({required this.data});
  @override
  List<Object> get props => [data];
}

final class FailedTable extends DashboardIcycitaState {
  final String message;
  FailedTable({required this.message});
  @override
  List<Object> get props => [message];
}

//LOA
final class LoadingTableLoa extends DashboardIcycitaState {
  final isLoading;
  LoadingTableLoa({this.isLoading = false});
  @override
  List<Object> get props => [isLoading];
}

final class SuccessTableLoa extends DashboardIcycitaState {
  final List<LoaEntityHome> data;
  SuccessTableLoa({required this.data});
  @override
  List<Object> get props => [data];
}

final class FailedTableLoa extends DashboardIcycitaState {
  final String message;
  FailedTableLoa({required this.message});
  @override
  List<Object> get props => [message];
}

//receipt
final class LoadingTableReceipt extends DashboardIcycitaState {
  final isLoading;
  LoadingTableReceipt({this.isLoading = false});
  @override
  List<Object> get props => [isLoading];
}

final class SuccessTableReceipt extends DashboardIcycitaState {
  final List<ReceiptEntity> data;
  SuccessTableReceipt({required this.data});
  @override
  List<Object> get props => [data];
}

final class FailedTableReceipt extends DashboardIcycitaState {
  final String message;
  FailedTableReceipt({required this.message});
  @override
  List<Object> get props => [message];
}
