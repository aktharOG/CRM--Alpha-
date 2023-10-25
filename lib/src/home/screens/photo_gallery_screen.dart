import 'package:cached_network_image/cached_network_image.dart';
import 'package:crm_new/models/stages_model.dart';
import 'package:crm_new/services/api/apis.dart';
import 'package:crm_new/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class PhotoGalleryPage extends StatefulWidget {
  final List<ImageM> images;
  const PhotoGalleryPage({super.key, required this.images});

  @override
  State<PhotoGalleryPage> createState() => _PhotoGalleryPageState();
}

class _PhotoGalleryPageState extends State<PhotoGalleryPage> {
  int selectedIndex = 0;

  changeIndex(value) {
    selectedIndex = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: SafeArea(child: CustomAppBar(title: "Photo Gallery"))),
      body: SafeArea(
          child: Column(
        children: [
          AnimatedContainer(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    offset: Offset(2, 3), blurRadius: 5, color: Colors.grey)
              ],
            ),
            margin: const EdgeInsets.all(10),
            key: GlobalKey(),
            curve: Curves.bounceIn,
            duration: const Duration(milliseconds: 500),
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: baseUrl + widget.images[selectedIndex].image,
                height: 170,
                width: 170,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(2, 3), blurRadius: 5, color: Colors.grey)
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    children: widget.images
                        .asMap()
                        .entries
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                changeIndex(e.key);
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: baseUrl + e.value.image,
                                    height: 170,
                                    width: 170,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
