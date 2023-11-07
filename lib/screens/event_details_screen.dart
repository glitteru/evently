import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/event.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsScreen extends StatelessWidget {
  final Event event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () async {
              const url = 'https://www.trojmiasto.pl/';
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Hero(
                  tag: 'eventImage${event.id}',
                  child: CachedNetworkImage(
                    imageUrl: event.imageUrl,
                  ),
                ),
                Text(
                  "Dane pochodzą z serwisu trójmiasto.pl",
                  style: TextStyle(fontSize: 10),
                ),
                Linkify(
                  onOpen: (link) async {
                    if (await canLaunchUrl(Uri.parse(link.url))) {
                      await launchUrl(Uri.parse(link.url));
                    } else {
                      throw 'Could not launch $link';
                    }
                  },
                  text: event.description
                      .replaceAllMapped(
                        RegExp(r'(?<=\S)https:\/\/forms\.gle\/\w{17}(?=\S|\w)'),
                        (match) => ' ${match.group(0)} ',
                      )
                      .replaceAllMapped(
                        RegExp(r'\.(?=\s*[A-Z])|,(?=\S)(?<!\")'),
                        (match) => '${match.group(0)} ',
                      )
                      .replaceAllMapped(
                        RegExp(r'\"([^\"]*)\"'),
                        (match) => '${match.group(0)} ',
                      )
                      .replaceAllMapped(
                        RegExp(r'(?<=[a-z/])(?=[A-Z])'),
                        (match) => '${match.group(0)} ',
                      )
                      .replaceAll(RegExp(r'\s{2,}'), ' '),
                  style: const TextStyle(color: Colors.black),
                  linkStyle: const TextStyle(color: Colors.blue),
                ),
                Text("Data: ${event.date.toLocal().toString().split(' ')[0]}"),
                Text("Lokalizacja: ${event.location}"),
                // wiecej info
              ],
            ),
          ),
        ),
      ),
    );
  }
}
