import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_news/helper/data.dart';
import 'package:get_news/helper/news.dart';
import 'package:get_news/models/article_model.dart';
import 'package:get_news/models/category_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];

  bool _loading = true;

  @override
  void initState() {
    // Init state will be called when the screen opens
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getArticle();
  }

  Future getArticle() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Get",
              style: TextStyle(fontSize: 30.0),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontSize: 30.0),
            ),
          ],
        ),
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          // Categories
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      child: ListView.builder(
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return CategoryTile(
                            imageURL: categories[index].imageURL,
                            categoryName: categories[index].categoryName,
                          );
                        },
                      ),
                    ),
                    // News
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: articles.length,
                        itemBuilder: (BuildContext context, int index) {
                          return NewsTile(
                            imageURL: articles[index].urlToImage,
                            title: articles[index].title,
                            description: articles[index].description,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imageURL, categoryName;

  CategoryTile({required this.imageURL, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: imageURL,
                width: 150.0,
                height: 90.0,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 150.0,
              height: 90.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(
                categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsTile extends StatelessWidget {
  final String imageURL, title, description;

  NewsTile(
      {required this.imageURL, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(imageURL),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            description,
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
