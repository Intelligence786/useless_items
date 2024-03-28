

class TypesMapper {
  static ItemState boatStateParse(String title) {
    switch (title.toLowerCase()) {
      case 'Good':
        return ItemState.Good;
      case 'Not bad':
        return ItemState.NotBad;
      case 'Not good':
        return ItemState.NotGood;
      case 'Bad':
        return ItemState.Bad;
      default:
        throw ArgumentError('Invalid payment type: $title');
    }
  }
}

enum ItemState { Good, NotBad, NotGood, Bad }

class ItemModel {
  final String nameOfItem;
  final String itemCategory;
  final String uselessReason;
  final ItemState itemState;
  final double broughtPrice;
  final double sellPrice;

  ItemModel({
    required this.nameOfItem,
    required this.itemCategory,
    required this.uselessReason,
    required this.itemState,
    required this.broughtPrice,
    required this.sellPrice,
  });

// Метод для преобразования объекта ItemModel в JSON
  Map<String, dynamic> toJson() {
    return {
      'nameOfItem': nameOfItem,
      'itemCategory': itemCategory,
      'uselessReason': uselessReason,
      'itemState': itemState.index, // Преобразуем enum в строку
      'broughtPrice': broughtPrice,
      'sellPrice': sellPrice,
    };
  }

  // Статический метод для создания объекта ItemModel из JSON
  static ItemModel fromJson(Map<String, dynamic> json) {
    return ItemModel(
      nameOfItem: json['nameOfItem'],
      itemCategory: json['itemCategory'],
      uselessReason: json['uselessReason'],
      itemState: ItemState.values[json['itemState']],
      broughtPrice: json['broughtPrice'],
      sellPrice: json['sellPrice'],
    );
  }
}
