import 'package:sem_feed/data/models/topic.dart';

abstract class ResourceBlocEvent {}

class ResourceBlocEventAdd extends ResourceBlocEvent {
  final String url;
  final Topic topic;
  ResourceBlocEventAdd(this.url, this.topic);
}
