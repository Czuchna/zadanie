import 'package:flutter_bloc/flutter_bloc.dart';

abstract class OutlierState {}

class InitialState extends OutlierState {}

class OutlierFound extends OutlierState {
  final int outlier;
  OutlierFound(this.outlier);
}

class OutlierError extends OutlierState {
  final String message;
  OutlierError(this.message);
}

class OutlierCubit extends Cubit<OutlierState> {
  OutlierCubit() : super(InitialState());

  void processInput(String input) {
    try {
      if (input.endsWith(',')) {
        input = input.substring(0, input.length - 1);
      }
      List<int> numbers = input.split(',').map((s) => int.parse(s)).toList();
      int outlierValue = findOutlierValue(numbers);
      emit(OutlierFound(outlierValue));
    } catch (e) {
      emit(OutlierError(e.toString()));
    }
  }

  int findOutlierValue(List<int> numbers) {
    if (numbers.length < 3) {
      throw Exception('Need at least 3 numbers to find an outlier');
    }
    try {
      final sample = [numbers[0], numbers[1], numbers[2]];
      final isEvenCount = sample.where((n) => n.isEven).length;

      if (isEvenCount >= 2) {
        return numbers.firstWhere(
            orElse: () => throw Exception('Niepoprawna tablica wejściowa'),
            (n) => n.isOdd);
      } else {
        return numbers.firstWhere(
            orElse: () => throw Exception('Niepoprawna tablica wejściowa'),
            (n) => n.isEven);
      }
    } on Exception {
      throw Exception('Niepoprawna tablica wejściowa');
    }
  }
}
