part of 'dashboard_icodsa_bloc.dart';

sealed class DashboardIcodsaEvent extends Equatable {
  const DashboardIcodsaEvent();
}

final class GetHistoryInvoiceIcodsa extends DashboardIcodsaEvent {
  @override
  List<Object?> get props => [];
}

final class GetHistoryLoAIcodsa extends DashboardIcodsaEvent {
  @override
  List<Object?> get props => [];
}
