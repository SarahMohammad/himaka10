import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/ViewModels/customer_support_view_model.dart';
import 'package:himaka/services/base_view.dart';
import 'package:himaka/utils/app_localizations.dart';

class CustomerSupportScreen extends StatefulWidget {
  @override
  _CustomerSupportScreenState createState() => _CustomerSupportScreenState();
}

class _CustomerSupportScreenState extends State<CustomerSupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey[900], //change your color here
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate('customer_support'),
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: BaseView<CustomerSupportViewModel>(
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
                    : model.customerSupportResponse != null
                        ? Container(
                            height: MediaQuery.of(context).size.height / 2 - 40,
                            child: Card(
                              elevation: 1.0,
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate('call_us'),
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Icon(
                                          Icons.headset_mic,
                                          color: Colors.lightBlueAccent,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(model.customerSupportResponse.data
                                        .workHoursAndDays),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      child: Text(model
                                          .customerSupportResponse.data.phone),
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Divider(
                                        color: Colors.black,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate('contact_us'),
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Icon(
                                          Icons.phone,
                                          color: Colors.lightBlueAccent,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                        "Our cutomer support will get back to you shortly"),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      child: Text(model
                                          .customerSupportResponse.data.mail),
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: Text('empty'),
                          );
              })),
    );
  }

  void refreshScreen(CustomerSupportViewModel model) {
    model.getCustomerSupport();
  }
}
