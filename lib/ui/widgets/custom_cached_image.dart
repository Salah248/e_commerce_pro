import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_pro/resources/color_manager.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
  });
  final String? imageUrl;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CachedNetworkImage(
        width: width,
        height: height,
        imageUrl: (imageUrl == null || imageUrl!.isEmpty)
            ? 'https://static.thenounproject.com/png/504708-200.png'
            : imageUrl!,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) {
          log('error: $error');
          return const Icon(Icons.error, color: Colors.red);
        },
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(color: ColorManager.primaryColor),
        ),
      ),
    );
  }
}
