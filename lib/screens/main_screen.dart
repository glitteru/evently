import 'package:flutter/material.dart';
import 'event_details_screen.dart';
import '../models/event.dart';
import '../models/api_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MainScreen extends StatefulWidget {
  final DateTime selectedDate;
  const MainScreen({Key? key, required this.selectedDate}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<List<Event>> futureEvents;
  @override
  void initState() {
    super.initState();
    futureEvents = ApiService.getEvents().then((events) => events
        .where((event) => event.date.isAtSameMomentAs(widget.selectedDate))
        .toList());
  }

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
        child: FutureBuilder<List<Event>>(
          future: futureEvents,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var event = snapshot.data![index];
                  return Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        leading: Hero(
                          tag: 'eventImage${event.id}',
                          child: Container(
                              padding: const EdgeInsets.only(right: 12),
                              decoration: const BoxDecoration(
                                border: Border(
                                  right:
                                      BorderSide(width: 1, color: Colors.grey),
                                ),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: event.imageUrl,
                                placeholder: (context, url) =>
                                    const SpinKitFadingCube(
                                  color: Colors.purple,
                                  size: 50.0,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              )),
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
                            builder: (context) =>
                                EventDetailsScreen(event: event),
                          ));
                        },
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const Center(
                child: SpinKitFadingCube(
              color: Colors.purple,
              size: 50.0,
            ));
          },
        ),
      ),
    );
  }
}
