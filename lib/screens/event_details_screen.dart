import 'package:flutter/material.dart';
import '../models/event.dart';

class EventDetailsScreen extends StatelessWidget {
  final Event event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(event.title)),
      body: Column(
        children: [
          Image.network(event.imageUrl),
          Text(event.title,
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(event.description),
          Text("Data: ${event.date.toLocal().toString().split(' ')[0]}"),
          Text("Lokalizacja: ${event.location}"),
          // Możesz dodać więcej informacji o evencie...
        ],
      ),
    );
  }
}
