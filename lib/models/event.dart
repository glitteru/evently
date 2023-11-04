import 'package:intl/intl.dart';

class Event {
  final String title;
  final String description;
  final String imageUrl;
  final DateTime date;
  final String location;

  Event(
      {required this.title,
      required this.description,
      required this.imageUrl,
      required this.date,
      required this.location});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'] as String,
      description: 'Test description',
      imageUrl: json['image'] as String,
      date: DateFormat('dd-MM-yyyy').parse(json['date']),
      location: json['localization'] as String,
    );
  }
}
