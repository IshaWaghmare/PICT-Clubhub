import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sign_up_in/main_non_tech.dart';
import 'package:sign_up_in/main_tech.dart';
import 'package:sign_up_in/sigS.dart';
import 'package:url_launcher/url_launcher.dart';
import 'drawer.dart';
import 'config.dart' as config;
import 'package:http/http.dart' as http;

class Dash extends StatefulWidget {
  const Dash({Key? key}) : super(key: key);

  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {
  List<dynamic> events = [];
  bool isLoding = true;

  Future<void> getEvents() async {
    var response = await http.get(Uri.parse(config.getEvents));
    var jsonResponse = jsonDecode(response.body);
    setState(() {
      events = (jsonResponse as Map)['events'] as List;
      isLoding = false;
    });
  }

  @override
  void initState() {
    getEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.black,
      drawer: const nav_bar(),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu, color: Colors.white, size: 39),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        //title: Text(".appable/", style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20, top: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //search & intro
              Container(
                height: 50,
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Colors.blue, width: 3),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search...",
                          hintStyle: TextStyle(
                            color: Colors.grey.withOpacity(0.4),
                            fontSize: 26,
                            fontWeight: FontWeight.normal,
                          ),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                        onChanged: (value) {
                          // Handle the input change here
                        },
                      ),
                    ),
                    const Icon(
                      Icons.search,
                      size: 35,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 15.0,
              ),
              //Text("Welcome,", style: txtTheme.headlineSmall?.apply(color: Colors.white,fontWeightDelta: 3),),
              //Text("To HUB of Clubs", style: txtTheme.displaySmall?.apply(color: Colors.white),),
              // const SizedBox(
              //   height: 15.0,
              // ),

              //const SizedBox(height: 20.0,),

              //Categories

              const SizedBox(
                height: 5,
              ),
              // Text(
              //   "All Clubs",
              //   style: TextStyle(color: Colors.white, fontSize: 18),
              // ),
              // SizedBox(
              //   height: 16,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      // width: 150,
                      height: 130,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(
                            color: Colors.blue[400],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: SizedBox(
                            // width: 120,
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/technical1.png",
                                  height: 70,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Text("Technical",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: SizedBox(
                      // width: 150,
                      height: 130,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Non_Home()));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(
                            color: Colors.blue[400],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: SizedBox(
                            // width: 120,
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/cultura.png",
                                  height: 70,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Text("Non-Technical",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 40.0,
              ),

              const Text(
                "Upcoming Events",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(
                height: 16.0,
              ),
              // UpcomingEventContainer(
              //   title: "Engineering 101:",
              //   description: "Experience with UI/UX",
              //   datetime: "20th May, 11:00 AM",
              //   location: "A1-311",
              //   imageUrl: "s0.jpg",
              //   link: "https://www.google.com",
              // ),
              // UpcomingEventContainer(
              //   title: "PICT NSS:",
              //   description: "Volunteer Recruitment Drive",
              //   datetime: "21st-May, 11:59 pm",
              //   location: "A1-311",
              //   imageUrl: "nss1.png",
              //   link: "https://www.google.com",
              // ),
              // UpcomingEventContainer(
              //   title: "GDSC PICT",
              //   description: "CodeQuest Trivia Quiz!",
              //   datetime: "29st-May, 6-10 pm",
              //   location: "A1-311",
              //   imageUrl: "gdsc.jpg",
              //   link: "https://www.google.com",
              // ),
              // UpcomingEventContainer(
              //   title: "PICTMUN Recruitment drive! 🤩",
              //   description: "PICTMUN Recruitment drive! 🤩",
              //   datetime: "25 May, 11:00 AM",
              //   location: "A1-311",
              //   imageUrl: "mun1.png",
              //   link: "https://www.google.com",
              // ),

              isLoding
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    )
                  : Column(
                      children: events
                          .map((event) => UpcomingEventContainer(
                                title: event["title"],
                                description: event["description"],
                                datetime: event["datetime"],
                                location: event["location"],
                                imageUrl: event["imageUrl"],
                                link: event["link"],
                              ))
                          .toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpcomingEventContainer extends StatefulWidget {
  final String title;
  final String description;
  final String datetime;
  final String location;
  final String imageUrl;
  final String link;
  bool isBookMarked;

  UpcomingEventContainer({
    super.key,
    required this.title,
    required this.description,
    required this.datetime,
    required this.location,
    required this.imageUrl,
    required this.link,
    this.isBookMarked = false,
  });

  @override
  State<UpcomingEventContainer> createState() => _UpcomingEventContainerState();
}

class _UpcomingEventContainerState extends State<UpcomingEventContainer> {
  late bool isBookmarked;

  @override
  void initState() {
    // TODO: implement initState
    isBookmarked = widget.isBookMarked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue[200],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Show image
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Show bookmark icon
              Image.asset(
                "assets/images/${widget.imageUrl}",
                width: width * 0.6,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.event, size: 40);
                },
              ),

              const SizedBox(width: 10),
              IconButton(
                iconSize: 30,
                onPressed: () {
                  setState(() {
                    isBookmarked = !isBookmarked;
                  });
                },
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          // Show title and description

          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            widget.description,
            style: Theme.of(context).textTheme.bodyLarge,
          ),

          InkWell(
            onTap: () async {
              if (!await launchUrl(Uri.parse(widget.link))) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Could not open the link"),
                  ),
                );
              }
            },
            child: Text(
              "Event Link",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                decoration: TextDecoration.underline,
              ),
            ),
          ),

          const SizedBox(height: 10),
          // Show date and time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.datetime,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_sharp,
                    color: Colors.black,
                    size: 20,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    widget.location,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
