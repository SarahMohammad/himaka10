import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/Models/personal_wallet_cash_out.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/ViewModels/personal_wallet_view_model.dart';
import 'package:himaka/services/base_view.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/AppLanguage.dart';
import 'package:himaka/utils/app_localizations.dart';
import 'package:himaka/utils/show_toast.dart';

class SafetyScreen extends StatefulWidget {
  String amount;
  int withdrawId;
  String withdrawFieldValue;
  String withdrawDesc;

  SafetyScreen(
      {this.amount,
      this.withdrawId,
      this.withdrawFieldValue,
      this.withdrawDesc});

  @override
  _SafetyScreenState createState() => _SafetyScreenState();
}

class _SafetyScreenState extends State<SafetyScreen> {
  final TextEditingController _pinController = new TextEditingController();
  final TextEditingController _answerController = new TextEditingController();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();


  String val;

  List<String> users = <String>[
    'In what city did your parents meet?',
    'What is your favorite color?',
    'What is your current job?',
    'What is your favorite team?',
    'What is your favorite movie?',
    'In what town was your first job?',
    'What is the color of your eyes?',
  ];

  @override
  Widget build(BuildContext context) {
    return BaseView<PersonalWalletViewModel>(
        builder: (context, model, child) => LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(
                  title: Text(
                    AppLocalizations.of(context).translate('safety'),
                    style: TextStyle(color: Colors.grey[900]),
                  ),
                  elevation: 0.0,
                  backgroundColor: Colors.white,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.cancel,
                          color: Colors.blue,
                        ),
                      ),
                    )
                  ],
                ),
                backgroundColor: Color(0xfff5f5f5),
                body: Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'ADDRESS DETAILS TO CASH OUT',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              child: new TextField(
                                textAlign: TextAlign.center,
                                cursorColor: Colors.white,
                                controller: _pinController,
                                decoration: new InputDecoration(
                                  errorText: model.pinValidate
                                      ? null
                                      : AppLocalizations.of(context)
                                          .translate('pin_safety_error'),
                                  contentPadding: EdgeInsets.all(0),
                                  labelText: 'Pin',
                                  labelStyle: TextStyle(color: Colors.grey),
                                  hintStyle: TextStyle(fontSize: 20.0),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 20.0),
                              width: MediaQuery.of(context).size.width,
                              child: DropdownButton<String>(
                                dropdownColor: Colors.white,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.grey,
                                ),
                                isExpanded: true,
                                hint: Text(
                                  "Choose a question for your security",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                value: val,
                                onChanged: (String value) {
                                  setState(() {
                                    val = value;
                                  });
                                },
                                items: users.map(
                                  (String question) {
                                    return DropdownMenuItem<String>(
                                      value: question,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.help_outline,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            question,
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                            model.quesValidate
                                ? Container()
                                : Container(
                                    width: double.infinity,
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('ques_safety_error'),
                                      style: TextStyle(
                                          color: Colors.red[700], fontSize: 13),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                            Container(
                              child: new TextField(
                                controller: _answerController,
                                decoration: new InputDecoration(
                                  errorText: model.answerValidate
                                      ? null
                                      : AppLocalizations.of(context)
                                          .translate('answer_safety_error'),
                                  labelText:
                                      'Answer the question have been chosen',
                                  labelStyle: TextStyle(color: Colors.grey),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: SvgPicture.asset(
                                      'images/icon_answers.svg',
                                      height: 5.0,
                                      width: 5.0,
                                      color: Colors.grey,
                                      allowDrawingOutsideViewBox: true,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            model.state == ViewState.Busy
                                ? Container(
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.lightBlue,
                                      ),
                                    ),
                                  )
                                : RaisedButton(
                                    child: Text(
                                      'Complete your order',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async{
                                      if (model.safetyValidation(
                                          _pinController.text.trim(),
                                          val,
                                          _answerController.text.trim())) {
                                        PersonalWalletCashOutResponse response=await cashOut(model);
                                        if(response==null){
                                          final snackBar = SnackBar(
                                            content: Text(
                                                AppLocalizations.of(
                                                    context)
                                                    .translate(
                                                    'check_network')),
                                            backgroundColor: Colors.red,
                                          );
                                          _scaffoldKey.currentState
                                              .showSnackBar(snackBar);

                                        }else if(response.status){
                                          showToast( AppLocalizations.of(context)
                                              .translate('done_successfully'),Colors.green);
                                          Navigator.of(context).pop("sent");
                                        }else {
                                          showToast(response.errors.toString(),Colors.red);
                                        }
                                      }
                                    },
                                    color: Colors.lightBlueAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }));
  }
  Future<PersonalWalletCashOutResponse> cashOut(PersonalWalletViewModel model){
    return model.personalWalletCashOut(locator<AppLanguage>().appLocal.languageCode,
        widget.amount, widget.withdrawId, widget.withdrawFieldValue, widget.withdrawDesc);

  }

}
