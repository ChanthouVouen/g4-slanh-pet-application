import 'package:flutter/material.dart';

class FirestoreStreamBuilder<T> extends StatelessWidget {
  final Stream<T> stream;
  final Widget Function(T data) builder;

  const FirestoreStreamBuilder({
    super.key,
    required this.stream,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,

      builder: (context, snapshot) {
        // 1. Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // 2. Error
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        // 3. No data
        if (snapshot.data is List && (snapshot.data as List).isEmpty) {
          return const Center(child: Text('No items found'));
        }

        // 4. Data exists
        return builder(snapshot.data!);
      },
    );
  }
}
