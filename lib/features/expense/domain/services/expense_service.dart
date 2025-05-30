import 'package:dukan_store_app/features/expense/domain/models/expense_model.dart';
import 'package:dukan_store_app/features/expense/domain/repositories/expense_repository_interface.dart';
import 'package:dukan_store_app/features/expense/domain/services/expense_service_interface.dart';

class ExpenseService implements ExpenseServiceInterface {
  final ExpenseRepositoryInterface expenseRepositoryInterface;
  ExpenseService({required this.expenseRepositoryInterface});

  @override
  Future<ExpenseBodyModel?> getExpenseList({required int offset, required int? restaurantId, required String? from, required String? to,  required String? searchText}) async {
    return await expenseRepositoryInterface.getExpenseList(offset: offset, restaurantId: restaurantId, from: from, to: to, searchText: searchText);
  }

}