import 'dart:convert';
import 'package:http/http.dart';
import '../model/post_model.dart';

class Network {
  static String BASE = 'jsonplaceholder.typicode.com';
  static Map<String, String> headers = {
    'Content-type': 'application/json; charset=UTF-8'
  };
  /* Http Apis */

  static String apiLIST = '/posts';
  static String apiCREATE = '/posts';
  static String apiUPDATE = '/posts/'; //{id}
  static String apiDELETE = '/posts/'; //{id}

  /* Http Requests */

  static Future<String?> GET (String api, Map<String, String> params) async{
    var uri = Uri.https(BASE, api, params);
    var response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> POST (String api, Map<String, String> params) async{
    var uri = Uri.https(BASE, api);
    var response = await post(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PUT (String api, Map<String, String> params) async{
    var uri = Uri.https(BASE, api);
    var response = await put(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 202) {
      return response.body;
    }
    return null;
  }

  static Future<String?> DEL (String api, Map<String, String> params) async{
    var uri = Uri.https(BASE, api, params);
    var response = await delete(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  /* Http Params */
  static Map<String, String> paramsEmpty() {
    Map<String,String> params = {};
    return params;
  }

  static Map<String, String> paramsCreate(Post post) {
    Map<String,String> params = {};
    params.addAll({
      'title' : post.title!,
      'body' : post.body!,
      'userId' : post.userId.toString()
    });
    return params;
  }

  static Map<String, String> paramsUpdate(Post post) {
    Map<String,String> params = {};
    params.addAll({
      'id' : post.id.toString(),
      'title' : post.title!,
      'body' : post.body!,
      'userId' : post.userId.toString()
    });
    return params;
  }
/* Http Parsing */
static List<Post> parsePostList(String response){
  // print(response);
  dynamic json = jsonDecode(response);

  List list = [1, 2, 3];
  var a = list.map((e) {
    return "iuh";
  }).toList();
  print(a.toList());

  var data = List<Post>.from(json.map((x) {
    return Post.fromJson(x);
  }));
  return data;
}

}