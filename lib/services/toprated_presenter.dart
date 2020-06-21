import 'dart:convert';
import 'package:Assignment/model/user_dto.dart';
import 'package:http/http.dart' as http;



class TopRatedListPresenter {
  TopRatedListListener _listListener;

  TopRatedListPresenter(this._listListener);

  reqUserList() async {

    var response2 = "";
    response2 = await http.get(
      "https://api.themoviedb.org/3/movie/top_rated?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    ).then((response) {
      if (response.statusCode == 200) {
        String data = response.body;
        response2 = data.toString();
        Map<String, dynamic> decoded = json.decode(response2);
        if (decoded != null) {
          final List itemList = decoded['results'];
          if (itemList.length != null) {
            if (itemList.length != 0) {
              List<Results> userlist = itemList
                  .map((itemRaw) => new Results.fromJson(itemRaw))
                  .toList();
              _listListener.showList(userlist);
            }
          }
        } else {
//          showToast(context, "Something Went wrong");
        }
      } else {
            (response) {
          print('Response from server is : ${response.body}');
        };
      }
    });
  }

}

abstract class TopRatedListListener {
  void showList(List<Object> listItem);
}
