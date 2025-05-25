// lib/presentation/widgets/skeleton_loader.dart

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoader extends StatelessWidget {
  final double height;
  final double width;
  final BorderRadius borderRadius;

  const SkeletonLoader({
    Key? key,
    this.height = 16.0,
    this.width = double.infinity,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
