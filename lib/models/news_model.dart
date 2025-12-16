class NewsModel{
  String id = '';
  String heading = '';
  String detail = '';
  String image = '';
  String category = '';
  String createdAt = '';
  String createdBy = '';

  NewsModel({
    required this.id,
    required this.heading,
    required this.detail,
    required this.image,
    required this.category,
    required this.createdAt,
    required this.createdBy
  });

  NewsModel.empty();

  @override
  String toString() {
    return 'NewsModel{id: $id, heading: $heading, detail: $detail, image: $image, category: $category, createdAt: $createdAt, createdBy: $createdBy}';
  }


}