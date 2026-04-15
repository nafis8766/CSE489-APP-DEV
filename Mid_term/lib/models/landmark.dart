class Landmark {
  final int id;
  final String title;
  final double lat;
  final double lon;
  final String image;
  final double score;
  final int visitCount;

  Landmark({
    required this.id,
    required this.title,
    required this.lat,
    required this.lon,
    required this.image,
    required this.score,
    required this.visitCount,
  });

  factory Landmark.fromJson(Map<String, dynamic> json) {
    return Landmark(
      id: int.parse(json['id'].toString()),
      title: json['title'],
      lat: double.parse(json['lat'].toString()),
      lon: double.parse(json['lon'].toString()),
      image: json['image'].toString().startsWith("http")
          ? json['image']
          : "https://labs.anontech.info/cse489/exm3/${json['image']}",
      score: double.parse(json['score'].toString()),
      visitCount: json['visit_count'] != null ? int.parse(json['visit_count'].toString()) : 0,
    );
  }
}