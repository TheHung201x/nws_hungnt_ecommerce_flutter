part of 'home_cubit.dart';

class HomeState extends Equatable {
  final LoadStatus getCategoriesLoadStatus;
  final SearchStatus searchStatus;
  final List<CategoryEntity>? categoriesList;
  final List<CategoryEntity>? categoriesCopyList;

  const HomeState({
    this.getCategoriesLoadStatus = LoadStatus.initial,
    this.searchStatus = SearchStatus.initial,
    this.categoriesList = const [],
    this.categoriesCopyList = const [],
  });

  @override
  List<Object?> get props => [
        getCategoriesLoadStatus,
        searchStatus,
        categoriesList,
        categoriesCopyList
      ];

  HomeState copyWith({
    LoadStatus? getCategoriesLoadStatus,
    SearchStatus? searchStatus,
    List<CategoryEntity>? categoriesList,
    List<CategoryEntity>? categoriesCopyList,
  }) {
    return HomeState(
      getCategoriesLoadStatus:
          getCategoriesLoadStatus ?? this.getCategoriesLoadStatus,
      searchStatus: searchStatus ?? this.searchStatus,
      categoriesList: categoriesList ?? this.categoriesList,
      categoriesCopyList: categoriesCopyList ?? this.categoriesCopyList,
    );
  }
}
