import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:himaka/ViewModels/complaints_history_view_model.dart';

import '../ViewModels/base_model.dart';
import '../services/base_view.dart';
import '../services/locator.dart';
import '../utils/AppLanguage.dart';
import '../utils/app_localizations.dart';

class ComplaintsHistoryScreen extends StatefulWidget {
  @override
  _ComplaintsHistoryScreenState createState() =>
      _ComplaintsHistoryScreenState();
}

class _ComplaintsHistoryScreenState extends State<ComplaintsHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey[900], //change your color here
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate('history'),
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: BaseView<ComplaintsHistoryViewModel>(
          onModelReady: (model) {
            refreshScreen(model);
          },
          builder: (context, model, child) => LayoutBuilder(builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return model.state == ViewState.Busy
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.lightBlue,
                        ),
                      )
                    : model.complaintsResponse != null
                        ? model.complaintsResponse.data != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.lightBlueAccent,
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              'images/history.svg',
                                              height: 25.0,
                                              width: 25.0,
                                              allowDrawingOutsideViewBox: true,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              AppLocalizations.of(context)
                                                  .translate('history'),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        padding: EdgeInsets.all(20),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 6),
                                      child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Text(model.complaintsResponse
                                                  .data.complaints.length
                                                  .toString() +
                                              AppLocalizations.of(context)
                                                  .translate('items'))),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListView.builder(
                                            itemCount: model.complaintsResponse
                                                .data.complaints.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Card(
                                                child: ListTile(
                                                  title: Text(AppLocalizations
                                                              .of(context)
                                                          .translate('order') +
                                                      ' ' +
                                                      model
                                                          .complaintsResponse
                                                          .data
                                                          .complaints[index]
                                                          .id
                                                          .toString()),
                                                  subtitle: Row(
                                                    children: [
                                                      Expanded(
                                                          child: Text(
                                                            model
                                                                .complaintsResponse
                                                                .data
                                                                .complaints[index].details,
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      )),
                                                      Icon(
                                                        Icons.brightness_1,
                                                        size: 10,
                                                        color: model
                                                            .complaintsResponse
                                                            .data
                                                            .complaints[index]
                                                            .status=="0"?Colors.red:Colors.green,
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Text(model
                                                          .complaintsResponse
                                                          .data
                                                          .complaints[index]
                                                          .status=="0"?AppLocalizations.of(context).translate('pending'):AppLocalizations.of(context).translate('sent'))
                                                    ],
                                                  ),
                                                  // trailing: Icon(Icons.phone),
                                                ),
                                              );
                                            }),
                                      ),
                                    )
                                  ])
                            : Container(
                                child: Center(
                                  child: Text(AppLocalizations.of(context).translate('empty_complaints')),
                                ),
                              )
                        : Container(
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
                          );
              })),
    );
  }

  void refreshScreen(ComplaintsHistoryViewModel model) {
    model.getComplaints(locator<AppLanguage>().appLocal.languageCode);
  }
}
