import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_101/Components/post.dart';
import 'package:flutter_101/Firebase/firestore.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:random_color/random_color.dart';
import '../GStyle.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Asset> _images = [];
  String _error = "";

  Future<void> loadAssets() async {
    setState(() {
      _images = [];
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 3,
      );
      print('resultList -------- $resultList');
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      _images = resultList;
      if (error == null) _error = 'No Error Dectected';
    });
  }

  void makePost(client) async {
    try {
      var multipartFiles = _images.map((image) async {
        ByteData byteData = await image.getByteData();
        List<int> imageData = byteData.buffer.asUint8List();
        return MultipartFile.fromBytes(
          'photo',
          imageData,
          filename: 'some-file-name.jpg',
          contentType: MediaType("image", "jpg"),
        );
      });

      var images = await Future.wait(multipartFiles);
      Map<String, dynamic> variables = {
        "images": images,
        "caption": "adel ak",
      };
      print('variables --------- $variables');

      createPost(client: client, variables: variables);
    } catch (error) {
      setState(() {
        _error = error;
      });
    }
  }

  Widget buildGridView() {
    if (_images != null)
      return GridView.count(
        crossAxisCount: 3,
        children: List.generate(_images.length, (index) {
          Asset asset = _images[index];
          return AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          );
        }),
      );
    else
      return Container(color: Colors.white);
  }

  @override
  Widget build(BuildContext ctx) {
    QueryOptions options = QueryOptions(document: gql("""
      {
        getPosts
      }
    """), variables: {});

    return Scaffold(
      backgroundColor: Gs().primaryColor,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Gs().secondaryColor,
        flexibleSpace: Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          width: 60,
          height: 60,
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, 'profile');
            },
            child: Hero(
              tag: 'dp',
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://i1.sndcdn.com/avatars-000587714706-vjdrog-t240x240.jpg'),
              ),
            ),
          ),
        ),
      ),
      body: Query(
        options: options,
        builder: (QueryResult res, {FetchMore fetchMore, Refetch refetch}) {
          if (res.isLoading)
            return Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Gs().textColor),
            ));

          return RefreshIndicator(
              color: Gs().textColor,
              onRefresh: () => refetch(),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: res.data['getPosts'].length,
                  itemBuilder: (context, index) {
                    String caption = res.data['getPosts'][index]['captain'];
                    List<dynamic> images =
                        res.data['getPosts'][index]['images'];

                    return PostCard(
                      images: images,
                      caption: caption,
                    );
                  }));
        },
      ),
    );
  }
}
