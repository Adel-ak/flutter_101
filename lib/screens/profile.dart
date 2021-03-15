import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'package:interpolate/interpolate.dart';

import '../GStyle.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ScrollController _sc = ScrollController();

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        body: CustomScrollView(
      controller: _sc,
      slivers: [
        SliverAppBar(
          backgroundColor: Gs().secondaryColor,
          toolbarHeight: 60,
          expandedHeight: MediaQuery.of(context).size.height / 3.5,
          collapsedHeight: 60,
          pinned: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () => Navigator.pop(context),
            iconSize: 25,
          ),
          flexibleSpace: Center(
              child: AnimatedBuilder(
                  animation: _sc,
                  builder: (_, __) {
                    double screenWidth = MediaQuery.of(context).size.width;
                    double imageSize = 200.0 - _sc.offset;

                    Interpolate interpolateRight = Interpolate(
                      inputRange: [0, 150],
                      outputRange: [(screenWidth / 4), (screenWidth - 100)],
                      extrapolate: Extrapolate.clamp,
                    );

                    Interpolate interpolateBottom = Interpolate(
                      inputRange: [0, 150],
                      outputRange: [20, 5],
                      extrapolate: Extrapolate.clamp,
                    );

                    return Stack(
                      children: [
                        Positioned(
                            bottom: interpolateBottom.eval(_sc.offset),
                            right: interpolateRight.eval(_sc.offset),
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).padding.top),
                              width: imageSize < 50 ? 50 : imageSize,
                              height: imageSize < 50 ? 50 : imageSize,
                              child: Hero(
                                tag: 'dp',
                                child: TextButton(
                                  onPressed: () async {},
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://i1.sndcdn.com/avatars-000587714706-vjdrog-t240x240.jpg'),
                                  ),
                                ),
                              ),
                            )),
                      ],
                    );
                  })),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((_, index) {
          return Container(
            color: RandomColor().randomColor(),
            child: Center(
              child: Text('$index'),
            ),
          );
        }, childCount: 200)),
      ],
    ));
  }
}
