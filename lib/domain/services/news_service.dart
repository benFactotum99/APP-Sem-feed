import 'package:sem_feed/data/models/news.dart';
import 'package:sem_feed/data/models/news_req.dart';
import 'package:sem_feed/data/models/resource.dart';
import 'package:sem_feed/data/models/resource_req.dart';
import 'package:sem_feed/data/models/topic.dart';
import 'package:sem_feed/data/repository/api/news_repository.dart';
import 'package:sem_feed/data/repository/api/resource_repository.dart';
import 'package:sem_feed/data/repository/api/user_repository.dart';

class NewsService {
  final NewsRepository newsRepository;
  NewsService(
    this.newsRepository,
  );

  Future<List<News>> getNews() async {
    return await this.newsRepository.getNews();
  }
}
