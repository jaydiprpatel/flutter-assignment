import 'package:Assignment/configuration.dart';
import 'package:Assignment/model/user_dto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieDetailsView extends StatelessWidget {
  Results _results;

  MovieDetailsView(this._results);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: new MovieDetailsViewChild(_results));
  }
}

class MovieDetailsViewChild extends StatefulWidget {
  Results _results;

  MovieDetailsViewChild(this._results);

  @override
  _MovieDetailsViewState createState() =>
      new _MovieDetailsViewState(this._results);
}

class _MovieDetailsViewState extends State<MovieDetailsViewChild> {
  Results _list;

  _MovieDetailsViewState(this._list) {}

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showMovieDetail(),
    );
  }

  showMovieDetail() {
    return Column(
      children: <Widget>[
        Container(height: 17,color: appColor,),
        InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
//            margin: EdgeInsets.only(top: 7),
            padding: EdgeInsets.only(bottom: 10, top: 10),
            height: 50,
            color: appColor,
            child: Row(
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.arrow_back_ios, size: 30, color: colorGrey,),
                ),
                SizedBox(width: 5),
                Container(
                  child: Text("Back", style: TextStyle(color: colorGrey, fontSize: 20)),
                ),
              ],
            ),
          ),
        ),

        Container(
          height: MediaQuery.of(context).size.height - 67,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(_list != null
                      ? "https://image.tmdb.org/t/p/w342" + _list.posterPath
                      : ""),
                  fit: BoxFit.fill)),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(top: 10, left: 10),
              color: colorGrey.withOpacity(0.5),
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Text(
                      _list.title,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: colorWhite),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.calendar_today,
                            color: colorWhite,
                            size: 14,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _list.releaseDate,
                            style: TextStyle(fontSize: 15, color: colorWhite),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.star,
                            color: colorWhite,
                            size: 14,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _list.voteAverage.toString() + "%",
                            style: TextStyle(fontSize: 15, color: colorWhite),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _list.overview.toString(),
                      style: TextStyle(fontSize: 15, color: colorWhite),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
