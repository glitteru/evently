import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Event {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime date;
  final String location;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
    required this.location,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    final uuid = Uuid();
    return Event(
      id: uuid.v4(),
      title: json['title'] as String,
      description: 'Test description',
      imageUrl: json['image'] as String,
      date: DateTime.parse(json['date']),
      location: json['localization'] as String,
    );
  }
}
