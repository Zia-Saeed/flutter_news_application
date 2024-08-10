import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:image_api_create/screens/news_detail_screen.dart';

class NewsCard extends StatefulWidget {
  const NewsCard({
    super.key,
    required this.imageUrl,
    required this.url,
    required this.author,
    required this.title,
    required this.description,
    required this.publishedAt,
    required this.content,
    required this.source,
    required this.heroId,
    required this.color,
  });

  final String? imageUrl;
  final String? url;
  final String? author;
  final String? title;
  final String? description;
  final String? publishedAt;
  final String? content;
  final String? source;
  final String heroId;
  final Color? color;

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => NewsDetails(
              imageUrl: widget.imageUrl,
              url: widget.url,
              author: widget.author,
              title: widget.title,
              description: widget.description,
              publishedAt: widget.publishedAt,
              content: widget.content,
              source: widget.source,
              heroId: widget.heroId,
            ),
          ),
        );
      },
      child: SizedBox(
        height: 450,
        child: Card(
          color: widget.color,
          shadowColor: Colors.grey,
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Hero(
                tag: widget.heroId,
                child: FancyShimmerImage(
                  height: 270,
                  width: double.infinity,
                  imageUrl: widget.imageUrl ?? "Image URl not found",
                  // shimmerBaseColor: .shimmerBaseColor,
                  shimmerHighlightColor: Colors.cyan.shade50,
                  shimmerBackColor: Colors.black,
                  errorWidget: Image.asset(
                    "assets/images/error_image.png",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 270,
                  ),
                ),
              ),

              const SizedBox(
                height: 15,
              ),
              Text(
                widget.title ?? "Title not found",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // const Spacer(),
              Text(
                "Author: ${widget.author ?? "Author not Found"}",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                    fontFamily: "Roboto", fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.description ?? "Description Not Found",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: const TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontFamily: "Roboto",
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Spacer(),
                  Text(
                    widget.publishedAt ?? "Published Date Not Found",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
