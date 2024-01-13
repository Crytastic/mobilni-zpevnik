import 'package:flutter/material.dart';

class HandlingStreamBuilder<T> extends StatelessWidget {
  final Stream<T> stream;
  final Widget Function(BuildContext context, T data) builder;

  const HandlingStreamBuilder(
      {super.key, required this.stream, required this.builder});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error!}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: Text('Problem with songs stream'));
          return const Center(child: CircularProgressIndicator());
        }

        return builder(context, snapshot.data as T);
      },
    );
  }
}
