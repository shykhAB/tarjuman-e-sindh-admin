
class ItemModel {
  final String id;
  final String title;

  ItemModel(this.id, this.title);
 
  ItemModel.empty()
      : id = '',
        title = '';
  Map<String, String> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }

  ItemModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        title = json['title'] ?? '';

  ItemModel.getDistrictsFromJson(Map<String, dynamic> json)
      : id = json['_id'] ?? '',
        title = json['district_name'] ?? '';

  ItemModel.getManufacturersFromJson(Map<String, dynamic> json)
      : id = json['_id'] ?? '',
        title = json['manufacturer_name'] ?? '';

  ItemModel.getVehicleCategoriesFromJson(Map<String, dynamic> json)
      : id = json['_id'] ?? '',
        title = json['vehicle_category_name'] ?? '';

  ItemModel.getCentersFromJson(Map<String, dynamic> json)
      : id = json['_id'] ?? '',
        title = json['center_name'] ?? '';

  ItemModel.getSlotsFromJson(Map<String, dynamic> json)
      : id = json['_id'] ?? '',
        title = json['time'] ?? '';

  ItemModel.getProvincesFromJson(Map<String, dynamic> json)
      : id = json['_id'] ?? '',
        title = json['province_name'] ?? '';

  ItemModel.getDivisionsFromJson(Map<String, dynamic> json)
      : id = json['_id'] ?? '',
        title = json['division_name'] ?? '';

  ItemModel.getHighwaysFromJson(Map<String, dynamic> json)
      : id = json['_id'] ?? '',
        title = json['highway_name'] ?? '';

  ItemModel.getCategoriesFromJson(Map<String, dynamic> json)
      : id = json['_id'] ?? '',
        title = json['name'] ?? '';

  @override
  String toString() {
    return title;
  }
}