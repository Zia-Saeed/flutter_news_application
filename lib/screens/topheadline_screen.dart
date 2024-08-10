import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:image_api_create/constss/country_codes.dart';
import 'package:image_api_create/widgets/shimmer_headline_widget.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'global_methods.dart';

class TopHeadLineScreen extends StatefulWidget {
  const TopHeadLineScreen({
    super.key,

    // https://img.freepik.com/premium-vector/news-headlines-background-with-earth-planet_1017-12632.jpg
  });

  @override
  State<TopHeadLineScreen> createState() => _TopHeadLineScreenState();
}

class _TopHeadLineScreenState extends State<TopHeadLineScreen> {
  String _selectedCountry = "United States";
  final countires = getCountriesName();
  final categories = categoriesList;

  final searchBar = TextEditingController();
  final searchBarFocusNode = FocusNode();
  String _selectedCategory = "general";

  String? getKeyByValue(Map<String, String> map, String value) {
    // Iterate over map entries to find the key corresponding to the given value
    for (var entry in map.entries) {
      if (entry.value == value) {
        return entry.key;
      }
    }
    return null; // Return null if the value is not found
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    searchBar.dispose();
    super.dispose();
  }

  Future<List<dynamic>> fetchHeadLines({
    required String topic,
  }) async {
    String url = "";

    String? countryCode = countriesISOCode[_selectedCountry] ?? "us";

    if (topic.isEmpty) {
      url =
          "https://newsapi.org/v2/top-headlines?country=$countryCode&category=$_selectedCategory&apiKey=ac81a1f14e4940d2ae856e6c13d0e325";
    } else if (topic.isNotEmpty) {
      url =
          "https://newsapi.org/v2/top-headlines?q=${searchBar.text}&apiKey=ac81a1f14e4940d2ae856e6c13d0e325";
    }
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData["articles"];
    } else {
      throw Exception("Unable to Get Data");
    }
  }

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
      body: Column(
        children: [
          searchField(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.amber.shade50,
                Colors.teal.shade300,
              ])),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  "News Headline by Country and Category",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto",
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                DropdownButton(
                  value: _selectedCountry,
                  hint: const Text("Select a Country"),
                  items: countires.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star_border_sharp,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 1),
                          Text(value),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedCountry = value!;
                    });
                  },
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                  ),
                  dropdownColor: Colors.grey[200],
                  underline: Container(
                    height: 2,
                    color: Colors.blue,
                  ),
                ),
                const Spacer(),
                DropdownButton(
                  value: _selectedCategory,
                  hint: const Text("Select a Category"),
                  items: categories.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star_border_sharp,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 1),
                          Text(value),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                  ),
                  dropdownColor: Colors.grey[200],
                  underline: Container(
                    height: 2,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: fetchHeadLines(
              topic: searchBar.text,
            ),
            builder: (context, snapshop) {
              if (snapshop.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: Center(
                      child: ListView.builder(
                    itemBuilder: (index, context) =>
                        const ShimmerHeadLineWidget(),
                    itemCount: 20,
                  )),
                );
              } else if (snapshop.hasError) {
                return Center(
                  child:
                      Text("Unable to Fetch data due to: \n${snapshop.error}"),
                );
              } else if (snapshop.data!.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Center(
                    child: SizedBox(
                      height: 100,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                            gradient: LinearGradient(colors: [
                              Colors.blue.shade100,
                              Colors.blueGrey.shade100
                            ])),
                        height: 20,
                        // color: Colors.blue[200],
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Opps! No data Found About this topic.",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                List data = [];
                // final data = snapshot.data!;
                if (snapshop.data!.length < 20) {
                  data = snapshop.data!;
                } else {
                  for (int i = 0; i < 20; i++) {
                    data.add(snapshop.data![i]);
                  }
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: (index % 2 == 0)
                            ? const Color.fromARGB(255, 151, 145, 145)
                            : Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Hero(
                              tag: data[index]["title"] ?? "widget.title",
                              child: FancyShimmerImage(
                                imageUrl:
                                    "https://img.freepik.com/premium-vector/news-headlines-background-with-earth-planet_1017-12632.jpg",
                                boxFit: BoxFit.cover,
                                height: 200,
                                width: double.infinity,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Title: ${data[index]["title"]}" ??
                                        "title not found",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Source\n${data[index]["source"]["name"]}" ??
                                        "Source not found",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Roboto",
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "description\n${data[index]["description"]}" ??
                                        "description not found",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Author: ${data[index]["author"]}' ??
                                        "author not Found",
                                    style: const TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 13,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Published: ${data[index]["publihesdAt"]}',
                                    style: const TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 13,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _launchInAppWithBrowserOptions(
                                        Uri.parse(
                                          data[index]["url"] ??
                                              "https://google.com",
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      style: TextStyle(
                                        fontFamily: "Roboto",
                                      ),
                                      "View Headline in web browser",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget searchField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (value) {},
        controller: searchBar,
        focusNode: searchBarFocusNode,
        onSubmitted: (value) {
          setState(() {
            fetchHeadLines(
              topic: searchBar.text,
            );
          });
        },
        decoration: InputDecoration(
          focusColor: Colors.blue[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              10.0,
            ),
          ),
          hintText: "Search New by any Topic",
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                print("this is search bar value: ${searchBar.text}");
                fetchHeadLines(
                  topic: searchBar.text,
                );
              });
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
        ),
      ),
    );
  }
}
