import 'package:flutter/material.dart';
import 'package:social_network_mobile_ui/ultils/time_ultil.dart';

class TimeBar extends StatelessWidget {
  final DateTime time;

  TimeBar({required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: Center(
        child: Text(formatDate(time: time)),
      ),
    );
  }
}
