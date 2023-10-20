import 'package:ecommerce/ui/pages/main/main_navigator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit({required this.navigator}) : super(const MainState());
  final MainNavigator navigator;

  void switchTap(int index) {
    emit(
      state.copyWith(selectedIndex: index),
    );
    navigator.changePage(index);
  }
}
