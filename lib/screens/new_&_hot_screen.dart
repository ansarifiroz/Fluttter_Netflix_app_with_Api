import 'package:flutter/material.dart';
import 'package:netflix/widgets/coming_soon_movie_widget.dart';

class NewAndHotScreen extends StatefulWidget {
  const NewAndHotScreen({super.key});

  @override
  State<NewAndHotScreen> createState() => _NewAndHotScreenState();
}

class _NewAndHotScreenState extends State<NewAndHotScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: SafeArea(
            child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Text("New & Hot"),
            actions: const [
              SizedBox(width: 60, child: Icon(Icons.cast)),
            ],
            bottom: TabBar(
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                labelColor: Colors.black,
                labelStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                unselectedLabelColor: Colors.white,
                tabs: const [
                  Tab(
                    text: " 🎁 Coming Soon ",
                  ),
                  Tab(
                    text: " 🔥 Everyone's Watching ",
                  )
                ]),
          ),
          body: const TabBarView(children: [
            Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                ComingSoonMovieWidget(
                  overview: "this is overvie",
                  month: "July",
                  day: "15",
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqGK3diR3Zi-mnOXEaj-3ewmFyRYVxGzVzZw&s',
                )
              ],
            ),
            ComingSoonMovieWidget(
              overview: "this is overvie",
              month: "July",
              day: "12",
              imageUrl:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqGK3diR3Zi-mnOXEaj-3ewmFyRYVxGzVzZw&s',
            )
          ]),
        )));
  }
}
