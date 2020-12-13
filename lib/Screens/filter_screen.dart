import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:himaka/Models/prep_filter.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/ViewModels/filter_view_model.dart';
import 'package:himaka/services/base_view.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/AppLanguage.dart';
import 'package:himaka/utils/app_localizations.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;
import 'package:himaka/utils/filter_selections.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'categories_tags_selection_screen.dart';

class FilterScreen extends StatefulWidget {
  final int type;

  FilterScreen(this.type);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

enum FilterType { isNew, isUsed }

class _FilterScreenState extends State<FilterScreen> {
  int tag = 1;
  List<String> tags = [];
  List<int> isChecked = [];
  FilterType _character = FilterType.isNew;

  @override
  Widget build(BuildContext context) {
    return BaseView<FilterViewModel>(
        onModelReady: (model) {
          model.type = widget.type;
          refreshScreen(model);
        },
        builder: (context, model, child) => LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    AppLocalizations.of(context).translate('filter'),
                    style: TextStyle(color: Colors.grey[900]),
                  ),
                  elevation: 0.0,
                  iconTheme: IconThemeData(
                    color: Colors.grey[900], //change your color here
                  ),
                  backgroundColor: Color(0xFFf5f5f5),
                  // actions: [
                  //   Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Icon(
                  //       Icons.refresh,
                  //       color: Colors.grey[900],
                  //     ),
                  //   )
                  // ],
                ),
                backgroundColor: Color(0xFFf5f5f5),
                body: model.prepFilterResponse != null
                    ? ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('price'),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(model
                                              .prepFilterResponse.data.minPrice
                                              .toString() +
                                          ' - ' +
                                          model.prepFilterResponse.data.maxPrice
                                              .toString()),
                                    ],
                                  ),
                                ),
                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    overlayColor: Colors.black,
                                    activeTickMarkColor: Colors.white,
                                    activeTrackColor: Colors.orange,
                                    inactiveTrackColor: Colors.white,
                                    //trackHeight: 8.0,
                                    thumbColor: Colors.black,
                                    trackHeight: 8.0,
                                    valueIndicatorColor: Colors.orange,
                                  ),
                                  child: frs.RangeSlider(
                                    min: model.prepFilterResponse.data.minPrice
                                        .toDouble(),
                                    max: model.prepFilterResponse.data.maxPrice
                                        .toDouble(),
                                    lowerValue: model.lowerValue,
                                    upperValue: model.upperValue,
                                    divisions: 10,
                                    showValueIndicator: true,
                                    valueIndicatorMaxDecimals: 1,
                                    onChanged: (double newLowerValue,
                                        double newUpperValue) {
                                      setState(() {
                                        model.lowerValue = newLowerValue;
                                        model.upperValue = newUpperValue;
                                      });
                                    },
                                    onChangeStart: (double startLowerValue,
                                        double startUpperValue) {
                                      print(
                                          'Started with values: $startLowerValue and $startUpperValue');
                                    },
                                    onChangeEnd: (double newLowerValue,
                                        double newUpperValue) {
                                      print(
                                          'Ended with values: $newLowerValue and $newUpperValue');
                                    },
                                  ),
                                ),
                                Divider(
                                  color: Colors.black,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0, right: 8.0),
                                  child: Container(
                                    width: double.infinity,
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('star_rating'),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: 5,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 8,
                                          ),
                                          SmoothStarRating(
                                              allowHalfRating: false,
                                              // starCount: 5,
                                              rating: index == 0
                                                  ? 5
                                                  : index == 1
                                                      ? 4
                                                      : index == 2
                                                          ? 3
                                                          : index == 3 ? 2 : 1,
                                              size: 20.0,
                                              isReadOnly: true,
                                              filledIconData: Icons.star,
                                              color: Colors.deepOrangeAccent,
                                              borderColor: Colors.black38,
                                              spacing: 0.0),
                                          Expanded(
                                            child: Align(
                                              alignment: locator<AppLanguage>()
                                                          .appLocal
                                                          .languageCode ==
                                                      'en'
                                                  ? Alignment.centerRight
                                                  : Alignment.centerLeft,
                                              child: Checkbox(
                                                value:
                                                    isChecked.contains(index),
                                                onChanged: (value) {
                                                  if (value) {
                                                    setState(() {
                                                      isChecked.add(index);
                                                    });
                                                  } else {
                                                    setState(() {
                                                      isChecked.remove(index);
                                                    });
                                                  }
                                                },
                                                checkColor: Colors.blue,
                                                focusColor: Colors.blue,
                                                // color of tick Mark
                                                activeColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                        ],
                                      );
                                    }),
                                Divider(
                                  color: Colors.black,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0, right: 8.0),
                                  child: Container(
                                    width: double.infinity,
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('type'),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(AppLocalizations.of(context)
                                          .translate('new')),
                                      leading: Radio(
                                        activeColor: Colors.deepOrangeAccent,
                                        value: FilterType.isNew,
                                        groupValue: _character,
                                        onChanged: (FilterType value) {
                                          setState(() {
                                            _character = value;
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(AppLocalizations.of(context)
                                          .translate('used')),
                                      leading: Radio(
                                        activeColor: Colors.deepOrangeAccent,
                                        value: FilterType.isUsed,
                                        groupValue: _character,
                                        onChanged: (FilterType value) {
                                          setState(() {
                                            _character = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.black,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0, right: 8.0),
                                  child: Container(
                                    width: double.infinity,
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('categories'),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                ListView(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.all(5),
                                  children: <Widget>[
                                    Content(
                                      child: ChipsChoice<String>.multiple(
                                        value: tags,
                                        options: ChipsChoiceOption.listFrom<
                                            String, MainCategory>(
                                          source: model.prepFilterResponse.data
                                              .mainCategories,
                                          value: (i, v) => v.name!=null?v.name:"name",
                                          label: (i, v) => v.name!=null?v.name:"name",
                                        ),
                                        onChanged: (val) {
                                          setState(() {
                                            if (val.length > 1) {
                                              tags = [val[val.length - 1]];
                                            } else {
                                              tags = val;
                                            }
                                          });
                                        },
                                        isWrapped: true,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 32),
                                    child: RaisedButton(
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate('done'),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        FilterSelections filter;
                                        if (tags.length == 0) {
                                          filter = FilterSelections(
                                              model.lowerValue,
                                              model.upperValue,
                                              "",
                                              isChecked,
                                              _character == FilterType.isNew
                                                  ? 0
                                                  : 1);
                                        } else {
                                          filter = FilterSelections(
                                              model.lowerValue,
                                              model.upperValue,
                                              model.getCatId(
                                                  model.prepFilterResponse.data
                                                      .mainCategories,
                                                  tags[0]),
                                              isChecked,
                                              _character == FilterType.isNew
                                                  ? 0
                                                  : 1);
                                        }
                                        Navigator.of(context).pop(filter);
                                      },
                                      color: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
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

  refreshScreen(FilterViewModel model) {
    model.prepFilter(locator<AppLanguage>().appLocal.languageCode);
  }
}
