import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Screens/Wallets/PersonalWallet/method_of_cashout_screen.dart';
import 'package:himaka/utils/app_bar.dart';

import '../../../utils/app_localizations.dart';
import 'earning_cash_out_screen.dart';

class EarningsWallets extends StatefulWidget {
  @override
  _EarningsWalletsState createState() => _EarningsWalletsState();
}

class _EarningsWalletsState extends State<EarningsWallets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar(
          AppLocalizations.of(context).translate('earning_wallet'), context),
      body: ListView(
        children: [
//           InkWell(
//             child: Card(
//               elevation: 2,
//               child: ListTile(
//                 leading: Icon(Icons.person , color: Colors.lightBlue,),
//                 title: Text("Product New" , style: TextStyle(color: Colors.lightBlue),),
//                 trailing: Icon(Icons.arrow_forward_ios , color: Colors.lightBlue,),
//               ),
//             ),
//             onTap: (){
// //              Navigator.push(
// //                  context,
// //                  new MaterialPageRoute(
// //                      builder: (context) => new CashOutScreen()));
//             },
//           ),
//           SizedBox(height: 3,),

          // InkWell(
          //  onTap: (){
//              Navigator.push(
//                  context,
//                  new MaterialPageRoute(
//                      builder: (context) => new MethodOfCashOutScreen()));
          // },
          //   child: Card(
          //     elevation: 2,
          //     child: ListTile(
          //       leading: Icon(Icons.person , color: Colors.lightBlue,),
          //       title: Text("Order Client" , style: TextStyle(color: Colors.lightBlue),),
          //       trailing: Icon(Icons.arrow_forward_ios , color: Colors.lightBlue,),
          //     ),
          //   ),
          // ),
          // SizedBox(height: 3,),

          InkWell(
            onTap: () {
//              Navigator.push(
//                  context,
//                  new MaterialPageRoute(
//                      builder: (context) => new AddressScreen()));
            },
            child: InkWell(
              child: Card(
                elevation: 2,
                child: ListTile(
                  leading: SvgPicture.asset(
                    'images/earning_wallet_cash_out.svg',
                    height: 25.0,
                    width: 25.0,
                    allowDrawingOutsideViewBox: true,
                  ),
                  title: Text(
                    "Cash out",
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
                        builder: (context) => new EarningCashOutScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
