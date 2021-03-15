import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../GStyle.dart';

// class PostCard extends StatefulWidget {
//   final List<dynamic> images;
//   final String caption;

//   PostCard({Key key, this.images, this.caption}) : super(key: key);

//   _PostCardState createState() => _PostCardState();
// }

class PostCard extends StatelessWidget {
  final List<dynamic> images;
  final String caption;

  PostCard({this.images, this.caption});

  @override
  Widget build(BuildContext ctx) {
    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 20),
        child: Column(
          children: [
            Stack(children: [
              MyCarouselSlider(
                images: images,
                caption: caption,
              ),
              UserInfo(),
            ]),
            // Container(
            //     child: Row(
            //   children: [
            //     IconButton(
            //         // thumb_up_outlined
            //         icon: Icon(
            //           Icons.thumb_up,
            //           color: Gs().secondaryColor,
            //         ),
            //         onPressed: () {})
            //   ],
            // )),
            Align(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    caption,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  )),
              alignment: Alignment.centerLeft,
            ),
          ],
        ));
  }
}

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Container(
          color: Colors.black26,
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://i1.sndcdn.com/avatars-000587714706-vjdrog-t240x240.jpg')),
              Divider(
                indent: 10,
              ),
              Text(
                "Adel ak",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ));
  }
}

class MyCarouselSlider extends StatefulWidget {
  final List<dynamic> images;
  final String caption;

  MyCarouselSlider({Key key, this.images, this.caption}) : super(key: key);

  @override
  _MyCarouselSliderState createState() => _MyCarouselSliderState();
}

class _MyCarouselSliderState extends State<MyCarouselSlider> {
  double _dotsIndicatorIndex = 0;

  void changeDotIndex(index) {
    setState(() {
      _dotsIndicatorIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
              onPageChanged: (index, _) => changeDotIndex(index / 1),
              viewportFraction: 1.0,
              aspectRatio: 1,
              pageSnapping: true,
              enableInfiniteScroll: false),
          itemCount: widget.images.length,
          itemBuilder: (_, index, __) => Container(
            child: Image.network(widget.images[index]),
            color: Colors.white30,
          ),
        ),
        Container(
            margin: EdgeInsets.only(bottom: 10),
            width: MediaQuery.of(context).size.width,
            color: Colors.black26,
            child: DotsIndicator(
                dotsCount: widget.images.length,
                position: _dotsIndicatorIndex,
                decorator: DotsDecorator(
                  color: Colors.black87, // Inactive color
                  activeColor: Gs().secondaryColor,
                ))),
      ],
    );
  }
}
