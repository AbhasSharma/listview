import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

var users = []; //database

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    getusers();
    // TODO: implement initState
    super.initState();
  }

  getusers() async {
    var url = Uri.parse("https://api.github.com/users");
    var response = await http.get(url);
    print(response.body);
    print(response.body.runtimeType);
    var jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse.length);

    setState(() {
      users = jsonResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Instagram",
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        body:       
        users.length > 0
            ? ListView.builder(
               // padding: const EdgeInsets.all(5),
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Colors.black,
                      child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 30.0,
                          backgroundImage:
                              NetworkImage("${users[index]["avatar_url"]}"),
                          backgroundColor: Colors.transparent,
                        ),
                        title: Text(users[index]['login'],
                        style:TextStyle(color: Colors.white)),
                        trailing: Icon(Icons.settings,
                        color: Colors.white,),
                      ),
                      Container(
                      //  margin: const EdgeInsets.all(10.0),
                        //   width: 250,
                        child: Image.network(
                          "https://news.mit.edu/sites/default/files/styles/news_article__image_gallery/public/images/202012/MIT-Coding-Brain-01-press_0.jpg?itok=JKoUflf8",
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.thumb_up,color: Colors.white),
                                Icon(Icons.message,color: Colors.white),
                                Icon(Icons.share,color: Colors.white),
                                
                              ],
                            ),
                            Icon(Icons.bookmark,
                            color: Colors.white,),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 10.0,
                              backgroundImage:
                                  NetworkImage("${users[index]["avatar_url"]}"),
                              backgroundColor: Colors.transparent,
                            ),
                            Text("  Liked By developer abhas and 198 others",
                          style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        child: Text(users[index]['followers_url'],
                        style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  ));
                })
            : Center(child: Text("No data found")));
  }
}
