import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState());

  ///Switch tab
  void switchTap(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
