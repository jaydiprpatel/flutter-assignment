import 'package:Assignment/configuration.dart';
import 'package:Assignment/model/user_dto.dart';
import 'package:Assignment/progress_widget.dart';
import 'package:Assignment/screens/movie_detail_screen.dart';
import 'package:Assignment/services/now_playing_presenter.dart';
import 'package:Assignment/services/toprated_presenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TopRatedMovie extends StatelessWidget {
  TopRatedMovie();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: new TopRatedMovieChild());
  }
}

class TopRatedMovieChild extends StatefulWidget {
  TopRatedMovieChild({Key key}) : super(key: key);

  @override
  _TopRatedMovieState createState() => new _TopRatedMovieState();
}

class _TopRatedMovieState extends State<TopRatedMovieChild>
    with WidgetsBindingObserver
    implements TopRatedListListener {
  TopRatedListPresenter _moviesListPresenter;
  List<Results> _list = new List();
  bool isLoading = false;
  bool buttonCancle = true;
  TextEditingController textSearch = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _moviesListPresenter = new TopRatedListPresenter(this);
    isLoading = true;
    _moviesListPresenter.reqUserList();
  }

  void filterSearchResults(String query) {
    List<Results> dummySearchList = List<Results>();
    dummySearchList.addAll(_list);
    if(query.isNotEmpty) {
      List<Results> dummyListData = List<Results>();
      dummySearchList.forEach((item) {
        if(item.title.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        _list.clear();
        _list.addAll(dummyListData);
      });
      return;
    } else if (query == null || query == "") {
      _moviesListPresenter.reqUserList();
      isLoading = true;
      setState(() {
      });
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: isLoading
            ? Container(
          height: MediaQuery.of(context).size.height,
          child: showProgress(),
        )
            : showMovieList(),
      ),
    );
  }

  showMovieList() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Container(
          height: 60,
          color: appColor,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            margin: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Icon(Icons.search),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search",
                      ),
                      onChanged: filterSearchResults,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _moviesListPresenter.reqUserList();
                    isLoading = true;
                    setState(() {
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(Icons.cancel),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: appColor,
          child: Column(
            children: <Widget>[
              Container(
                color: appColor,
                height: MediaQuery.of(context).size.height - 144,
                child: getList1(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getList1() {
    Widget widget;
    if (isLoading == true) {
      widget = showProgress();
    } else {
      ListView myList = ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                movieDetails(_list[index]);
              },
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Image.network(_list != null
                              ? "https://image.tmdb.org/t/p/w342" +
                              _list[index].posterPath
                              : ""),
                          height: 130,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Wrap(
                          children: <Widget>[
                            Container(
//                              height: 130,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width - 102,
                                    alignment: Alignment.topLeft,
                                    child: AutoSizeText(
                                      _list != null ? _list[index].title : "",
                                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                    ),
                                  ),
                                  SizedBox(height: 7),
                                  Wrap(
                                    children: <Widget>[
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width - 102,
                                        child: AutoSizeText(
                                          _list != null ? _list[index].overview : "",
                                          style: TextStyle(fontSize: 15.0),
                                          maxLines: 5,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      height: 0.5,
                      color: colorBlack,
                    ),
                  ],
                ),
              ),
            );
          });
      return myList;
    }
  }

  void movieDetails(dto) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (BuildContext context) => new MovieDetailsView(dto)),
    );
  }

  @override
  void showList(List<Object> listItem) {
    // TODO: implement showList
    if (listItem != null) {
      isLoading = false;
      _list = listItem;
    }
    setState(() {});
  }

}
