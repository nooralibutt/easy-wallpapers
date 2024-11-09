import 'package:easy_wallpapers/src/models/color_filter_data.dart';
import 'package:flutter/material.dart';

class ColorFilterPreviewItem extends StatelessWidget {
  final ColorFilterData filter;
  final ValueChanged<ColorFilterData>? onTap;
  const ColorFilterPreviewItem(this.filter, {this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(filter),
      child: ColorFiltered(
        colorFilter: ColorFilter.matrix(filter.matrix),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://github.com/nooralibutt/easy-wallpapers/raw/master/assets/images/wallpapers/home_bg.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(
                  Radius.circular(20.0)), // Set rounded corner radius
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  color: Colors.black,
                  offset: Offset(1, 2),
                )
              ],
            ),
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 14,
              margin: const EdgeInsets.only(bottom: 15),
              color: Colors.blueGrey,
              alignment: Alignment.center,
              child: Text(
                filter.name,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
