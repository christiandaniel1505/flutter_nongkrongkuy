import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
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

class HomeMain extends StatefulWidget {
  HomeMain({Key? key}) : super(key: key);

  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  PageController pageController = new PageController();
  bool isTest = false;
  User user = new User();
  List cafes = [];
  List menus = [];
  String BASE_URL = "https://api-nongkrongkuy.herokuapp.com/";
  int indexCafe = 0;
  int _currentIndex = 0;
  PageController _pageController = new PageController();

  Future<void> getAllCafe() async {
    final String uri =
        "https://api-nongkrongkuy.herokuapp.com/api/v1/getAllCafe";
    String? token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    http.Response result = await http.get(Uri.parse(uri), headers: {
      'Authorization': 'Bearer $token',
    });
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      List cafeMap = jsonResponse['data'];
      List cafe = cafeMap.map((i) => Cafe.fromJson(i)).toList();
      setState(() {
        cafes = cafe;
      });
    }
  }

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
    pageController = PageController(viewportFraction: 6.0);
    getUser();
    getAllCafe();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void getUser() async {
    final String uri = "https://api-nongkrongkuy.herokuapp.com/api/v1/user";
    String? token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    http.Response result = await http.get(Uri.parse(uri), headers: {
      'Authorization': 'Bearer $token',
    });
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      var users = User.toString(jsonResponse);
      setState(() {
        user = users;
      });
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   return ;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            MaterialApp(
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
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 30),
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
                            items: cafes
                                .map((item) => Container(
                                      child: InkWell(
                                        child: Container(
                                          margin: EdgeInsets.all(5.0),
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
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
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Color.fromARGB(
                                                                200, 0, 0, 0),
                                                            Color.fromARGB(
                                                                0, 0, 0, 0)
                                                          ],
                                                          begin: Alignment
                                                              .bottomCenter,
                                                          end: Alignment
                                                              .topCenter,
                                                        ),
                                                      ),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10.0,
                                                              horizontal: 20.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            item.title,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 25.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .location_on_sharp,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            item.alamat,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        onTap: () {
                                          MaterialPageRoute route =
                                              MaterialPageRoute(
                                                  builder: (_) => MenuMain());
                                          Navigator.push(context, route);
                                        },
                                      ),
                                    ))
                                .toList(),
                          ),
                          cafes.length == 0
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Stack(children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 150,
                                                    top: 20,
                                                    bottom: 20),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Expanded(
                                                    child: Image.network(
                                                        "https://api-nongkrongkuy.herokuapp.com/" +
                                                            cafes[indexCafe]
                                                                .image,
                                                        fit: BoxFit.cover,
                                                        width: 200.0),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Image(
                                                  width: 100,
                                                  image: AssetImage(
                                                      'images/light-1.png'),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, top: 120),
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF282726),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: RichText(
                                                        text: TextSpan(
                                                            text: "Cek Lokasi",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Color(
                                                                    0xFFE4E4E4)),
                                                            recognizer:
                                                                TapGestureRecognizer()
                                                                  ..onTap =
                                                                      () async {
                                                                    var url =
                                                                        cafes[indexCafe]
                                                                            .link;
                                                                    if (await canLaunch(
                                                                        url)) {
                                                                      await launch(
                                                                          url);
                                                                    } else {
                                                                      throw 'Could not launch $url';
                                                                    }
                                                                  }),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, top: 160),
                                                child: InkWell(
                                                  onTap: () {
                                                    MaterialPageRoute route =
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                MenuMain());
                                                    Navigator.push(
                                                        context, route);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFC79C60),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text("Cek Menu",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color: Color(
                                                                  0xFFE4E4E4))),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8, left: 10),
                                            child: Container(
                                              child: Text(
                                                cafes[indexCafe].title,
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
                                                cafes[indexCafe].content,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5, top: 10),
                                            child: Image(
                                              image: AssetImage(
                                                  'images/table-set.png'),
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
            ),
            Container(
              color: Colors.red,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Color(0xFFE4E4E4),
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            title: Text('Beranda'),
            icon: Icon(Icons.home),
            inactiveColor: Color(0xFFC79C60),
            activeColor: Color(0xFF282726),
          ),
          BottomNavyBarItem(
            title: Text('Akun'),
            icon: Icon(Icons.account_circle),
            inactiveColor: Color(0xFFC79C60),
            activeColor: Color(0xFF282726),
          ),
        ],
      ),
    );
  }

  _launchURL() async {
    const url = 'https://google.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
