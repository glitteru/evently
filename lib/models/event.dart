import 'package:uuid/uuid.dart';
import 'package:recase/recase.dart';

class Event {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime date;
  final String location;
  final String category;

  Event(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.date,
      required this.location,
      required this.category});

  factory Event.fromJson(Map<String, dynamic> json) {
    const uuid = Uuid();
    return Event(
      id: uuid.v4(),
      title: json['title'] as String,
      description:
          (json['description'] as String).split('Pełny opis wydarzenia')[0],
      imageUrl: json['image'] as String,
      date: DateTime.parse(json['date']),
      location: json['localization'] as String,
      category: ReCase(json['category'] as String).titleCase,
    );
  }
}
