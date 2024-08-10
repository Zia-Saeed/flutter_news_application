import 'package:flutter/material.dart';
import 'package:image_api_create/constss/country_codes.dart';
import 'package:image_api_create/widgets/news_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:image_api_create/widgets/shimmer_news_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchBar = TextEditingController();
  FocusNode searchBarFocueNode = FocusNode();
  String selectedLanguage = "English";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    searchBar.dispose();
    super.dispose();
  }

  Future<List<dynamic>> fetchNews({
    required String topic,
  }) async {
    // searchBar.text = "Search News by Topic";
    String requestUrl = "";

    String languageCodeName = languageCode[selectedLanguage] ?? "en";

    if (topic.isEmpty) {
      requestUrl =
          "https://newsapi.org/v2/everything?q=bitcoin&language=$languageCodeName&apiKey=ac81a1f14e4940d2ae856e6c13d0e325";
      print("runned condition");
    } else {
      print("runned condition222");
      requestUrl =
          "https://newsapi.org/v2/everything?q=$topic&language=$languageCodeName&sortBy=popularity&apiKey=ac81a1f14e4940d2ae856e6c13d0e325";
    }
    final response = await http.get(Uri.parse(requestUrl));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData["articles"];
    } else {
      throw Exception('Failde to get the data ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: FutureBuilder(
        future: fetchNews(
          topic: searchBar.text,
          // language: "en",
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: [
                searchField(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton(
                      hint: const Text("Select a languge"),
                      value: selectedLanguage,
                      items: languageName.map((String value) {
                        return DropdownMenuItem(
                            value: value,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.teal.shade100.withOpacity(0.5),
                                    Colors.brown.shade200.withOpacity(0.3),
                                  ],
                                ),
                              ),
                              child: SizedBox(
                                width: 180,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.language,
                                    ),
                                    // const Spacer(),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(value),
                                  ],
                                ),
                              ),
                            ));
                      }).toList(),
                      onChanged: (value) {}),
                ),
                const Expanded(
                  child: ShimmerNewsCard(
                    itemCounts: 20,
                  ),
                ),
              ],
            );
          } else if (snapshot.data!.isEmpty) {
            print("Empty Condition runned");
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
                        "Opps! No data Found.",
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
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List data = [];
            // final data = snapshot.data!;
            if (snapshot.data!.length < 20) {
              data = snapshot.data!;
            } else {
              for (int i = 0; i < 20; i++) {
                data.add(snapshot.data![i]);
              }
            }

            return Column(
              children: [
                searchField(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Colors.amber.shade50,
                      Colors.teal.shade300,
                    ])),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Select Language and Get New According",
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
                  child: DropdownButton(
                      hint: const Text("Select a language"),
                      value: selectedLanguage,
                      items: languageName.map((String value) {
                        return DropdownMenuItem(
                            value: value,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  15.0,
                                ),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.teal.shade100.withOpacity(0.5),
                                    Colors.brown.shade200.withOpacity(0.3),
                                  ],
                                ),
                              ),
                              child: SizedBox(
                                width: 180,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.language,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(value),
                                  ],
                                ),
                              ),
                            ));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedLanguage = value!;
                        });
                      }),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) => NewsCard(
                      color: (index % 2 == 0)
                          ? const Color.fromARGB(255, 151, 145, 145)
                          : Colors.white,
                      imageUrl: data[index]["urlToImage"],
                      url: data[index]["url"],
                      author: data[index]["author"],
                      title: data[index]["title"],
                      description: data[index]["description"],
                      publishedAt: data[index]["publishedAt"],
                      content: data[index]["content"],
                      source: data[index]["source"]["name"],
                      heroId: index.toString(),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget searchField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (value) {
          // setState(() {
          //   fetchNews(searchBar.text, "en");
          // });
        },
        controller: searchBar,
        focusNode: searchBarFocueNode,
        onSubmitted: (value) {
          setState(() {
            fetchNews(
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
                // fetchNews(searchBar.text, "en");
                fetchNews(
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
