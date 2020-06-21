import 'package:Assignment/configuration.dart';
import 'package:Assignment/model/user_dto.dart';
import 'package:Assignment/progress_widget.dart';
import 'package:Assignment/screens/movie_detail_screen.dart';
import 'package:Assignment/services/now_playing_presenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MoviesListView extends StatelessWidget {
  MoviesListView();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: new MoviesListViewChild());
  }
}

class MoviesListViewChild extends StatefulWidget {
  MoviesListViewChild({Key key}) : super(key: key);

  @override
  _MoviesListViewState createState() => new _MoviesListViewState();
}

class _MoviesListViewState extends State<MoviesListViewChild>
    with WidgetsBindingObserver
    implements MoviesListListener {
  MoviesListPresenter _moviesListPresenter;
  List<Results> _list = new List();
  bool isLoading = false;
  bool buttonCancle = true;
  TextEditingController textSearch = new TextEditingController();
  var items = List<Results>();

  @override
  void initState() {
    super.initState();
    _moviesListPresenter = new MoviesListPresenter(this);
    _moviesListPresenter.reqUserList();
    isLoading = true;
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
      body: isLoading
          ? Container(
              child: showProgress(),
            )
          : showMovieList(),
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
                        Container(
                          height: 130,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  _list != null ? _list[index].title : "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 5,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height:7),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 100,
                                height: 100.0,
                                child: AutoSizeText(
                                  _list != null ? _list[index].overview : "",
                                  style: TextStyle(fontSize: 15.0),
                                  maxLines: 5,
                                ),
                              ),

                            ],
                          ),
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
