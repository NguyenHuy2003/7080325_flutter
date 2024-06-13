import 'dart:async';

import 'package:flutter/material.dart';

class StreamWidget extends StatelessWidget {
  final StreamController<int> controller;
  const StreamWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<int>(
          stream: controller.stream,
          builder: (context, snapshot) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
