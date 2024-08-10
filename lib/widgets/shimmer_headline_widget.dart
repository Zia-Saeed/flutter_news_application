import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHeadLineWidget extends StatefulWidget {
  const ShimmerHeadLineWidget({super.key});

  @override
  State<ShimmerHeadLineWidget> createState() => _ShimmerHeadLineWidgetState();
}

class _ShimmerHeadLineWidgetState extends State<ShimmerHeadLineWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FancyShimmerImage(
            imageUrl:
                "https://img.freepik.com/premium-vector/news-headlines-background-with-earth-planet_1017-12632.jpg",
            boxFit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ),
          const SizedBox(
            height: 20,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 40,
              width: double.infinity,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 15,
              width: 70,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 20,
              width: double.infinity,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 20,
              width: 90,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 15,
              width: 70,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 20,
              width: 120,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
