import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Models/pre_register_response.dart';
import 'package:himaka/Screens/Wallets/safety_screen.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/ViewModels/personal_wallet_view_model.dart';
import 'package:himaka/services/base_view.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/AppLanguage.dart';
import 'package:himaka/utils/app_bar.dart';
import 'package:himaka/utils/app_localizations.dart';

class CashOutScreen extends StatefulWidget {
  @override
  _CashOutScreenState createState() => _CashOutScreenState();
}

class _CashOutScreenState extends State<CashOutScreen> {
  TextEditingController _methodController;
  TextEditingController _amountController = new TextEditingController();

  TextEditingController _descController;

  bool initializeMethods = false;
  WithdrawMethod val;

  @override
  Widget build(BuildContext context) {
    return BaseView<PersonalWalletViewModel>(
        onModelReady: (model) {
          refreshScreen(model);
        },
        builder: (context, model, child) => LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              if (!initializeMethods &&
                  model.personalWalletCashOutResponse != null) {
                initializeMethods = true;
                val = model.personalWalletCashOutResponse.data
                    .withdraws_methods[model.getUserWithdrawMethodIndex(model
                            .personalWalletCashOutResponse
                            .data
                            .user
                            .withdrawMethod
                            .id !=
                        -1
                    ? model.personalWalletCashOutResponse.data.user
                        .withdrawMethod.id
                    : 0)];
                _methodController = new TextEditingController(
                    text: model.personalWalletCashOutResponse.data.user
                        .withdraw_field_value);
                _descController = new TextEditingController(
                    text: model.personalWalletCashOutResponse.data.user
                        .withdraw_field_description);
              }
              return Scaffold(
                appBar: setAppBar(
                    AppLocalizations.of(context).translate('personal_wallet'),
                    context),
                body: model.personalWalletCashOutResponse != null
                    ? ListView(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.lightBlueAccent,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'images/cash_out.svg',
                                      height: 25.0,
                                      width: 25.0,
                                      allowDrawingOutsideViewBox: true,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                        AppLocalizations.of(context)
                                            .translate('cash_out'),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15)),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                                child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(AppLocalizations.of(context)
                                      .translate('wallet_balance')),
                                  Text(
                                      model.personalWalletCashOutResponse.data
                                              .balance +
                                          ' ' +
                                          model.personalWalletCashOutResponse
                                              .data.user.currency,
                                      style: TextStyle(
                                          color: Colors.lightBlueAccent))
                                ],
                              ),
                            )),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 8),
                              child: Text(AppLocalizations.of(context)
                                  .translate('cash_out_imm')),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              autofocus: false,
                              controller: _amountController,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: SvgPicture.asset(
                                    'images/icon_money.svg',
                                    height: 25.0,
                                    width: 25.0,
                                    color: Colors.black,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                ),
                                hintText: AppLocalizations.of(context)
                                    .translate('enter_amount_to_load'),
                                errorText: model.amountValidate
                                    ? null
                                    : AppLocalizations.of(context)
                                        .translate('empty_error'),
                                hintStyle: TextStyle(
                                    color: Colors.black,
                                    textBaseline: TextBaseline.alphabetic),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 8),
                              child: Text(AppLocalizations.of(context)
                                  .translate('method_cash_out')),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 20.0),
                              width: MediaQuery.of(context).size.width,
                              child: DropdownButton<WithdrawMethod>(
                                dropdownColor: Colors.white,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                                isExpanded: true,
                                hint: Text(
                                  "Select the method",
                                  style: TextStyle(color: Colors.white),
                                ),
                                value: val,
                                onChanged: (WithdrawMethod value) {
                                  setState(() {
                                    // model.methodIdValidate = true;
                                    val = value;
                                  });
                                },
                                items: model.personalWalletCashOutResponse.data
                                    .withdraws_methods
                                    .map(
                                  (WithdrawMethod method) {
                                    return DropdownMenuItem<WithdrawMethod>(
                                      value: method,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: SvgPicture.asset(
                                              'images/icon_money.svg',
                                              height: 25.0,
                                              width: 25.0,
                                              color: Colors.blue,
                                              allowDrawingOutsideViewBox: true,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            method.name != null
                                                ? method.name
                                                : "method name",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                            Column(
                              children: [
                                new Container(
                                  child: new TextField(
                                    cursorColor: Colors.blue,
                                    controller: _methodController,
                                    decoration: new InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      labelStyle:
                                          TextStyle(color: Colors.black87),
                                      labelText: val.field_name,
                                      hintStyle: TextStyle(
                                          fontSize: 20.0, color: Colors.blue),
                                      errorText: model.methodFieldValidate
                                          ? null
                                          : AppLocalizations.of(context)
                                              .translate(
                                                  'eight_validate_error'),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black87),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black87),
                                      ),
                                    ),
                                  ),
                                ),
                                new Container(
                                  child: new TextField(
                                    cursorColor: Colors.blue,
                                    controller: _descController,
                                    decoration: new InputDecoration(
                                      labelStyle:
                                          TextStyle(color: Colors.black87),
                                      labelText: 'Description the method',
                                      hintStyle: TextStyle(
                                          fontSize: 20.0, color: Colors.blue),
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: SvgPicture.asset(
                                          'images/icon_desc.svg',
                                          height: 5.0,
                                          width: 5.0,
                                          color: Colors.blue,
                                          allowDrawingOutsideViewBox: true,
                                        ),
                                      ),
                                      // errorText: model.descValidate
                                      //     ? null
                                      //     : AppLocalizations.of(context)
                                      //         .translate('empty_error'),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black87),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black87),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Center(
                              child: RaisedButton(
                                child: Text(
                                  'Complete your transtion',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  if (model.personalWalletCashOutValidation(
                                      val,
                                      _methodController.text.trim(),
                                      _amountController.text.trim())) {
                                    var result = await Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                new SafetyScreen(
                                                  amount: _amountController.text
                                                      .trim(),
                                                  withdrawId: val.id,
                                                  withdrawDesc:
                                                      _descController.text,
                                                  withdrawFieldValue:
                                                      _methodController.text
                                                          .trim(),
                                                )));
                                    if (result != null && result == "sent") {
                                      refreshScreen(model);
                                      initializeMethods = false;
                                    }
                                  }
                                },
                                color: Colors.lightBlueAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'images/personal_recent.svg',
                                height: 25.0,
                                width: 25.0,
                                allowDrawingOutsideViewBox: true,
                              ),
                              SizedBox(
                                width: 14,
                              ),
                              Text(AppLocalizations.of(context)
                                  .translate('recent_transactions')),
                            ],
                          ),
                        ),
                        (model.personalWalletCashOutResponse.data
                                        .transactions !=
                                    null &&
                                model.personalWalletCashOutResponse.data
                                        .transactions.length >
                                    0)
                            ? ListView.separated(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                separatorBuilder: (context, index) => Divider(
                                  color: Colors.grey[900],
                                ),
                                itemCount: model.personalWalletCashOutResponse
                                    .data.transactions.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.all(1.0),
                                  child: InkWell(
                                    onTap: () {},
                                    child: ListTile(
                                      leading: model
                                                  .personalWalletCashOutResponse
                                                  .data
                                                  .transactions[index]
                                                  .confirm ==
                                              "0"
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: SvgPicture.asset(
                                                  'images/personal_recent_wrong.svg',
                                                  height: 20.0,
                                                  width: 20.0,
                                                  allowDrawingOutsideViewBox:
                                                      true,
                                                ),
                                              ),
                                            )
                                          : SvgPicture.asset(
                                              'images/personal_recent_right.svg',
                                              height: 20.0,
                                              width: 20.0,
                                              allowDrawingOutsideViewBox: true,
                                            ),
                                      title: Text(
                                        model.personalWalletCashOutResponse.data
                                            .transactions[index].name,
                                      ),
                                      subtitle: Text(
                                        model.personalWalletCashOutResponse.data
                                            .transactions[index].value,
                                      ),
                                      trailing: Column(
                                        children: [
                                          Text(
                                            model
                                                    .personalWalletCashOutResponse
                                                    .data
                                                    .transactions[index]
                                                    .amount +
                                                ' ' +
                                                model
                                                    .personalWalletCashOutResponse
                                                    .data
                                                    .user
                                                    .currency,
                                            style: TextStyle(
                                                color: Colors.lightBlueAccent),
                                          ),
                                          Text(DateTime.parse(model
                                                      .personalWalletCashOutResponse
                                                      .data
                                                      .transactions[index]
                                                      .transactionDate)
                                                  .day
                                                  .toString() +
                                              '/ ' +
                                              DateTime.parse(model
                                                      .personalWalletCashOutResponse
                                                      .data
                                                      .transactions[index]
                                                      .transactionDate)
                                                  .month
                                                  .toString() +
                                              '/ ' +
                                              DateTime.parse(model
                                                      .personalWalletCashOutResponse
                                                      .data
                                                      .transactions[index]
                                                      .transactionDate)
                                                  .year
                                                  .toString())
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Center(
                                child: Text(AppLocalizations.of(context)
                                    .translate('empty')),
                              ),
                      ])
                    : model.state == ViewState.Idle
                        ? Scaffold(
                            backgroundColor: Colors.transparent,
                            body: Container(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate('network_failed'),
                                    ),
                                    RaisedButton(
                                      onPressed: () {
                                        refreshScreen(model);
                                      },
                                      color: Color.fromRGBO(235, 85, 85, 100),
                                      child: Icon(Icons.refresh),
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30),
                                          side: BorderSide(
                                              color: Color.fromRGBO(
                                                  235, 85, 85, 100))),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.lightBlue,
                            ),
                          ),
              );
            }));
  }

  refreshScreen(PersonalWalletViewModel model) {
    model
        .prePersonalWalletCashOut(locator<AppLanguage>().appLocal.languageCode);
  }
}
