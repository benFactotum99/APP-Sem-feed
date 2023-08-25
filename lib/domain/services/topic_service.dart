import 'package:sem_feed/data/models/topic.dart';
import 'package:sem_feed/data/models/topic_req.dart';
import 'package:sem_feed/data/repository/api/topic_repository.dart';

class TopicService {
  final TopicRepository topicRepository;
  TopicService(this.topicRepository);
  Future<List<Topic>> getTopics() async {
    return await this.topicRepository.getTopics();
  }

  Future<Topic> create(TopicReq topicReq) async {
    return await this.topicRepository.create(topicReq);
  }

  Future<Topic> update(Topic topic) async {
    return await this.topicRepository.update(topic);
  }

  Future<void> delete(String topicId) async {
    return await this.topicRepository.delete(topicId);
  }
}
