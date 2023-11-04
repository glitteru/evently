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
      date: DateTime.parse(json['date']),
      location: json['location'] as String,
    );
  }
}
