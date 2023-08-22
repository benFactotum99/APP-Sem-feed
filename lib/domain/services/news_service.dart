import 'package:sem_feed/data/models/news.dart';
import 'package:sem_feed/data/repository/api/news_repository.dart';

class NewsService {
  final NewsRepository newsRepository;
  NewsService(this.newsRepository);

  Future<List<News>> getNewses() async {
    return await this.newsRepository.getNewses();
  }
}
