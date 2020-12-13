import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Models/cart.dart';
import 'package:himaka/Screens/cart_screen.dart';
import 'package:himaka/Screens/first_home_screen.dart';
import 'package:himaka/Screens/product_categories_screen.dart';
import 'package:himaka/Screens/search_screen.dart';
import 'package:himaka/Screens/service_categories_screen.dart';
import 'package:himaka/Screens/settings_screen.dart';
import 'package:himaka/Screens/wallets_screen.dart';
import 'package:himaka/Screens/wish_list_screen.dart';
import 'package:himaka/utils/app_localizations.dart';
import 'package:himaka/utils/globals.dart';
import 'package:himaka/Screens/Chat/utils.dart';

import 'Chat/firebaseController.dart';
import 'Chat/notificationController.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _storage = FlutterSecureStorage();
  String key = 'cart';

  int _selectedTab = 0;
  TextEditingController searchKeyController = new TextEditingController();
  int _counter = 0;
  callback(int length) {
    setState(() {
      _counter = length;
    });
  }

  var appBarHeight = AppBar().preferredSize.height;

  @override
  Widget build(BuildContext context) {
    final _pageOptions = [
      FirstHomeScreen(callback), //0
      ServiceCategoriesScreen(callback), //1 service
      ProductCategoriesScreen(callback), //2 products
      WalletsScreen(),
      SettingsScreen(callback),
    ];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFf5f5f5),
          elevation: 0.0,
          title:
//          InkWell(
//            onTap: () {
//              showSearchDialog(
//                  context,
//                  _selectedTab == 2
//                      ? 1
//                      : _selectedTab == 1
//                          ? 2
//                          : 3,
//                  searchKeyController: searchKeyController);

//              },
//            child:

              Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.all(Radius.circular(25)),
            ),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Container(
                      height: appBarHeight - 30,
                      child: TextField(
                        controller: searchKeyController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelStyle: TextStyle(color: Colors.black38),
                          hintStyle: TextStyle(color: Colors.black38),
//                        labelText: AppLocalizations.of(context)
//                            .translate('search_hint'),

                          hintText: AppLocalizations.of(context)
                              .translate('search_hint'),
//                              border: OutlineInputBorder(
//                                gapPadding: 0.0,
//                                borderRadius: BorderRadius.circular(1.5),
//                              ),
                        ),
                        style: TextStyle(color: Colors.black38, fontSize: 13),
                      ),
                    )),
                    InkWell(
                      onTap: () {
                        if (searchKeyController.text.isNotEmpty) {
//                          var result = await
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new SearchScreen(
                                      callback,
                                      searchKeyController.text,
                                      _selectedTab == 2
                                          ? 1
                                          : _selectedTab == 1
                                              ? 2
                                              : 3)));
//                          if (result == null) Navigator.pop(context);
                        }
//                        else
//                          Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.search,
                        color: Colors.black38,
                      ),
                    )
                  ],
                )),
          ),
//          ),
          leading: InkWell(
            onTap: () {
              setState(() {
                _counter++;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('images/logo.png'),
            ),
          ),
          actions: [
            IconButton(
              icon: SvgPicture.asset(
                'images/icon_fav_appbar.svg',
                height: 20.0,
                width: 20.0,
                allowDrawingOutsideViewBox: true,
              ),

//              Icon(
//                Icons.favorite,
//                color: Colors.black,
//              ),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new WishListScreen()));
              },
            ),
            _shoppingCartBadge(),
          ],
        ),
        body: _pageOptions[_selectedTab],
        bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: Color(0xff45afe2),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedTab,
            onTap: (int index) {
              setState(() {
                _selectedTab = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'images/icon_home.svg',
                  height: 20.0,
                  width: 20.0,
                  allowDrawingOutsideViewBox: true,
                ),
                title: Text(
                  "",
                ),
                activeIcon: SvgPicture.asset(
                  'images/icon_home.svg',
                  height: 20.0,
                  width: 20.0,
                  color: Colors.blue[900],
                  allowDrawingOutsideViewBox: true,
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'images/icon_idea.svg',
                  height: 20.0,
                  width: 20.0,
                  allowDrawingOutsideViewBox: true,
                ),
                title: Text(
                  "",
                ),
                activeIcon: SvgPicture.asset(
                  'images/icon_idea.svg',
                  height: 20.0,
                  width: 20.0,
                  color: Colors.blue[900],
                  allowDrawingOutsideViewBox: true,
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'images/icon_list.svg',
                  height: 20.0,
                  width: 20.0,
                  allowDrawingOutsideViewBox: true,
                ),
                title: Text(
                  "",
                ),
                activeIcon: SvgPicture.asset(
                  'images/icon_list.svg',
                  height: 20.0,
                  width: 20.0,
                  color: Colors.blue[900],
                  allowDrawingOutsideViewBox: true,
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'images/icon_wallet.svg',
                  height: 20.0,
                  width: 20.0,
                  allowDrawingOutsideViewBox: true,
                ),
                title: Text(
                  "",
                ),
                activeIcon: SvgPicture.asset(
                  'images/icon_wallet.svg',
                  height: 20.0,
                  width: 20.0,
                  color: Colors.blue[900],
                  allowDrawingOutsideViewBox: true,
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'images/icon_settings.svg',
                  height: 20.0,
                  width: 20.0,
                  allowDrawingOutsideViewBox: true,
                ),
                title: Text(
                  "",
                ),
                activeIcon: SvgPicture.asset(
                  'images/icon_settings.svg',
                  height: 20.0,
                  width: 20.0,
                  color: Colors.blue[900],
                  allowDrawingOutsideViewBox: true,
                ),
              ),
            ],
          ),
        ));
  }

