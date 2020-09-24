import 'dart:convert';
import 'package:flutter_news/QuickNewsView.dart';
import 'package:flutter_news/rounded_container.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_news/Article.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ModHomePage extends StatefulWidget {
  @override
  _ModHomePageState createState() => _ModHomePageState();
}

class _ModHomePageState extends State<ModHomePage> {
  bool foundError = false;
  String msgText = "Unexpected Error...";

  bool isCatLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: !foundError
          ? FutureBuilder<List<Article>>(
              future: getData(),
              builder: (context, snapshot) {
                return snapshot.data != null
                    ? ListView(
                        children: <Widget>[
                          _buildFeaturedNews(snapshot.data),
                          const SizedBox(height: 10.0),
                          _buildHeading("Treanding posts", 0, snapshot.data),
                          _buildListItem(snapshot.data, 9),
                          _buildListItem(snapshot.data, 6),
                          _buildListItem(snapshot.data, 7),
                          _buildListItem(snapshot.data, 8),
                          _buildHeading("Browse by category", 1, snapshot.data),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      openCatagory("entertainment");
                                      Fluttertoast.showToast(
                                          msg:
                                              "Loading Articles! Please Wait...",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      child: Center(
                                          child: Text("Entertainment",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16))),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green.shade200,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Loading Articles! Please Wait...",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      openCatagory("sports");
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      child: Center(
                                          child: Text("Sports",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16))),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green.shade200,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      openCatagory('technology');
                                      Fluttertoast.showToast(
                                          msg:
                                              "Loading Articles! Please Wait...",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    },
                                    child: Container(
                                      height: 100,
                                      child: Center(
                                          child: Text("Technology",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16))),
                                      width: 100,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green.shade200,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      openCatagory('business');
                                      Fluttertoast.showToast(
                                          msg:
                                              "Loading Articles! Please Wait...",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    },
                                    child: Container(
                                      child: Center(
                                          child: Text("Business",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16))),
                                      height: 100,
                                      width: 100,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green.shade200,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      openCatagory('health');
                                      Fluttertoast.showToast(
                                          msg:
                                              "Loading Articles! Please Wait...",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    },
                                    child: Container(
                                      height: 100,
                                      child: Center(
                                          child: Text("Health",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16))),
                                      width: 100,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green.shade200,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Loading Articles! Please Wait...",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      openCatagory('science');
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      child: Center(
                                          child: Text("Science",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16))),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green.shade200,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Center(child: CircularProgressIndicator());
              })
          : Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  msgText,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: "Poppins",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: GestureDetector(
                    child: Chip(
                      elevation: 10.0,
                      backgroundColor: Colors.white,
                      label: Text(
                        "     Retry     ",
                        style: TextStyle(
                          color: Colors.greenAccent,
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        foundError = false;
                      });
                    },
                  ),
                )
              ],
            )),
    );
  }

  Widget _buildListItem(List<Article> article, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return new QuickNewsView(articles: article, indexNumber: index);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              margin: const EdgeInsets.only(right: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.shade200,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {
                    Fluttertoast.showToast(
                        msg: "Couldn't Load Some Images",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                  image: NetworkImage(
                    article[index].urlToImage != null
                        ? article[index].urlToImage
                        : "",
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    article[index].title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Text(article[index].description != null
                      ? article[index].description.length > 141
                          ? article[index].description.substring(0, 140) + "..."
                          : article[index].description
                      : ""),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  openCatagory(String topic) async {
    List<Article> list;
    String link =
        "https://newsapi.org/v2/top-headlines?country=in&category=$topic&apiKey=d858dc68a81247f5922c89d1f3f64c6b";
    var res = await http.get(Uri.encodeFull(link),
        headers: {"Accept": "application/json"}).catchError((e) {
      Fluttertoast.showToast(
          msg: "Couldn't Load Feeds",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      list = null;
    });
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["articles"] as List;
      list = rest.map<Article>((json) => Article.fromJson(json)).toList();
    }
    if (list != null && list.length != 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return new QuickNewsView(articles: list, indexNumber: -1);
      }));
    }
  }

  Padding _buildHeading(String title, int code, List<Article> articles) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
            ),
          ),
          code == 0
              ? MaterialButton(
                  elevation: 0,
                  textColor: Colors.white,
                  color: Colors.teal.shade300,
                  height: 0,
                  child: Icon(Icons.keyboard_arrow_right),
                  minWidth: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  padding: const EdgeInsets.all(2.0),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return new QuickNewsView(
                          articles: articles, indexNumber: -1);
                    }));
                  },
                )
              : Container(height: 1, width: 1),
        ],
      ),
    );
  }

  RoundedContainer _buildFeaturedNews(List<Article> articles) {
    return RoundedContainer(
      borderRadius: BorderRadius.circular(0),
      height: 270,
      color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Featured News",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 28.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Expanded(
            child: Swiper(
              pagination: SwiperPagination(margin: const EdgeInsets.only()),
              viewportFraction: 0.9,
              itemCount: 5,
              loop: true,
              autoplay: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      child: RoundedContainer(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Text(articles[index].title != null
                                  ? articles[index].title.toString()
                                  : "Couldn't Load Title!"),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              flex: 2,
                              child: Container(
                                color: Colors.red,
                                child: Image.network(
                                  articles[index].urlToImage != null
                                      ? articles[index].urlToImage.toString()
                                      : "",
                                  errorBuilder:
                                      (context, exception, stackTrace) {
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
                                  height: 210,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return new QuickNewsView(
                              articles: articles, indexNumber: index);
                        }));
                      }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Article>> getData() async {
    List<Article> list;
    String link =
        "https://newsapi.org/v2/top-headlines?country=in&language=en&pageSize=60&apiKey=d858dc68a81247f5922c89d1f3f64c6b";
    // String link = 'http://127.0.0.1:5000/api/v1/resources/news/all';
    var res = await http.get(Uri.encodeFull(link),
        headers: {"Accept": "application/json"}).catchError((e) {
      msgText = e.toString();
      foundError = true;
      setState(() {});
      _showDialog();
      return [{}];
    });
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["articles"] as List;
      list = rest.map<Article>((json) => Article.fromJson(json)).toList();
    }
    print("List Size: ${list.length}");
    return list;
  }

  _showDialog() async {
    showDialog(
        context: context,
        builder: (_) => NetworkGiffyDialog(
              image: Image.network(
                  "https://media.giphy.com/media/xTiN0L7EW5trfOvEk0/giphy.gif",
                  fit: BoxFit.cover),
              title: Text('No Internet Connection',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
              description: Text(
                'It Seem You Are Not Connected To Internet Connection',
                textAlign: TextAlign.center,
              ),
              onlyCancelButton: true,
              buttonCancelText: Text("Ok",
                  style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
            ));
  }
}
