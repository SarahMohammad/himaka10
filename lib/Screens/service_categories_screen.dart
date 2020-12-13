import 'package:flutter/material.dart';
import 'package:himaka/Screens/DetailsScreen/details_screen.dart';
import 'package:himaka/Screens/search_screen.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/ViewModels/get_categories_view_model.dart';
import 'package:himaka/services/base_view.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/AppLanguage.dart';
import 'package:himaka/utils/app_localizations.dart';

class ServiceCategoriesScreen extends StatefulWidget {
  final Function callback;

  ServiceCategoriesScreen(this.callback);

  @override
  _ServiceCategoriesScreenState createState() =>
      _ServiceCategoriesScreenState();
}

class _ServiceCategoriesScreenState extends State<ServiceCategoriesScreen> {
  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BaseView<GetCategoriesViewModel>(
        onModelReady: (model) {
          // model.type = widget.type;
          refreshScreen(model);
        },
        builder:
            (context, model, child) => LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
                  return Scaffold(
                    body: model.getCategoriesResponse != null
                        ? (model.getCategoriesResponse.data.mainCategories !=
                                    null &&
                                model.getCategoriesResponse.data.mainCategories
                                        .length >
                                    0)
                            ? Container(
                                height: screenSize.height,
                                width: screenSize.width,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: screenSize.height,
                                        child: ListView.builder(
                                          itemCount: model.getCategoriesResponse
                                              .data.mainCategories.length,
                                          itemBuilder: (context, index) {
                                            return LayoutBuilder(
                                              builder: (context, constraint) {
                                                double conHeight =
                                                    constraint.maxWidth * 0.8;
                                                double textHeight =
                                                    conHeight / 10;
                                                return InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      selectedCategory = index;
                                                      print('dddd');
                                                    });
                                                  },
                                                  child: Container(
                                                    height: conHeight,
                                                    width: constraint.maxWidth,
                                                    padding: EdgeInsets.all(8),
                                                    color: index ==
                                                            selectedCategory
                                                        ? Colors.white
                                                        : Colors.grey[200],
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
//                                Icon(
//                                  subcategory[index]['icon'],
//                                  size: textHeight * 3,
//                                  color: index == selectedCategory
//                                      ? Colors.lightBlueAccent
//                                      : Colors.grey,
//                                ),
                                                        SizedBox(
                                                          height: 7,
                                                        ),
                                                        Text(
                                                          model
                                                              .getCategoriesResponse
                                                              .data
                                                              .mainCategories[
                                                                  index]
                                                              .name,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: index ==
                                                                      selectedCategory
                                                                  ? Colors
                                                                      .lightBlueAccent
                                                                  : Colors
                                                                      .black,
                                                              fontSize:
                                                                  textHeight *
                                                                      1.5,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    (model
                                                    .getCategoriesResponse
                                                    .data
                                                    .mainCategories[
                                                        selectedCategory]
                                                    .subCategory !=
                                                null &&
                                            model
                                                    .getCategoriesResponse
                                                    .data
                                                    .mainCategories[
                                                        selectedCategory]
                                                    .subCategory
                                                    .length >
                                                0)
                                        ? Expanded(
                                            flex: 3,
                                            child: Container(
                                              height: screenSize.height,
                                              child: LayoutBuilder(
                                                builder: (context, constraint) {
                                                  return Container(
                                                    padding: EdgeInsets.all(8),
                                                    width: constraint.maxWidth,
                                                    height: screenSize.height,
                                                    child: GridView.builder(
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        childAspectRatio:
                                                            1 / 1.1,
                                                        crossAxisSpacing: 5,
                                                        mainAxisSpacing: 5,
                                                      ),
                                                      itemCount: model
                                                          .getCategoriesResponse
                                                          .data
                                                          .mainCategories[
                                                              selectedCategory]
                                                          .subCategory
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return LayoutBuilder(
                                                          builder:
                                                              (context, cons) {
                                                            return InkWell(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    new MaterialPageRoute(
                                                                        builder: (context) => new SearchScreen(
                                                                            widget
                                                                                .callback,
                                                                            model.getCategoriesResponse.data.mainCategories[selectedCategory].subCategory[index].name != null
                                                                                ? model.getCategoriesResponse.data.mainCategories[selectedCategory].subCategory[index].name
                                                                                : "sub category name",
                                                                            2,
                                                                            catId: model.getCategoriesResponse.data.mainCategories[selectedCategory].subCategory[index].id)));
                                                              },
                                                              child: GridTile(
                                                                child: Column(
                                                                  children: <
                                                                      Widget>[
                                                                    ClipRRect(
                                                                      child:
                                                                          Container(
                                                                        color: Colors
                                                                            .grey,
                                                                        child: model.getCategoriesResponse.data.mainCategories[selectedCategory].subCategory[index].image !=
                                                                                null
                                                                            ? Image.network(
                                                                                model.getCategoriesResponse.data.mainCategories[selectedCategory].subCategory[index].image.path,
                                                                                fit: BoxFit.contain,
                                                                                height: cons.maxHeight - 30,
                                                                              )
                                                                            : Image.asset(
                                                                                "images/logo.png",
                                                                                height: cons.maxHeight - 30,
                                                                                fit: BoxFit.contain,
                                                                              ),
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              40.0),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Flexible(
                                                                      child:
                                                                          Text(
                                                                        model
                                                                            .getCategoriesResponse
                                                                            .data
                                                                            .mainCategories[selectedCategory]
                                                                            .subCategory[index]
                                                                            .name,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          )
                                        : Expanded(
                                            flex: 3,
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                    AppLocalizations.of(context)
                                                        .translate('no_data')),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              )
                            : Center(
                                child: Text(AppLocalizations.of(context)
                                    .translate('no_data')),
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
                              ),
                  );
                }));
  }

  refreshScreen(GetCategoriesViewModel model) {
    model.getCategories(locator<AppLanguage>().appLocal.languageCode, 2);
  }
}
