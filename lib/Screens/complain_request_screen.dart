import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Screens/Wallets/CashBackWallet/cash_back_wallet_screen.dart';
import 'package:himaka/Screens/Wallets/CommissionWallet/commission_wallet.dart';
import 'package:himaka/Screens/Wallets/RewardWallet/rewards_wallet.dart';
import 'package:himaka/Screens/add_complain_screen.dart';
import 'package:himaka/utils/app_bar.dart';

import '../utils/app_localizations.dart';
import 'Wallets/EarningsWallet/earnings_wallet_screen.dart';
import 'Wallets/PersonalWallet/personal_wallet_screen.dart';
import 'bookings_screen.dart';
import 'complaints_history.dart';
import 'upgrade_screen.dart';

class ComplainRequestScreen extends StatefulWidget {
  @override
  _ComplainRequestScreenState createState() => _ComplainRequestScreenState();
}

class _ComplainRequestScreenState extends State<ComplainRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar(
          AppLocalizations.of(context).translate('complaint_requests'),
          context),
      body: ListView(
        children: [
          InkWell(
            child: Card(
              elevation: 2,
              child: ListTile(
                leading: SvgPicture.asset(
                  'images/plus.svg',
                  height: 25.0,
                  width: 25.0,
                  allowDrawingOutsideViewBox: true,
                ),
                title: Text(
                  AppLocalizations.of(context).translate('add_complain'),
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
                      builder: (context) => new AddComplainScreen()));
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
                      builder: (context) => new ComplaintsHistoryScreen()));
            },
            child: Card(
              elevation: 2,
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SvgPicture.asset(
                    'images/history.svg',
                    height: 25.0,
                    width: 25.0,
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                title: Text(
                  AppLocalizations.of(context).translate('history'),
                  style: TextStyle(color: Colors.lightBlue),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.lightBlue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
