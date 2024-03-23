import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../model/post_model.dart';
import '../service/http_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String id = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String load = '';
  bool? isLoading;
  var item = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.grey[100],
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.grey[400],
              height: 450,
              width: 350,
              child: ListView(
                  children: [
                    Stack(
                      children: [
                        ListView.builder(
                          itemCount: item.length,
                          itemBuilder: (ctx, index){
                            return itemHomePost(item[index]);
                          },
                        ),
                      ],
                    )
                  ],
              ),
            ),
            const SizedBox(height: 30),
            MaterialButton(
              height: 50,
              minWidth: 200,
              color: Colors.orangeAccent,
              onPressed: (){
                apiPostList();
              },
            ),
            const SizedBox(height: 10),
            MaterialButton(
              height: 50,
              minWidth: 200,
              color: Colors.greenAccent,
              onPressed: (){
                var post = Post(1, 'Asliddin', 'Ummatov', 1);
                apiPostCreate(post);
              },
            ),
            const SizedBox(height: 10),
            MaterialButton(
              height: 50,
              minWidth: 200,
              color: Colors.blueAccent,
              onPressed: (){
                var post = Post(1, 'Asliddin Best', 'Ummatov', 1);
                apiPostUpdate(post);
              },
            ),
            const SizedBox(height: 10),
            MaterialButton(
              height: 50,
              minWidth: 200,
              color: Colors.redAccent,
              onPressed: (){
                var post = Post(1, 'Asliddin Best', 'Ummatov', 1);
                apiPostDelete(post);
              },
            ),
            const SizedBox(height: 10),
            MaterialButton(
              height: 50,
              minWidth: 200,
              color: Colors.deepPurpleAccent,
              onPressed: (){
                // Navigator.pushNamed(context, SecondPage.id);
              },
            ),
          ],
        ),
      ),
    );
  }

  void apiPostList ()async{
    setState(() {
      isLoading = true;
    });
    var response = await Network.GET(Network.apiLIST, Network.paramsEmpty());
    if (response != null){
     setState(() {});
     isLoading = false;
     item = Network.parsePostList(response);
    }
  }

  void apiPostCreate (Post post){
    Network.POST(Network.apiCREATE, Network.paramsCreate(post)).then((response) => {
      load = response.toString(),
      setState(() {}),
    });
  }

  void apiPostUpdate (Post post){
    Network.PUT(Network.apiUPDATE+post.id.toString(), Network.paramsUpdate(post)).then((response) => {
      load = response.toString(),
      setState(() {}),
    });
  }

  void apiPostDelete (Post post){
    Network.DEL(Network.apiDELETE+post.id.toString(), Network.paramsEmpty()).then((response) => {
      load = response.toString(),
      setState(() {}),
    });
  }
  Widget itemHomePost (Post post){
    return Slidable(
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title!)
          ],
        ),
      ),
    );
  }
}
