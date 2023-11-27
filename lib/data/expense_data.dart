import 'dart:html';

import 'package:flutter_expense/datetime/datetime_helper.dart';

import '../models/expense_item.dart';

class ExpenseData {
  // list of all the expenses
  List<ExpenseItem> overallExpenseList = [];

  // get expense list
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  // add new expense
  void addNewExpense(ExpenseItem expenseItem) {
    overallExpenseList.add(expenseItem);
  }

  // delete expense
  void deleteExpense(ExpenseItem expenseItem) {
    overallExpenseList.remove(expenseItem);
  }

  // get week day (Monday, Tuesday, etc) from a DateTime object
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 7:
        return 'Sunday';
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
        default:
          return '';

    }
  }

  // get the date for the start of the week(Sunday)
DateTime? startOfWeekDate() {
    DateTime? startOfWeek;

    // get today's date
    DateTime today = DateTime.now();

    // go backwards from today to find nearest Sunday
    for(int i = 0; i < 7; i++ ) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sunday') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }

    return startOfWeek;
}

  /*
    convert overall list of expenses into a daily expense summary
   e.g
   overallExpenseList = [
    [food, 2023/10/23, 10],
    [hat, 2023/10/23, 15],
    [drinks, 2023/10/23, 1],
    [food, 2023/10/23, 10],
    [food, 2023/10/23, 10],
    [food, 2023/10/02, 10],
    [food, 2023/10/02, 10],
   ];

   ->
   DailyExpenseSummary = [
    [2023/10/02: $25],
    [2023/10/01: $1],
    [2023/09/30: $40],
    [2023/09/29: $7],
    [2023/09/28: $11],
   ]
   */

  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {
      // date (yyyymmdd) : amount TotalForDay

    };

    for ( var expense in overallExpenseList ) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if ( dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }

    return dailyExpenseSummary;
  }

}