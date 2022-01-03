import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nongkrongkuy/models/cafe.dart';
import 'package:flutter_nongkrongkuy/models/menu.dart';
import 'package:flutter_nongkrongkuy/models/user.dart';
import 'package:flutter_nongkrongkuy/pages/menu/menu.dart';
import 'package:flutter_nongkrongkuy/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class MenuMain extends StatefulWidget {
  MenuMain({Key? key, required this.cafe_id}) : super(key: key);
  int cafe_id;
  @override
  _MenuMainState createState() => _MenuMainState();
}

class _MenuMainState extends State<MenuMain> {
  User user = new User();
  String BASE_URL = "https://api-nongkrongkuy.herokuapp.com/";
  int indexCafe = 0;
  List menus = [];

  bool loading = false;
  String userToken = "";

  Future<void> getMenuCafe(int id) async {
    final String uri =
        "https://api-nongkrongkuy.herokuapp.com/api/v1/getMenuCafe/" +
            id.toString();
    String? token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    http.Response result = await http.get(Uri.parse(uri), headers: {
      'Authorization': 'Bearer $token',
    });
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      List menuMap = jsonResponse['data'];
      List menu = menuMap.map((i) => Menu.fromJson(i)).toList();
      setState(() {
        menus = menu;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getMenuCafe(widget.cafe_id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF282726),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 50,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 12),
                    child: Image(
                      width: 200,
                      image: AssetImage('images/nongkrong.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            "Halo Selamat Datang",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xFFE4E4E4),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 30),
                          child: Text(
                            user.name,
                            style: TextStyle(
                              color: Color(0xFFE4E4E4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200.0,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          indexCafe = index;
                        });
                      },
                    ),
                    items: menus
                        .map((item) => Container(
                              child: Container(
                                margin: EdgeInsets.all(5.0),
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    child: Stack(
                                      children: <Widget>[
                                        Image.network(
                                            "https://api-nongkrongkuy.herokuapp.com/" +
                                                item.image,
                                            fit: BoxFit.cover,
                                            width: 1000.0),
                                        Positioned(
                                          bottom: 0.0,
                                          left: 0.0,
                                          right: 0.0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color.fromARGB(200, 0, 0, 0),
                                                  Color.fromARGB(0, 0, 0, 0)
                                                ],
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                              ),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 20.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.title,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.location_on_sharp,
                                                      color: Colors.amber,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ))
                        .toList(),
                  ),
                  menus.length == 0
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 55),
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Color(0xFF1C1313),
                          )),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFE4E4E4),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Stack(children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 150, top: 20, bottom: 20),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Expanded(
                                            child: Image.network(
                                                "https://api-nongkrongkuy.herokuapp.com/" +
                                                    menus[indexCafe].image,
                                                fit: BoxFit.cover,
                                                width: 200.0),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Image(
                                          width: 100,
                                          image:
                                              AssetImage('images/light-1.png'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 160),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFFC79C60),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                "Harga Rp. " +
                                                    menus[indexCafe].harga,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Color(0xFFE4E4E4))),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 8, left: 10),
                                    child: Container(
                                      child: Text(
                                        menus[indexCafe].title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, left: 10, bottom: 10),
                                    child: Container(
                                      child: Text(
                                        menus[indexCafe].content,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 5, top: 10),
                                    child: Image(
                                      image: AssetImage('images/table-set.png'),
                                      width: 350,
                                    ),
                                  ),
                                ]),
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
