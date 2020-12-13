import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Screens/Wallets/CashBackWallet/cash_back_wallet_screen.dart';
import 'package:himaka/Screens/Wallets/CommissionWallet/commission_wallet.dart';
import 'package:himaka/Screens/Wallets/RewardWallet/rewards_wallet.dart';

import '../utils/app_localizations.dart';
import 'Wallets/EarningsWallet/earnings_wallet_screen.dart';
import 'Wallets/PersonalWallet/personal_wallet_screen.dart';
import 'upgrade_screen.dart';

class WalletsScreen extends StatefulWidget {
  @override
  _WalletsScreenState createState() => _WalletsScreenState();
}

class _WalletsScreenState extends State<WalletsScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        InkWell(
          child: Card(
            elevation: 2,
            child: ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.lightBlue,
              ),
              title: Text(
                AppLocalizations.of(context).translate('personal_wallet'),
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
                    builder: (context) => new PersonalWalletScreen()));
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
                    builder: (context) => new CashBackWalletScreen()));
          },
          child: Card(
            elevation: 2,
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SvgPicture.asset(
                  'images/Layer_2.svg',
                  height: 25.0,
                  width: 25.0,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
              title: Text(
                AppLocalizations.of(context).translate('cash_back_wallet'),
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
                    builder: (context) => new CommissionWalletScreen()));
          },
          child: Card(
            elevation: 2,
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SvgPicture.asset(
                  'images/icon_general.svg',
                  height: 25.0,
                  width: 25.0,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
              title: Text(
                AppLocalizations.of(context).translate('commission_wallet'),
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
                    builder: (context) => new RewardsWalletScreen()));
          },
          child: Card(
            elevation: 2,
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SvgPicture.asset(
                  'images/Badge.svg',
                  height: 25.0,
                  width: 25.0,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
              title: Text(
                AppLocalizations.of(context).translate('rewards_wallet'),
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
          child: Card(
            elevation: 2,
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SvgPicture.asset(
                  'images/icon_earning.svg',
                  height: 25.0,
                  width: 25.0,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
              title: Text(
                AppLocalizations.of(context).translate('earning_wallet'),
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
                    builder: (context) => new EarningsWallets()));
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
                    builder: (context) => new UpgradeScreen()));
          },
          child: Card(
            elevation: 2,
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SvgPicture.asset(
                  'images/page_1.svg',
                  height: 25.0,
                  width: 25.0,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
              title: Text(
                AppLocalizations.of(context).translate('upgrade'),
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
    );
  }
}
