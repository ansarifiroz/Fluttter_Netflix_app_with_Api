import 'package:flutter/material.dart';

class HomepageHeader extends StatelessWidget {
  const HomepageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          OutlinedButton(
              onPressed: () {},
              child: const Text(
                "TV Shows",
                style: TextStyle(color: Colors.white),
              )),
          OutlinedButton(
              onPressed: () {},
              child:
                  const Text("Movies", style: TextStyle(color: Colors.white))),
          OutlinedButton.icon(
            onPressed: () {},
            label: const Row(
              children: [
                Text("Categories", style: TextStyle(color: Colors.white)),
                Icon(
                  Icons.arrow_drop_down_sharp,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
