import 'package:flutter/material.dart';
import 'package:social_network_mobile_ui/components/avatar.dart';
import 'package:social_network_mobile_ui/models/user.dart';

class StoryBar extends StatelessWidget {
  final User user;
  final data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  StoryBar(this.user);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 100,
        child: ListView.builder(
            itemCount: data.length + 1,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  children: [
                    Stack(children: [
                      Avatar(url: user.avatar.url),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Icon(Icons.add)))
                    ]),
                    const SizedBox(
                      height: 7,
                    ),
                    Text('Your story'),
                  ],
                );
              }
              return Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            border: Border.all(color: Colors.pink, width: 2.0)),
                        child: Avatar(url: user.avatar.url)),
                    const SizedBox(
                      height: 3,
                    ),
                    Text('${user.name}'),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
