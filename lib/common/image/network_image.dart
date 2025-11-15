// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hicoach_coach/common/effects/shimmer.dart';


class TCachedNetworkImage extends StatelessWidget {
  final String profileURL;
  final double height;
  final double width;
  final BoxFit boxFit;
  final double radius;
  final Function()? onTap;
  const TCachedNetworkImage({
    super.key,
    required this.profileURL,
    required this.height,
    required this.width,
    this.boxFit = BoxFit.cover,
    this.radius = 100,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CachedNetworkImage(
        imageUrl: profileURL,
        fit: boxFit,
        height: height,
        width: width,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            TShimmerEffect(
          height: height,
          width: width,
          radius: radius,
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
