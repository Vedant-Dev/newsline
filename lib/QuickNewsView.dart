import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/Article.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:share/share.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import 'package:url_launcher/url_launcher.dart';

class QuickNewsView extends StatefulWidget {
  final List<Article> articles;
  final int indexNumber;
  const QuickNewsView(
      {Key key, @required this.articles, @required this.indexNumber})
      : super(key: key);

  @override
  _QuickNewsViewState createState() =>
      _QuickNewsViewState(articles, indexNumber);
}

class _QuickNewsViewState extends State<QuickNewsView> {
  final List<Article> articles;
  final int indexNumber;
  List<Article> finalArticleList;

  _QuickNewsViewState(this.articles, this.indexNumber);

  @override
  void initState() {
    if (articles != null && indexNumber == -1) {
      articles.shuffle();
      finalArticleList = articles;
    }
    if (articles != null && indexNumber > -1) {
      print("Index No. Rec. is $indexNumber");
      Article tempArticleFirst = articles[0];
      Article reqArticle = articles[indexNumber];
      finalArticleList = articles;
      finalArticleList[0] = reqArticle;
      finalArticleList[indexNumber] = tempArticleFirst;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Feeds",
          style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black54,
              fontStyle: FontStyle.normal),
        ),
        centerTitle: true,
      ),
      body: TikTokStyleFullPageScroller(
        contentSize: finalArticleList.length,
        swipeThreshold: 0.2,
        swipeVelocityThreshold: 2000,
        animationDuration: const Duration(milliseconds: 300),
        builder: (BuildContext context, int index) {
          return Container(
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  //link to gif - https://media.giphy.com/media/l0IxZfXLsfx6yf516/giphy.gif
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (_) => NetworkGiffyDialog(
                              image: Image.network(
                                  "https://media.giphy.com/media/l0IxZfXLsfx6yf516/giphy.gif",
                                  fit: BoxFit.cover),
                              title: Text('Sharing Is Caring',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w600)),
                              description: Text(
                                'Spread News To Spread Awareness',
                                textAlign: TextAlign.center,
                              ),
                              buttonOkText: Text("Share",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins')),
                              onOkButtonPressed: () {
                                _share(finalArticleList[index]);
                              },
                            ));
                  },
                  onTap: () {
                    _launchURL(finalArticleList[index].url, false);
                  },
                  child: Container(
                      height: 200,
                      width: double.infinity,
                      child: Image.network(
                        finalArticleList[index].urlToImage != null
                            ? finalArticleList[index].urlToImage
                            : "",
                        errorBuilder: (context, exception, stackTrace) {
                          return Center(
                              child: Text(
                            "Couldn't Load Image.",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontFamily: 'Poppins'),
                          ));
                        },
                        fit: BoxFit.cover,
                      )),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(16.0, 150.0, 16.0, 16.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0)),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AutoSizeText(
                        finalArticleList[index].title != null
                            ? finalArticleList[index].title
                            : "Couldn't Load Title!",
                        maxLines: 4,
                        maxFontSize: 24,
                        style: TextStyle(
                            fontFamily: "Poppins", fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0),
                      AutoSizeText(
                          "${finalArticleList[index].publishedAt != null ? finalArticleList[index].publishedAt.substring(0,10) : "Date Is Missing"} by ${finalArticleList[index].author != null ? finalArticleList[index].author : "Unknown"}",
                          maxLines: 2),
                      SizedBox(height: 10.0),
                      Divider(),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                          "Swipe Up For More. Click On image To Read Full Story. Long Press On Image To Share.",
                          style: TextStyle(color: Colors.blue[200])),
                      SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        flex: 1,
                        child: SingleChildScrollView(
                          child: Text(
                              // finalArticleList[index].content != null
                              //     ? finalArticleList[index].content.length > 15
                              //         ? finalArticleList[index]
                              //             .content
                              //             .trim()
                              //             .substring(
                              //                 0,
                              //                 finalArticleList[index]
                              //                         .content
                              //                         .length -
                              //                     13)
                              //         : finalArticleList[index].content
                              finalArticleList[index].description != null
                                  ? finalArticleList[index].description
                                  : "Sorry Our Server Did Not Respond To This Story.",
                              style: TextStyle(
                                  fontFamily: "Poppins", fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      //floatingActionButton: FloatingActionButton(onPressed: _launchURL(url)),
    );
  }

  // Future<void> openUrl(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(
  //       url,
  //       forceWebView: true,
  //       enableJavaScript: true,
  //     );
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  _launchURL(String url, bool openInBrowser) async {
    print("url start");
    if (await canLaunch(url)) {
      await launch(
        url,
        forceWebView: !openInBrowser,
        enableJavaScript: !openInBrowser,
      );
      print("url launch");
    } else {
      throw 'Could not launch $url';
    }
  }

  _share(Article article) {
    Share.share(
        "*${article.title.toString()}* \n\n  ${article.description} \n\n *Read full article on:* ${article.url} \n\n *Stay updated with NewsLine* \n\n Download now: https://play.google.com/store/apps/details?id=com.mlapps.newsline&hl=en_IN");
  }
}
