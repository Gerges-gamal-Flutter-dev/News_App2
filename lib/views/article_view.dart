import 'package:flutter/material.dart';
import 'package:flutter_news_app/models/article_model.dart';
import 'package:flutter_news_app/services/news_serivce.dart';
import 'package:flutter_news_app/widgets/article_card.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class ArticleView extends StatefulWidget {
  const ArticleView({super.key});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  int index = 1;
  List<ArticleModel> articles = [];

  List<String> categories = [
    "general",
    "business",
    "sports",
    "science",
    "health",
    "technology",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: const Color(0xFFe52e71),
        gradient: const LinearGradient(
          colors: [Color(0xFFff8a00), Color(0xFFe52e71)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        style: TabStyle.reactCircle,
        initialActiveIndex: index,
        onTap: (int i) {
          setState(() {
            index = i;
          });
        },
        items: const [
          TabItem(
              activeIcon: Icons.home_rounded,
              icon: Icons.home_outlined,
              title: 'General'),
          TabItem(
              activeIcon: Icons.business_rounded,
              icon: Icons.business_rounded,
              title: 'Business'),
          TabItem(
              activeIcon: Icons.sports_baseball,
              icon: Icons.sports_baseball_outlined,
              title: 'Sports'),
          TabItem(
              activeIcon: Icons.science_rounded,
              icon: Icons.science_outlined,
              title: 'Science'),
          TabItem(
              activeIcon: Icons.health_and_safety,
              icon: Icons.health_and_safety_outlined,
              title: 'Health'),
        ],
      ),
      appBar: AppBar(
        title: const Text(
          "News App",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
        centerTitle: true,
        elevation: 20,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFff8a00), Color(0xFFe52e71)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: NewsSerivce().getArticles(category: categories[index]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFff8a00), Color(0xFFe52e71)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ArticleCard(
                          article: snapshot.data![index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
