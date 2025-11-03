import '../extensions/datetime.dart';

class Entry {
  final String id;
  final String name;
  final String? description;
  final String ageRestriction;
  final Duration durationMinutes;
  final String thumbnailimageid;
  final String genre;
  final String tags;
  final DateTime? OBoxReleaseDate;
  final DateTime? releaseDate;
  final num trendingIndex;
  final bool isOG;
  final String cast;

  bool isEmpty() {
    if (id.isEmpty || name.isEmpty) {
      return true;
    }

    return false;
  }

  Entry({
    required this.id,
    required this.name,
    this.description,
    required this.ageRestriction,
    required this.durationMinutes,
    required this.thumbnailimageid,
    required this.genre,
    required this.tags,
    this.OBoxReleaseDate,
    this.releaseDate,
    required this.trendingIndex,
    required this.isOG,
    required this.cast,
  });

  static Entry empty() {
    return Entry(
      id: '',
      name: '',
      description: '',
      ageRestriction: '',
      durationMinutes: const Duration(minutes: -1),
      thumbnailimageid: '',
      genre: '',
      tags: '',
      trendingIndex: -1,
      isOG: false,
      cast: '',
    );
  }

  static Entry fromJson(Map<String, dynamic> data) {
    return Entry(
      id: data['\$id'],
      name: data['name'] ?? "",
      description: data['description'],
      ageRestriction: data['ageRestriction'],
      durationMinutes: Duration(minutes: data['durationMinutes']),
      thumbnailimageid: data['thumbnailImageId'],
      genre: data['genres'],
      tags: data['tags'],
      OBoxReleaseDate: data['OBoxReleaseDate'] != null
          ? DateTimeExt.fromUnixTimestampInt(data['OBoxReleaseDate'])
          : null,
      releaseDate: data['releaseDate'] != null
          ? DateTimeExt.fromUnixTimestampInt(data['releaseDate'])
          : null,
      trendingIndex: 1,
      isOG: data['isOG'],
      cast: data['cast'],
    );
  }
}