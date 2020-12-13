import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:himaka/Models/add_product_response.dart';
import 'package:himaka/ViewModels/add_product_or_service_view_model.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/services/base_view.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/AppLanguage.dart';
import 'package:himaka/utils/add_categories.dart';
import 'package:himaka/utils/app_localizations.dart';
import 'package:himaka/utils/camera_gallery_alert.dart';
import 'package:himaka/utils/show_toast.dart';
import 'package:image_picker/image_picker.dart';

import 'categories_tags_selection_screen.dart';

class ProductServiceConstructScreen extends StatefulWidget {
  final int type;

  ProductServiceConstructScreen(this.type);

  @override
  _ProductServiceConstructScreenState createState() =>
      _ProductServiceConstructScreenState();
}

class _ProductServiceConstructScreenState
    extends State<ProductServiceConstructScreen> {
  String _retrieveDataError;
  File _imageFile2, _imageFile3, _imageFile4, _imageFile5, _imageFile6;
  dynamic _pickImageError;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _descController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();
  TextEditingController _discountController = new TextEditingController();

  String ress = 'Select category';
  List<int> tagsId = [];

  @override
  Widget build(BuildContext context) {
    return BaseView<AddProductOrServiceViewModel>(
        onModelReady: (model) {
          refreshScreen(model);
        },
        builder: (context, model, child) => LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return model.productOrService != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('add_pictures'),
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.white,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[300],
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 100,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                            color: Colors.lightBlue,
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.camera_alt,
                                                    color: Colors.white,
                                                    size: 55,
                                                  ),
                                                  Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              'add_pictures'),
                                                      style: TextStyle(
                                                          color: Colors.white))
                                                ],
                                              ),
                                            )),
                                      ),
                                      SizedBox(
                                        width: 13,
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () async {
                                            cameraLibraryDialog(context)
                                                .then((value) async {
                                              if (value != null &&
                                                  value == "1") {
                                                _onImageButtonPressed(
                                                    ImageSource.camera, 2,model,
                                                    context: context);
                                              } else if (value != null &&
                                                  value == "2") {
                                                _onImageButtonPressed(
                                                    ImageSource.gallery, 2,model,
                                                    context: context);
                                              }
                                            });
                                          },
                                          child: _imageFile2 != null
                                              ? Platform.isAndroid
                                                  ? FutureBuilder<void>(
                                                      future:
                                                          retrieveLostData(2,model),
                                                      builder: (BuildContext
                                                              context,
                                                          AsyncSnapshot<void>
                                                              snapshot) {
                                                        switch (snapshot
                                                            .connectionState) {
                                                          case ConnectionState
                                                              .none:
                                                          case ConnectionState
                                                              .waiting:
                                                          case ConnectionState
                                                              .done:
                                                            return Container(
                                                              child: Image.file(
                                                                  _imageFile2),
                                                            );
                                                          default:
                                                            return Container(
                                                                color: Colors
                                                                    .grey[300],
                                                                child: Center(
                                                                  child: Icon(
                                                                      Icons
                                                                          .add),
                                                                ));
                                                        }
                                                      },
                                                    )
                                                  : Container(
                                                      child: Image.file(
                                                          _imageFile2),
                                                    )
                                              : Container(
                                                  color: Colors.grey[300],
                                                  child: Center(
                                                    child: Icon(Icons.add),
                                                  )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 13,
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () async {
                                            cameraLibraryDialog(context)
                                                .then((value) async {
                                              if (value != null &&
                                                  value == "1") {
                                                _onImageButtonPressed(
                                                    ImageSource.camera, 3,model,
                                                    context: context);
                                              } else if (value != null &&
                                                  value == "2") {
                                                _onImageButtonPressed(
                                                    ImageSource.gallery, 3,model,
                                                    context: context);
                                              }
                                            });
                                          },
                                          child: _imageFile3 != null
                                              ? Platform.isAndroid
                                                  ? FutureBuilder<void>(
                                                      future:
                                                          retrieveLostData(3,model),
                                                      builder: (BuildContext
                                                              context,
                                                          AsyncSnapshot<void>
                                                              snapshot) {
                                                        switch (snapshot
                                                            .connectionState) {
                                                          case ConnectionState
                                                              .none:
                                                          case ConnectionState
                                                              .waiting:
                                                          case ConnectionState
                                                              .done:
                                                            return Container(
                                                              child: Image.file(
                                                                  _imageFile3),
                                                            );
                                                          default:
                                                            return Container(
                                                                color: Colors
                                                                    .grey[300],
                                                                child: Center(
                                                                  child: Icon(
                                                                      Icons
                                                                          .add),
                                                                ));
                                                        }
                                                      },
                                                    )
                                                  : Container(
                                                      child: Image.file(
                                                          _imageFile3),
                                                    )
                                              : Container(
                                                  color: Colors.grey[300],
                                                  child: Center(
                                                    child: Icon(Icons.add),
                                                  )),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 13,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  height: 100,
                                  child: Row(
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () {
                                            cameraLibraryDialog(context)
                                                .then((value) async {
                                              if (value != null &&
                                                  value == "1") {
                                                _onImageButtonPressed(
                                                    ImageSource.camera, 4,model,
                                                    context: context);
                                              } else if (value != null &&
                                                  value == "2") {
                                                _onImageButtonPressed(
                                                    ImageSource.gallery, 4,model,
                                                    context: context);
                                              }
                                            });
                                          },
                                          child: _imageFile4 != null
                                              ? Platform.isAndroid
                                                  ? FutureBuilder<void>(
                                                      future:
                                                          retrieveLostData(4,model),
                                                      builder: (BuildContext
                                                              context,
                                                          AsyncSnapshot<void>
                                                              snapshot) {
                                                        switch (snapshot
                                                            .connectionState) {
                                                          case ConnectionState
                                                              .none:
                                                          case ConnectionState
                                                              .waiting:
                                                          case ConnectionState
                                                              .done:
                                                            return Container(
                                                              child: Image.file(
                                                                  _imageFile4),
                                                            );
                                                          default:
                                                            return Container(
                                                                color: Colors
                                                                    .grey[300],
                                                                child: Center(
                                                                  child: Icon(
                                                                      Icons
                                                                          .add),
                                                                ));
                                                        }
                                                      },
                                                    )
                                                  : Container(
                                                      child: Image.file(
                                                          _imageFile4),
                                                    )
                                              : Container(
                                                  color: Colors.grey[300],
                                                  child: Center(
                                                    child: Icon(Icons.add),
                                                  )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 13,
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () {
                                            cameraLibraryDialog(context)
                                                .then((value) async {
                                              if (value != null &&
                                                  value == "1") {
                                                _onImageButtonPressed(
                                                    ImageSource.camera, 5,model,
                                                    context: context);
                                              } else if (value != null &&
                                                  value == "2") {
                                                _onImageButtonPressed(
                                                    ImageSource.gallery, 5,model,
                                                    context: context);
                                              }
                                            });
                                          },
                                          child: _imageFile5 != null
                                              ? Platform.isAndroid
                                                  ? FutureBuilder<void>(
                                                      future:
                                                          retrieveLostData(5,model),
                                                      builder: (BuildContext
                                                              context,
                                                          AsyncSnapshot<void>
                                                              snapshot) {
                                                        switch (snapshot
                                                            .connectionState) {
                                                          case ConnectionState
                                                              .none:
                                                          case ConnectionState
                                                              .waiting:
                                                          case ConnectionState
                                                              .done:
                                                            return Container(
                                                              child: Image.file(
                                                                  _imageFile5),
                                                            );
                                                          default:
                                                            return Container(
                                                                color: Colors
                                                                    .grey[300],
                                                                child: Center(
                                                                  child: Icon(
                                                                      Icons
                                                                          .add),
                                                                ));
                                                        }
                                                      },
                                                    )
                                                  : Container(
                                                      child: Image.file(
                                                          _imageFile5),
                                                    )
                                              : Container(
                                                  color: Colors.grey[300],
                                                  child: Center(
                                                    child: Icon(Icons.add),
                                                  )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 13,
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () {
                                            cameraLibraryDialog(context)
                                                .then((value) async {
                                              if (value != null &&
                                                  value == "1") {
                                                _onImageButtonPressed(
                                                    ImageSource.camera, 6,model,
                                                    context: context);
                                              } else if (value != null &&
                                                  value == "2") {
                                                _onImageButtonPressed(
                                                    ImageSource.gallery, 6,model,
                                                    context: context);
                                              }
                                            });
                                          },
                                          child: _imageFile6 != null
                                              ? Platform.isAndroid
                                                  ? FutureBuilder<void>(
                                                      future:
                                                          retrieveLostData(6,model),
                                                      builder: (BuildContext
                                                              context,
                                                          AsyncSnapshot<void>
                                                              snapshot) {
                                                        switch (snapshot
                                                            .connectionState) {
                                                          case ConnectionState
                                                              .none:
                                                          case ConnectionState
                                                              .waiting:
                                                          case ConnectionState
                                                              .done:
                                                            return Container(
                                                              child: Image.file(
                                                                  _imageFile6),
                                                            );
                                                          default:
                                                            return Container(
                                                                color: Colors
                                                                    .grey[300],
                                                                child: Center(
                                                                  child: Icon(
                                                                      Icons
                                                                          .add),
                                                                ));
                                                        }
                                                      },
                                                    )
                                                  : Container(
                                                      child: Image.file(
                                                          _imageFile6),
                                                    )
                                              : Container(
                                                  color: Colors.grey[300],
                                                  child: Center(
                                                    child: Icon(Icons.add),
                                                  )),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        model.imagesValidate
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: double.infinity,
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('images_error'),
                                    style: TextStyle(
                                        color: Colors.red[700], fontSize: 13),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            AppLocalizations.of(context).translate('details'),
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.white,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[300],
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)
                                        .translate('title'),
                                    errorText: model.titleValidate
                                        ? null
                                        : AppLocalizations.of(context)
                                            .translate('empty_error'),
                                    hintStyle: TextStyle(color: Colors.black87),
                                  ),
                                ),
                                InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(ress),
                                        Icon(Icons.arrow_forward_ios)
                                      ],
                                    ),
                                  ),
                                  onTap: () async {
                                    AddCategories res = await Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                new CategoriesTagsSelectionScreen(
                                                    widget.type == 1
                                                        ? model
                                                            .productOrService
                                                            .data
                                                            .productCategories
                                                        : model
                                                            .productOrService
                                                            .data
                                                            .serviceCategories)));

                                    if (res != null) {
                                      setState(() {
                                        if (res.tags.length > 0)
                                          model.catValidate = true;
                                        ress = res.tags.toString();
                                        tagsId = res.ids;
                                      });
                                    }
                                  },
                                ),
                                model.catValidate
                                    ? Container()
                                    : Container(
                                        width: double.infinity,
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate('list_error'),
                                          style: TextStyle(
                                              color: Colors.red[700],
                                              fontSize: 13),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                Divider(
                                  color: Colors.grey[900],
                                ),
                                TextFormField(
                                  controller: _descController,
                                  decoration: InputDecoration(
                                    errorText: model.descValidate
                                        ? null
                                        : AppLocalizations.of(context)
                                            .translate('desc_error'),
                                    hintText: AppLocalizations.of(context)
                                        .translate('description'),
                                    hintStyle: TextStyle(color: Colors.black87),
                                  ),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)
                                        .translate('price'),
                                    errorText: model.priceValidate
                                        ? null
                                        : AppLocalizations.of(context)
                                            .translate('empty_error'),
                                    hintStyle: TextStyle(color: Colors.black87),
                                  ),
                                  controller: _priceController,
                                ),
                                TextFormField(
                                  controller: _discountController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)
                                          .translate('discount'),
                                      hintStyle:
                                          TextStyle(color: Colors.black87),
                                      suffixIcon: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 16.0),
                                        child: Container(child: Text("%")),
                                      )),
                                ),
                              ],
                            )),
                        model.state == ViewState.Busy
                            ? Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: CircularProgressIndicator(
                                      backgroundColor: Colors.lightBlue,
                                    ),
                                ),
                              ),
                            )
                            : Container(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0, horizontal: 32),
                                  child: RaisedButton(
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('add'),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      if (model.addValidation(
                                          _nameController.text.trim(),
                                          _descController.text.trim(),
                                          _priceController.text.trim(),
                                          tagsId,
                                          _imageFile2,
                                          _imageFile3,
                                          _imageFile4,
                                          _imageFile5,
                                          _imageFile6)) {
                                        AddProductResponse response =
                                            await addProduct(model);
                                        if (response != null &&
                                            response.data != null &&
                                            response.data.productOrService !=
                                                null) {
                                          showToast("added_successfully",
                                              Colors.green);
                                        } else if (response != null &&
                                            !response.status) {
                                          showToast(response.errors.toString(),
                                              Colors.red);
                                        }
                                      }
                                    },
                                    color: Colors.lightBlueAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
                              ),
                      ]),
                    )
                  : model.state == ViewState.Idle
                      ? Container(
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
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.lightBlue,
                          ),
                        );
            }));
  }

  refreshScreen(AddProductOrServiceViewModel model) {
    model.prepAddProductService(locator<AppLanguage>().appLocal.languageCode);
  }

  Future<AddProductResponse> addProduct(AddProductOrServiceViewModel model) {
    return model.addProductOrService(
        locator<AppLanguage>().appLocal.languageCode,
        _nameController.text.trim(),
        _descController.text.trim(),
        tagsId,
        _priceController.text.trim(),
        _discountController.text.trim(),
        _imageFile2,
        _imageFile3,
        _imageFile4,
        _imageFile5,
        _imageFile6);
  }

  void _onImageButtonPressed(ImageSource source, int imageNum,AddProductOrServiceViewModel model,
      {BuildContext context}) async {
    {
      try {
        ImagePicker _picker = ImagePicker();
        PickedFile pickedFile = await _picker.getImage(
          maxHeight: 1024,
          maxWidth: 1024,
          source: source,
          imageQuality: 50,
        );
        if (pickedFile != null) {
          model.imagesValidate=true;
          setState(() {
            if (imageNum == 2) {
              _imageFile2 = File(pickedFile.path);

            } else if (imageNum == 3) {
              _imageFile3 = File(pickedFile.path);
            } else if (imageNum == 4) {
              _imageFile4 = File(pickedFile.path);
            } else if (imageNum == 5) {
              _imageFile5 = File(pickedFile.path);
            } else if (imageNum == 6) {
              _imageFile6 = File(pickedFile.path);
            }
          });
        }
      } catch (e) {
        _pickImageError = e;
      }
    }
  }

  Future<void> retrieveLostData(int imageNum,AddProductOrServiceViewModel model) async {
    ImagePicker _picker = ImagePicker();
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      model.imagesValidate=true;
      setState(() {
        if (imageNum == 2) {
          _imageFile2 = File(response.file.path);
        } else if (imageNum == 3) {
          _imageFile3 = File(response.file.path);
        } else if (imageNum == 4) {
          _imageFile4 = File(response.file.path);
        } else if (imageNum == 5) {
          _imageFile5 = File(response.file.path);
        } else if (imageNum == 6) {
          _imageFile6 = File(response.file.path);
        }
      });
    } else {
      _retrieveDataError = response.exception.code;
    }
  }
}
