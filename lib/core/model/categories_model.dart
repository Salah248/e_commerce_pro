class CategoriesModel {
  final String name;
  const CategoriesModel(this.name);

  factory CategoriesModel.fromJson(String json) => CategoriesModel(json);
}
