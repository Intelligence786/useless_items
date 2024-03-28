import 'dart:convert';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:useless_items/data/models/item_model/item_model.dart';


class DataManager {
  static const _prefsKey = 'boatList';

  static List<ItemModel> itemModelsList = [];

  static Future<List<ItemModel>> loadItemList() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_prefsKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      itemModelsList =
          jsonList.map((item) => ItemModel.fromJson(item)).toList();
      return itemModelsList;
    }
    return [];
  }

  static Future<void> saveItemList(List<ItemModel> itemList) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonList =
    itemList.map((item) => item.toJson()).toList();
    prefs.setString(_prefsKey, json.encode(jsonList));
  }

  static Future<void> addItemToList(ItemModel item) async {
    final itemList = await loadItemList();
    itemList.add(item);
    await saveItemList(itemList);
  }

  static Future<void> removeItemFromList(ItemModel itemModel) async {
    final itemList = await loadItemList();

    itemList.removeWhere(
        (item) => item.uselessReason == itemModel.uselessReason && item.nameOfItem == itemModel.nameOfItem);
    itemModelsList.remove(itemModel);
    await saveItemList(itemList);
  }

  static Future<void> updateItemInList(ItemModel newItem, ItemModel oldItem) async {
    final itemList = await loadItemList();

    // Найдем индекс элемента, который мы хотим обновить
    final index = itemList.indexWhere(
            (item) => item.uselessReason == oldItem.uselessReason && item.nameOfItem == oldItem.nameOfItem);

    if (index != -1) {
      // Обновим элемент в списке
      itemList[index] = newItem;

      // Сохраним обновленный список
      await saveItemList(itemList);
    }
  }

}
