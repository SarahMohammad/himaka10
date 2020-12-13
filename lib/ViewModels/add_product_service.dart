import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:himaka/Screens/product_service_construct_screen.dart';
import 'package:himaka/utils/app_localizations.dart';

class AddProductService extends StatefulWidget {
  @override
  _AddProductServiceState createState() => _AddProductServiceState();
}

class _AddProductServiceState extends State<AddProductService>
    with TickerProviderStateMixin {
  TabController _controller;

  // this will control the animation when a button changes from an off state to an on state
  AnimationController _animationControllerOn;

  // this will control the animation when a button changes from an on state to an off state
  AnimationController _animationControllerOff;

  // this will give the background color values of a button when it changes to an on state
  Animation _colorTweenBackgroundOn;
  Animation _colorTweenBackgroundOff;

  // this will give the foreground color values of a button when it changes to an on state
  Animation _colorTweenForegroundOn;
  Animation _colorTweenForegroundOff;

  // when swiping, the _controller.index value only changes after the animation, therefore, we need this to trigger the animations and save the current index
  int _currentIndex = 0;

  // saves the previous active tab
  int _prevControllerIndex = 0;

  // saves the value of the tab animation. For example, if one is between the 1st and the 2nd tab, this value will be 0.5
  double _aniValue = 0.0;

  // saves the previous value of the tab animation. It's used to figure the direction of the animation
  double _prevAniValue = 0.0;

  // these will be our tab icons. You can use whatever you like for the content of your buttons
  List _titles = ['Pending', 'Finished'];

  // active button's foreground color
  Color _foregroundOn = Colors.white;
  Color _foregroundOff = Colors.white;

  // active button's background color
  Color _backgroundOn = Colors.lightBlueAccent;
  Color _backgroundOff = Colors.grey[700];

  // scroll controller for the TabBar
  ScrollController _scrollController = new ScrollController();

  // this will save the keys for each Tab in the Tab Bar, so we can retrieve their position and size for the scroll controller
  List _keys = [];

  // regist if the the button was tapped
  bool _buttonTap = false;

  @override
  void initState() {
    super.initState();

    for (int index = 0; index < _titles.length; index++) {
      // create a GlobalKey for each Tab
      _keys.add(new GlobalKey());
    }

    // this creates the controller with 6 tabs (in our case)
    _controller = TabController(vsync: this, length: _titles.length);
    // this will execute the function every time there's a swipe animation
    _controller.animation.addListener(_handleTabAnimation);
    // this will execute the function every time the _controller.index value changes
    _controller.addListener(_handleTabChange);

    _animationControllerOff =
        AnimationController(vsync: this, duration: Duration(milliseconds: 75));
    // so the inactive buttons start in their "final" state (color)
    _animationControllerOff.value = 1.0;
    _colorTweenBackgroundOff =
        ColorTween(begin: _backgroundOn, end: _backgroundOff)
            .animate(_animationControllerOff);
    _colorTweenForegroundOff =
        ColorTween(begin: _foregroundOn, end: _foregroundOff)
            .animate(_animationControllerOff);

    _animationControllerOn =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    // so the inactive buttons start in their "final" state (color)
    _animationControllerOn.value = 1.0;
    _colorTweenBackgroundOn =
        ColorTween(begin: _backgroundOff, end: _backgroundOn)
            .animate(_animationControllerOn);
    _colorTweenForegroundOn =
        ColorTween(begin: _foregroundOff, end: _foregroundOn)
            .animate(_animationControllerOn);
  }

  @override
  Widget build(BuildContext context) {
    _titles = [
      AppLocalizations.of(
          context)
          .translate(
          'service'),
      AppLocalizations.of(
          context)
          .translate(
          'product')
    ];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey[900], //change your color here
        ),
        title: Text('Add a product' , style: TextStyle(color: Colors.grey[900]),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
        backgroundColor: Colors.white,
        body: Column(children: <Widget>[
          // this is the TabBar
          Container(
              height: 49.0,
              // this generates our tabs buttons
              child: Center(
                child: ListView.builder(
                    shrinkWrap: true,
                    // this gives the TabBar a bounce effect when scrolling farther than it's size
                    controller: _scrollController,
                    // make the list horizontal
                    scrollDirection: Axis.horizontal,
                    itemCount: _titles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        // each button's key
                          key: _keys[index],
                          // padding for the buttons
                          padding: EdgeInsets.all(2.0),
                          child: ButtonTheme(

                              child: AnimatedBuilder(
                                animation: _colorTweenBackgroundOn,
                                builder: (context, child) => ButtonTheme(
                                  minWidth: MediaQuery.of(context).size.width/2 - 20,
                                  child: FlatButton(

                                    // get the color of the button's background (dependent of its state)
                                      color: _getBackgroundColor(index),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:  index == 0 ? BorderRadius.only(
                                              bottomLeft: Radius.circular(20.0),
                                              topLeft: Radius.circular(20.0))

                                        : BorderRadius.only(
                                            bottomRight: Radius.circular(20.0),
                                            topRight: Radius.circular(20.0)),

//                                        side: BorderSide(color: Colors.red)
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _buttonTap = true;
                                          // trigger the controller to change between Tab Views
                                          _controller.animateTo(index);
                                          // set the current index
                                          _setCurrentIndex(index);
                                          // scroll to the tapped button (needed if we tap the active button and it's not on its position)
                                        });
                                      },
                                      child: Text(
                                        _titles[index], style: TextStyle(color: Colors.white),

                                      )),
                                ),
                              )));
                    }),
              )),
          Flexible(
            // this will host our Tab Views
              child: TabBarView(
                // and it is controlled by the controller
                controller: _controller,
                children: <Widget>[
                  new ProductServiceConstructScreen(2),
                  new ProductServiceConstructScreen(1),
                ],
              )),
        ]));
  }

  _handleTabAnimation() {
    // gets the value of the animation. For example, if one is between the 1st and the 2nd tab, this value will be 0.5
    _aniValue = _controller.animation.value;

    // if the button wasn't pressed, which means the user is swiping, and the amount swipped is less than 1 (this means that we're swiping through neighbor Tab Views)
    if (!_buttonTap && ((_aniValue - _prevAniValue).abs() < 1)) {
      // set the current tab index
      _setCurrentIndex(_aniValue.round());
    }

    // save the previous Animation Value
    _prevAniValue = _aniValue;
  }

  // runs when the displayed tab changes
  _handleTabChange() {
    // if a button was tapped, change the current index
    if (_buttonTap) _setCurrentIndex(_controller.index);

    // this resets the button tap
    if ((_controller.index == _prevControllerIndex) ||
        (_controller.index == _aniValue.round())) _buttonTap = false;

    // save the previous controller index
    _prevControllerIndex = _controller.index;
  }

  _setCurrentIndex(int index) {
    // if we're actually changing the index
    if (index != _currentIndex) {
      setState(() {
        // change the index
        _currentIndex = index;
      });

      // trigger the button animation
      _triggerAnimation();
      // scroll the TabBar to the correct position (if we have a scrollable bar)
//      _scrollTo(index);
    }
  }

  _triggerAnimation() {
    // reset the animations so they're ready to go
    _animationControllerOn.reset();
    _animationControllerOff.reset();

    // run the animations!
    _animationControllerOn.forward();
    _animationControllerOff.forward();
  }

  _getBackgroundColor(int index) {
    if (index == _currentIndex) {
      // if it's active button
      return _colorTweenBackgroundOn.value;
    } else if (index == _prevControllerIndex) {
      // if it's the previous active button
      return _colorTweenBackgroundOff.value;
    } else {
      // if the button is inactive
      return _backgroundOff;
    }
  }

  _getForegroundColor(int index) {
    // the same as the above
    if (index == _currentIndex) {
      return _colorTweenForegroundOn.value;
    } else if (index == _prevControllerIndex) {
      return _colorTweenForegroundOff.value;
    } else {
      return _foregroundOff;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}