import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/ViewModels/profile_view_model.dart';
import 'package:himaka/services/base_view.dart';
import 'package:himaka/utils/app_bar.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  bool textSetInitialVal = false;
  bool _toggle = false;
  TextEditingController _addressController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: setAppBar('Personal Wallet', context),
        body: BaseView<ProfileViewModel>(
            onModelReady: (model) {
              refreshScreen(model);
            },
            builder: (context, model, child) => LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
                  if (!textSetInitialVal && model.profileResponse != null) {
                    textSetInitialVal = true;
                    textFormConfiguration(context, model);
                  }

                  return (model.state == ViewState.Busy && model.serviceId == 1)
                      ? Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.lightBlue,
                          ),
                        )
                      : model.profileResponse != null
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
                                          Icon(Icons.pin_drop,
                                              color: Colors.white),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text('Address',
                                              style: TextStyle(
                                                  color: Colors.white)),
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
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Additional address details',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.5,
                                              child: TextField(
                                                enabled: _toggle,
                                                controller: _addressController,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: new InputDecoration(
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              _toggle = true;
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Text('edit',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .lightBlueAccent)),
                                              Icon(
                                                Icons.edit,
                                                color: Colors.lightBlueAccent,
                                                size: 16,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: (model.state == ViewState.Busy &&
                                            model.serviceId == 2)
                                        ? Center(
                                            child: CircularProgressIndicator(
                                              backgroundColor: Colors.lightBlue,
                                            ),
                                          )
                                        : Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: RaisedButton(
                                              color: Colors.lightBlueAccent,
                                              child: Text('Done',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              onPressed: _toggle
                                                  ? () => setNewAddress(
                                                      _addressController.text,
                                                      model)
                                                  : null,
                                            )),
                                  )
                                ],
                              ),
                            ])
                          : Center(
                              child: Text('empty'),
                            );
                })));
  }

  void textFormConfiguration(BuildContext context, ProfileViewModel model) {
//    model.setWorkTimeInitialData(model.loginResponse.homeResult.centerTimeWork);

    _addressController =
        TextEditingController(text: model.profileResponse.data.user.address);

    _addressController.addListener(() {
      final name = _addressController.text;
      _addressController.value = _addressController.value.copyWith(
        text: name,
      );
    });
  }

  void refreshScreen(ProfileViewModel model) {
    model.getProfileDetails("");
  }

  setNewAddress(String address, ProfileViewModel model) {
    // AddressViewModel model = new AddressViewModel();
    model.setAddress(address);
  }
}
