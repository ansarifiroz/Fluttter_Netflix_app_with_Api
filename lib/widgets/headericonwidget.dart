import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:netflix/screens/search_screen.dart';
import 'package:netflix/widgets/homepage_header.dart';

class HederIcon extends StatelessWidget {
  const HederIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/logos/netflix.png",
                  width: 30,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/logos/scast.png",
                        width: 30,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(Icons.file_download_sharp),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(const SearchScreen());
                        },
                        child: const Icon(
                          Icons.search,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const HomepageHeader(),
        ],
      ),
    );
  }
}
