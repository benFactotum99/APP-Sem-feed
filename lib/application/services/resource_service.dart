import 'package:sem_feed/data/models/news_req.dart';
import 'package:sem_feed/data/models/resource_req.dart';
import 'package:sem_feed/data/models/topic.dart';
import 'package:sem_feed/data/repository/api/resource_repository.dart';
import 'package:sem_feed/data/repository/api/user_repository.dart';

class ResourceService {
  final UserRepository userRepository;
  final ResourceRepository resourceRepository;
  ResourceService(
    this.userRepository,
    this.resourceRepository,
  );
  Future<void> addResource(String url, Topic topic) async {
    var user = await userRepository.currentUser;
    if (user == null) throw new Exception("Utente non trovato.");

    var resp = await resourceRepository.create(
      ResourceReq(
        url: url,
        userId: user.userId,
      ),
    );

    await resourceRepository.generateNews(
      NewsReq(
        resourceId: resp.id,
        topic: TopicNewsReq(
          id: topic.id,
          user: topic.user,
          name: topic.name,
          description: topic.description,
          active: topic.active,
        ),
      ),
    );
  }
}
