import 'package:flutter/material.dart';

class ImageSelector extends StatelessWidget {
  final List<ImageProvider> images;
  final int? activeIndex;
  final Color indicatorColor;
  final ValueChanged<int> onIndexChange;

  const ImageSelector({
    super.key,
    required this.images,
    required this.onIndexChange,
    required this.activeIndex,
    required this.indicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildItem,
      itemExtent: 86,
      itemCount: images.length,
    );
  }

  Widget? _buildItem(BuildContext context, int index) {
    bool active = activeIndex == index;
    Color color = active ? indicatorColor : Colors.transparent;
    ImageProvider image = images[index];
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onIndexChange(index),
      child: ImageDisplayItem(image: image, activeColor: color),
    );
  }
}

class ImageDisplayItem extends StatelessWidget {
  final ImageProvider image;
  final Color activeColor;

  const ImageDisplayItem({
    super.key,
    required this.image,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    BorderRadius radius = BorderRadius.circular(6);
    Border border = Border.all(color: activeColor, width: 2);
    return Row(
      spacing: 4,
      children: [
        buildIndicator(color: activeColor),
        Container(
          height: 80,
          width: 80,
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(borderRadius: radius, border: border),
          child: ClipRRect(
            borderRadius: radius,
            child: Image(
              image: image,
              width: 80,
              height: 80,
            ),
          ),
        ),
        buildIndicator(color: activeColor),
      ],
    );
  }

  Widget buildIndicator({Color? color}) {
    return Container(
        height: 80,
        width: 6,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
        ));
  }
}
