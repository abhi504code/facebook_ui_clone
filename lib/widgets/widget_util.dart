
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fb_responsive_ui/config/palette.dart';
import 'package:flutter/material.dart';

Widget createProfileAvatar(bool isActive, String imageUrl){
    return Stack(
        children: [
            CircleAvatar(backgroundColor: Colors.grey[200],radius: 20.0, backgroundImage: CachedNetworkImageProvider(imageUrl)),
            isActive?Positioned(
                bottom:3.0,
                right: 0.0,
                child: Container(
                    height: 15.0,
                    width: 15.0,
                    decoration: BoxDecoration(
                        color: Palette.online,
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 2.0,
                            color: Colors.white
                        )
                    ),
                ),):Container()
        ]
    );

}