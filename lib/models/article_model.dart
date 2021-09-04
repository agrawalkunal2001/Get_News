class ArticleModel {
  String title;
  String author;
  String description;
  String urlToImage;
  String content;
  DateTime publishedAt;
  String articleUrl;

  ArticleModel(
      {required this.title,
      required this.author,
      required this.description,
      required this.urlToImage,
      required this.content,
      required this.publishedAt,
      required this.articleUrl});
}
