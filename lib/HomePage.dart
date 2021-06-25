import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future getData() async {
    var url =
        "https://api.nasa.gov/planetary/apod?api_key=kgIWDVCTWya6rDxMEiY1dVGVBOcsyBvVrxhjJfV2";
    var response = await http.get(url);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text("Nasa Info"),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, i) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.grey[200],
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 35,
                                    color: Colors.teal,
                                  ),
                                  Text(snapshot.data[("copyright")]),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "      ${snapshot.data[("date")]}",
                                ),
                                Text(
                                  "Presont",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                            snapshot.data[("title")],
                          style: TextStyle(fontSize: 20,color: Colors.teal[900]),
                        ),
                      ),
                      Divider(
                        color: Colors.teal,
                        thickness: 2,
                        endIndent: 123,
                      ),
                      Container(margin: EdgeInsets.symmetric(vertical: 10),child: Text(snapshot.data[("explanation")],style: TextStyle(fontSize: 17,height: 1.5),)),
                      Image.network(
                        snapshot.data[("url")],
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
