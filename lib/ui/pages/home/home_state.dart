part of 'home_cubit.dart';

class HomeState extends Equatable {
  final LoadStatus getCategoriesLoadStatus;
  final List<CategoryEntity>? categoriesList;

  const HomeState({
    this.getCategoriesLoadStatus = LoadStatus.initial,
    this.categoriesList = const [],
  });

  @override
  List<Object?> get props => [getCategoriesLoadStatus, categoriesList];

  HomeState copyWith({
    LoadStatus? getCategoriesLoadStatus,
    List<CategoryEntity>? categoriesList,
  }) {
    return HomeState(
        getCategoriesLoadStatus:
            getCategoriesLoadStatus ?? this.getCategoriesLoadStatus,
        categoriesList: categoriesList ?? this.categoriesList);
  }
}
