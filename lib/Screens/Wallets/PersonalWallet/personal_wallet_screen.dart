import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Screens/Wallets/PersonalWallet/address_screen.dart';
import 'package:himaka/Screens/Wallets/PersonalWallet/cash_out_screen.dart';
import 'package:himaka/Screens/Wallets/PersonalWallet/method_of_cashout_screen.dart';
import 'package:himaka/utils/app_bar.dart';
import 'package:himaka/utils/app_localizations.dart';

import '../../bookings_screen.dart';

class PersonalWalletScreen extends StatefulWidget {
  @override
  _PersonalWalletScreenState createState() => _PersonalWalletScreenState();
}

class _PersonalWalletScreenState extends State<PersonalWalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar(
          AppLocalizations.of(context).translate('personal_wallet'), context),
      body: ListView(
        children: [
          InkWell(
            child: Card(
              elevation: 2,
              child: ListTile(
                leading: SvgPicture.asset(
                  'images/cash_out.svg',
                  height: 25.0,
                  width: 25,
                  allowDrawingOutsideViewBox: true,
                ),
                title: Text(
                  AppLocalizations.of(context).translate('cash_out'),
                  style: TextStyle(color: Colors.lightBlue),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.lightBlue,
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new CashOutScreen()));
            },
          ),
          SizedBox(
            height: 3,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new MethodOfCashOutScreen()));
            },
            child: Card(
              elevation: 2,
              child: ListTile(
                leading: SvgPicture.asset(
                  'images/earning_wallet_cash_out.svg',
                  height: 25.0,
                  width: 25,
                  allowDrawingOutsideViewBox: true,
                ),
                title: Text(
                  AppLocalizations.of(context).translate('method_cash_out'),
                  style: TextStyle(color: Colors.lightBlue),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.lightBlue,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new AddressScreen()));
            },
            child: Card(
              elevation: 2,
              child: ListTile(
                leading: Icon(
                  Icons.location_on,
                  color: Colors.lightBlue,
                ),
                title: Text(
                  AppLocalizations.of(context).translate('address'),
                  style: TextStyle(color: Colors.lightBlue),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.lightBlue,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new BookingsScreen(2)));
            },
            child: Card(
              elevation: 2,
              child: ListTile(
                leading: SvgPicture.asset(
                  'images/personal_wallet_order.svg',
                  height: 25.0,
                  width: 25.0,
                  allowDrawingOutsideViewBox: true,
                ),
                title: Text(
                  AppLocalizations.of(context).translate('order'),
                  style: TextStyle(color: Colors.lightBlue),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.lightBlue,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 3,
          ),
        ],
      ),
    );
  }
}
