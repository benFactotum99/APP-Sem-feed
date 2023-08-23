import 'package:sem_feed/data/models/topic.dart';
import 'package:sem_feed/data/repository/api/topic_repository.dart';

class TopicService {
  final TopicRepository topicRepository;
  TopicService(this.topicRepository);
  Future<List<Topic>> getTopics() async {
    return await this.topicRepository.getTopics();
  }
}
