import 'package:cached_network_image/cached_network_image.dart';
import 'package:crm_new/services/api/apis.dart';
import 'package:flutter/material.dart';

class PhotoListTile extends StatelessWidget {
  final String image;
  const PhotoListTile({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 94,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: CachedNetworkImageProvider(baseUrl + image),
              fit: BoxFit.cover)),
    );
  }
}