//  TextEditingController _nameTextController = TextEditingController();
//  TextEditingController _introTextController = TextEditingController();
//  File _userImageFile = File('');
//  String _userImageUrlFromFB = '';

  bool _isLoading = true;

  @override
  void initState() {
    NotificationController.instance.takeFCMTokenWhenAppLaunch();
    NotificationController.instance.initLocalNotification();
    setCurrentChatRoomID('none');
    _takeUserInformationFromFBDB();
    _saveDataToServer();
    readFromCash();
    super.initState();
  }

  readFromCash() async {
    String value = await _storage.read(key: "cart");
    if (value != null) {
      Cart cashedCart = Cart.fromJson(json.decode(value));
      if (cashedCart != null && cashedCart.items != null) {
        setState(() {
          _counter = cashedCart.items.length;
        });
      }
    }
  }

  _moveToChatList(data) {
    setState(() {
      _isLoading = false;
    });
    if (data != null) {
      print('go to chat');
//      Navigator.push(context,
//          MaterialPageRoute(builder: (context) => ChatList(data, "name")));
    } else {
      _showDialog('Save user data error');
    }
  }

  _takeUserInformationFromFBDB() async {
    FirebaseController.instanace
        .takeUserInformationFromFBDB()
        .then((documents) {
      if (documents.length > 0) {
        print('there is a user saved in FBDB');
//        _nameTextController.text = documents[0]['name'];
//        _introTextController.text = documents[0]['intro'];
//        setState(() {
//          _userImageUrlFromFB = documents[0]['userImageUrl'];
//        });
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  _showDialog(String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(msg),
          );
        });
  }

  _saveDataToServer() {
    setState(() {
      _isLoading = true;
    });
    String alertString = checkValidUserData(Globals.userData.first_name,
        Globals.userData.last_name, Globals.userData.token);

    if (alertString.trim() != '') {
      _showDialog(alertString);
    } else {
      FirebaseController.instanace.saveUserDataToFirebaseDatabase(
        Globals.userData.id.toString(),
        Globals.userData.first_name,
      );
//          .then((data) {
//        _moveToChatList(data);
//      });
//      _userImageUrlFromFB != ''
//          ? FirebaseController.instanace
//          .saveUserDataToFirebaseDatabase(
//          randomIdWithName(_nameTextController.text),
//          _nameTextController.text,
//          _introTextController.text,
//          _userImageUrlFromFB)
//          .then((data) {
//        _moveToChatList(data);
//      })
//          : FirebaseController.instanace
//          .saveUserImageToFirebaseStorage(
//          randomIdWithName(_nameTextController.text),
//          _nameTextController.text,
//          _introTextController.text,
//          _userImageFile)
//          .then((data) {
//        _moveToChatList(data);
//      });
    }
  }

  Widget _shoppingCartBadge() {
    return Badge(
      position: BadgePosition.topEnd(top: 0, end: 3),
      animationDuration: Duration(milliseconds: 300),
      animationType: BadgeAnimationType.slide,
      badgeColor: Colors.lightBlue,
      badgeContent: Text(
        _counter.toString(),
        style: TextStyle(color: Colors.white),
      ),
      child: IconButton(
          icon: Icon(Icons.shopping_cart, color: Colors.grey[700], size: 25),
//        SvgPicture.asset(
//            'images/icon_cart_appbar.svg',
//            height: 22.0,
//            width: 22.0,
//            allowDrawingOutsideViewBox: true,
//          ),
          onPressed: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new CartScreen()));
          }),
    );
  }
}
