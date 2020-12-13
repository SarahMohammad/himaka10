import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Screens/bookings_screen.dart';
import 'package:himaka/Screens/complain_request_screen.dart';
import 'package:himaka/Screens/customer_support_screen.dart';
import 'package:himaka/Screens/profile_screen.dart';
import 'package:himaka/utils/AppLanguage.dart';
import 'package:himaka/utils/app_localizations.dart';
import 'package:himaka/utils/searchDialog.dart';
import 'package:provider/provider.dart';

import 'client_user_orders_screen.dart';

class SettingsScreen extends StatefulWidget {
  final Function callback;

  SettingsScreen(this.callback);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController searchKeyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: [
          // ListTile(
          //   leading: Icon(Icons.search, color: Colors.grey[800]),
          //   title: Text(
          //     "Search",
          //     style: TextStyle(color: Colors.grey[800]),
          //   ),
          //   trailing: Icon(
          //     Icons.arrow_forward_ios,
          //     color: Colors.lightBlue,
          //   ),
          // ),
          InkWell(
            child: ListTile(
              leading: Icon(Icons.search, color: Colors.grey[800]),
              title: Text(
                AppLocalizations.of(context).translate('search'),
                style: TextStyle(color: Colors.grey[800]),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.lightBlue,
              ),
            ),
            onTap: () {
              showSearchDialog(widget.callback, context, 3,
                  searchKeyController: searchKeyController);
            },
          ),
          InkWell(
            child: ListTile(
              leading: Icon(Icons.person, color: Colors.grey[800]),
              title: Text(
                AppLocalizations.of(context).translate('my_profile'),
                style: TextStyle(color: Colors.grey[800]),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.lightBlue,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new ProfileScreen()));
            },
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new BookingsScreen(1)));
            },
            child: ListTile(
              leading: Icon(Icons.favorite, color: Colors.grey[800]),
              title: Text(
                AppLocalizations.of(context).translate('my_bookings'),
                style: TextStyle(color: Colors.grey[800]),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.lightBlue,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new ClientUserOrderScreen(2)));
            },
            child: ListTile(
              leading: SvgPicture.asset(
                'images/your_order.svg',
                height: 24.0,
                width: 24.0,
                allowDrawingOutsideViewBox: true,
              ),
//              Icon(Icons.call, color: Colors.grey[800]),
              title: Text(
                AppLocalizations.of(context).translate('your_orders'),
                style: TextStyle(color: Colors.grey[800]),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.lightBlue,
              ),
            ),
          ),

          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new ClientUserOrderScreen(4)));
            },
            child: ListTile(
              leading: SvgPicture.asset(
                'images/or_client.svg',
                height: 24.0,
                width: 24.0,
                allowDrawingOutsideViewBox: true,
              ),
//              Icon(Icons.call, color: Colors.grey[800]),
              title: Text(
                AppLocalizations.of(context).translate('order_client'),
                style: TextStyle(color: Colors.grey[800]),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.lightBlue,
              ),
            ),
          ),

          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new ComplainRequestScreen()));
            },
            child: ListTile(
              leading: SvgPicture.asset(
                'images/complians.svg',
                height: 24.0,
                width: 24.0,
                allowDrawingOutsideViewBox: true,
              ),
//              Icon(Icons.call, color: Colors.grey[800]),
              title: Text(
                AppLocalizations.of(context).translate('complaint_requests'),
                style: TextStyle(color: Colors.grey[800]),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.lightBlue,
              ),
            ),
          ),

          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new CustomerSupportScreen()));
            },
            child: ListTile(
              leading: Icon(Icons.call, color: Colors.grey[800]),
              title: Text(
                AppLocalizations.of(context).translate('customer_support'),
                style: TextStyle(color: Colors.grey[800]),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.lightBlue,
              ),
            ),
          ),

          // InkWell(
          //   onTap: () {
          //   },
          //   child: ListTile(
          //     leading: Icon(Icons.language, color: Colors.grey[800]),
          //     title: Text(
          //       "Language",
          //       style: TextStyle(color: Colors.grey[800]),
          //     ),
          //     trailing: Icon(
          //       Icons.arrow_forward_ios,
          //       color: Colors.lightBlue,
          //     ),
          //   ),
          // ),
          InkWell(
            child:
                // Container(
                //     child: SimpleAccountMenu(
                //       stringList: [
                //         Text('english' , style: TextStyle(color: Colors.white ,)),
                //         Text('arabic'),
                //       ],
                //       iconColor: Colors.white,
                //       onChange: (index) {
                //         print(index);
                //       },
                //     )),
                ExpansionTile(
                    leading: Icon(Icons.language, color: Colors.grey[800]),
                    title: Text(
                      AppLocalizations.of(context).translate('lang'),
                      style: TextStyle(color: Colors.grey[800]),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.lightBlue,
                    ),
                    children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                        onTap: () {
                          setState(() {
                            appLanguage.changeLanguage(Locale("ar"));
                          });
                        },
                        title: Text(
                            AppLocalizations.of(context).translate('arabic'))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                      title: Text('English'),
                      onTap: () {
                        setState(() {
                          appLanguage.changeLanguage(Locale("en"));
                        });
                      },
                    ),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}

class WalletData {
  String title;
  Icon walletIcon;

  WalletData({this.title, this.walletIcon});
}
