import 'package:sem_feed/data/models/topic.dart';
import 'package:sem_feed/data/models/topic_req.dart';

abstract class TopicBlocEvent {}

class TopicBlocEventFetch extends TopicBlocEvent {
  TopicBlocEventFetch();
}

class TopicBlocEventCreate extends TopicBlocEvent {
  final TopicReq topicReq;
  TopicBlocEventCreate(this.topicReq);
}

class TopicBlocEventUpdate extends TopicBlocEvent {
  final Topic topic;
  TopicBlocEventUpdate(this.topic);
}

class TopicBlocEventDelete extends TopicBlocEvent {
  final String topicId;
  TopicBlocEventDelete(this.topicId);
}
