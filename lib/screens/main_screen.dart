import 'package:flutter/material.dart';
import 'event_details_screen.dart';
import '../models/event.dart';

class MainScreen extends StatelessWidget {
  final List<Event> events = [
    Event(
      title: 'Koncert Rockowy',
      description: 'Wspaniały koncert rockowy w twoim mieście!',
      imageUrl:
          'https://tc-assets-dep.s3.amazonaws.com/media/concert-crowd.jpg',
      date: DateTime.now(),
      location: 'Plac Koncertowy 1',
    ),
    // Możesz dodać więcej przykładowych eventów...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Evently"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF73AEF5),
              Color(0xFF61A4F1),
              Color(0xFF478DE0),
              Color(0xFF398AE5),
            ],
          ),
        ),
        child: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            var event = events[index];
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  leading: Container(
                    padding: const EdgeInsets.only(right: 12),
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(width: 1, color: Colors.grey),
                      ),
                    ),
                    child: Image.network(event.imageUrl),
                  ),
                  title: Text(
                    event.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    event.description,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                    size: 30,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EventDetailsScreen(event: event),
                    ));
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
