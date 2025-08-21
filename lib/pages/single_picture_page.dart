import 'package:aiflutter/widgets/window.dart';
import 'package:flutter/material.dart';
import 'package:nine_grid_view/nine_grid_view.dart';

import '../utils/models.dart';
import '../utils/utils.dart';

class SinglePicturePage extends StatefulWidget {
  const SinglePicturePage({super.key});

  @override
  State<SinglePicturePage> createState() => _SinglePicturePageState();
}

class _SinglePicturePageState extends State<SinglePicturePage> {
  List<ImageBean> imageList = [];

  @override
  void initState() {
    super.initState();
    imageList = Utils.getTestData();
  }

  Widget _buildItem(BuildContext context, int index) {
    int itemCount = 1;

    ImageBean imageBean = imageList[index];
    String url = imageBean.middlePath!;

    int? originalWidth;
    int? originalHeight;

    Image? bigImage;
    String? bigImageUrl;

    // Single picture display big picture.
    if (itemCount == 1) {
      // ImageBean imageBean = imageList[0];
      originalWidth = imageBean.originalWidth;
      originalHeight = imageBean.originalHeight;
      bigImage = Utils.getBigImage(imageBean.middlePath);
      bigImageUrl = imageBean.middlePath;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        NineGridView(
          margin: EdgeInsets.all(12),
          padding: EdgeInsets.all(5),
          space: 5,
          bigImageWidth: originalWidth,
          bigImageHeight: originalHeight,
          bigImage: bigImage,
          bigImageUrl: bigImageUrl,
          itemCount: itemCount,
          itemBuilder: (BuildContext context, int index) {
            return Utils.getWidget(url);
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WindowFrameWidget(child: buildC(context));
  }

  Widget buildC(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Single Picture'),
        centerTitle: true,
      ),
      body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: imageList.length,
          padding: EdgeInsets.all(0),
          itemBuilder: (BuildContext context, int index) {
            return _buildItem(context, index);
          }),
    );
  }
}
