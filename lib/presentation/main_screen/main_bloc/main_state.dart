part of 'main_bloc.dart';

@immutable
sealed class MainState {}

final class MainInitialState extends MainState {}

final class MainLoadingState extends MainState{}

final class MainLoadedFullState extends MainState{
  final List<ItemModel> itemModelList;

  MainLoadedFullState({required this.itemModelList});
}

final class MainLoadedEmptyState extends MainState{

}