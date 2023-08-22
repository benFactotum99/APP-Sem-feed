import 'package:sem_feed/data/models/topic.dart';

class TopicWrap {
  Topic topic;
  double ranking;
  String id;

  TopicWrap({
    required this.topic,
    required this.ranking,
    required this.id,
  });

  factory TopicWrap.fromJson(Map<String, dynamic> json) => TopicWrap(
        topic: Topic.fromJson(json["topic"]),
        ranking: json["ranking"]?.toDouble(),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "topic": topic.toJson(),
        "ranking": ranking,
        "_id": id,
      };
}
