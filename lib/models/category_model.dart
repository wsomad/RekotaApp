// Represents a category or tag that can be associated with tasks. 
// This model would include properties such as category name, color, icon, etc.

class CategoryModel {
  String? categoryID;
  String? name;
  String? color;
  String? icon;

  CategoryModel({
    this.categoryID,
    this.name,
    this.color,
    this.icon,
  });

  Map<String, dynamic> toJson() {
    return {
      'categoryID': categoryID,
      'name': name,
      'color': color,
      'icon': icon,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> fromJson) {
    return CategoryModel(
      categoryID: fromJson['categoryID'],
      name: fromJson['name'],
      color: fromJson['color'],
      icon: fromJson['icon'],
    );
  }
}