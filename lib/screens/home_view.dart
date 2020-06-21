import 'package:Assignment/configuration.dart';
import 'package:Assignment/screens/nowplaying_list_view.dart';
import 'package:Assignment/screens/toprated_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  int _page = 0;

  Home(this._page);

  @override
  _HomeState createState() => _HomeState(_page);
}

class _HomeState extends State<Home> {
  int _page = 0;
  bool nowPlayingEnable = true, topRatedEnable = false;

  bool isExist = false;
  bool isExistNow = false;

  _HomeState(this._page);

  @override
  initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true)
          ..init(context);
    return Container(child: getMainView());
  }

  Widget getMainView() {
    return Container(
        child: Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          Container(
            child: Expanded(
              flex: 9,
              child: getcontainer(_page),
            ),
          ),

            bottomList(),
        ],
      ),
    ));
  }

  Widget bottomList() {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1, color: colorGrey),
          ),
          color: colorYellow,
        ),
//        color: colorWhite,
        child: Row(
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () {
                  _page = 0;
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 5, top: 7),
                  width: 65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(bottom: 5),
                        child: nowPlayingEnable
                            ? Image.asset(
                                "assets/video.png",
                                color: colorBlack,
                                height: 27,
                              )
                            : Image.asset(
                                "assets/video.png",
                                color: Colors.grey,
                                height: 27,
                              ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: nowPlayingEnable
                            ? Text("Now Playing",
                                textAlign: TextAlign.left,
                                style: new TextStyle(
                                    fontSize: 12, color: colorBlack))
                            : Text("Now Playing",
                                textAlign: TextAlign.left,
                                style: new TextStyle(
                                    fontSize: 12, color: colorGrey)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  _page = 1;
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(left: 15, right: 5),
                  width: 65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(bottom: 5),
                        child: topRatedEnable
                            ? Image.asset(
                                "assets/star.png",
                                color: colorBlack,
                                height: 27,
                              )
                            : Image.asset(
                                "assets/star.png",
                                color: colorGrey,
                                height: 27,
                              ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: topRatedEnable
                            ? Text("Top Rated",
                                textAlign: TextAlign.left,
                                style: new TextStyle(
                                    fontSize: 12, color: colorBlack))
                            : Text("Top Rated",
                                textAlign: TextAlign.left,
                                style: new TextStyle(
                                    fontSize: 12, color: colorGrey)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getcontainer(int pos) {
    Widget widget;
    if (pos == 0) {
      widget = MoviesListView();
      nowPlayingEnable = true;
      topRatedEnable = false;
    } else if (pos == 1) {
      widget = TopRatedMovie();
      topRatedEnable = true;
      nowPlayingEnable = false;
    }
    setState(() {});
    return widget;
  }
}
