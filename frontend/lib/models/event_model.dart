class EventModel {
  final String id; // New unique ID
  final String title;
  final String genre;
  final String location;
  final String dateTime;
  final String poster;
  final String detailPoster;
  final List<String> gallery;
  final String about;
  final double price;
  final String type;

  EventModel({
    required this.id,
    required this.title,
    required this.genre,
    required this.location,
    required this.dateTime,
    required this.poster,
    required this.detailPoster,
    required this.gallery,
    required this.about,
    required this.price,
    required this.type,
  });

  factory EventModel.fromJson(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'] ?? map['title'], // fallback to title if no id
      title: map['title'] ?? '',
      genre: map['genre'] ?? '',
      location: map['location'] ?? '',
      dateTime: map['dateTime'] ?? '',
      poster: map['poster'] ?? '',
      detailPoster: map['detailPoster'] ?? '',
      gallery: List<String>.from(map['gallery'] ?? []),
      about: map['about'] ?? '',
      price: map['price']?.toDouble() ?? 0,
      type: map['type'] ?? '',
    );
  }
}
