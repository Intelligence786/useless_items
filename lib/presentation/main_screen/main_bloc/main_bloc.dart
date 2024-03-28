import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:useless_items/data/data_manager.dart';
import 'package:useless_items/data/models/item_model/item_model.dart';


part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitialState()) {
    on<MainGetEvent>(_onGetData);
  }

  _onGetData(MainGetEvent event, Emitter<MainState> emit) async {
    emit(MainLoadingState());

    List<ItemModel> itemModel =   await DataManager.loadItemList();

    if (itemModel.isEmpty) {
      emit(MainLoadedEmptyState());
    } else {
      emit(MainLoadedFullState(itemModelList: itemModel));
    }
  }
}
