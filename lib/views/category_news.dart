import 'package:flutter/material.dart';
import 'package:get_news/helper/news.dart';
import 'package:get_news/models/article_model.dart';

import 'article_view.dart';
import 'home.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({required this.category});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;

  @override
  void initState() {
    // Init state will be called when the screen opens
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  Future getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
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
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
            ),
          ),
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: articles.length,
                        itemBuilder: (BuildContext context, int index) {
                          return NewsTile(
                            urlToImage: articles[index].urlToImage ?? "",
                            title: articles[index].title ?? "",
                            description: articles[index].description ?? "",
                            postUrl: articles[index].articleUrl ?? "",
                            content: articles[index].content ?? "",
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

class NewsTile extends StatelessWidget {
  final String urlToImage, title, description, postUrl, content;

  NewsTile(
      {required this.urlToImage,
      required this.title,
      required this.description,
      required this.postUrl,
      required this.content});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleView(
              postUrl: 'postUrl',
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(urlToImage),
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
      ),
    );
  }
}
