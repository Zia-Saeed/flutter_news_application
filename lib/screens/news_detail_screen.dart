import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetails extends StatefulWidget {
  const NewsDetails({
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

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  Future<void> _launchInAppWithBrowserOptions(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppBrowserView,
      browserConfiguration: const BrowserConfiguration(showTitle: true),
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Details"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: widget.heroId,
                    child: FancyShimmerImage(
                      width: double.infinity,
                      imageUrl: widget.imageUrl ?? "Image Url Not Found",
                      shimmerBaseColor: const Color.fromARGB(255, 100, 99, 99),
                      shimmerHighlightColor: Colors.black54,
                      shimmerBackColor: Colors.brown.shade200,
                      errorWidget: Image.asset(
                        "assets/images/error_image.png",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 270,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    // right: 50,
                    top: 20,
                    child: Text(
                      "Source: ${widget.source ?? "Source Not Found"}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    right: 10,
                    child: Text(
                      "Published At : ${widget.publishedAt ?? "Published Date Not Found"}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      widget.title ?? "Title Not Found",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      const Text(
                        "Breif description of News",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: "Roboto",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.description ?? "Description Not Found",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            fontFamily: "Roboto",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      const Text(
                        "Content of News",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          fontFamily: "Roboto",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.content ?? "News Content not Found",
                          style: const TextStyle(fontFamily: "Roboto"),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      _launchInAppWithBrowserOptions(
                        Uri.parse(widget.url ?? "https://google.com"),
                      );
                    },
                    child: const Text(
                      "View Full News in Browser",
                    ),
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
