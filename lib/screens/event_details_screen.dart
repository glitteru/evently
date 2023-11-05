import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/event.dart';

class EventDetailsScreen extends StatelessWidget {
  final Event event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(event.title)),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              Hero(
                tag: 'eventImage${event.id}',
                child: CachedNetworkImage(
                  imageUrl: event.imageUrl,
                ),
              ),
              Text(event.title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
              Text(event.description),
              Text("Data: ${event.date.toLocal().toString().split(' ')[0]}"),
              Text("Lokalizacja: ${event.location}"),
              // wiecej info
            ],
          ),
        ),
      ),
    );
  }
}
