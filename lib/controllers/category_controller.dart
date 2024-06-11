import 'package:task_management_app/models/category_model.dart';
import 'package:task_management_app/services/database_service.dart';

class CategoryController {
  final DatabaseService _databaseService = DatabaseService();

  Future<void> addCategory(CategoryModel categoryModel) async {
    try {
      await _databaseService.insert('categories', categoryModel.toJson());
    } catch (e) {
      print("Error in add category: $e");
      throw Exception("Category insert error");
    }
  }

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final List<Map<String, dynamic>> categories =
          await _databaseService.queryAll('categories');
      return categories
          .map((category) => CategoryModel.fromJson(category))
          .toList();
    } catch (e) {
      print("Error getting all categories: $e");
      throw Exception("Category query error");
    }
  }

  Future<void> updateCategory(CategoryModel categoryModel) async {
    try {
      await _databaseService.update(
          'categories', categoryModel.categoryID!, categoryModel.toJson());
    } catch (e) {
      print("Error in update category: $e");
      throw Exception("Category update error");
    }
  }

  Future<void> deleteCategory(String categoryID) async {
    try {
      await _databaseService.delete('categories', categoryID);
    } catch (e) {
      print("Error in delete category: $e");
      throw Exception("Category delete error");
    }
  }
}
