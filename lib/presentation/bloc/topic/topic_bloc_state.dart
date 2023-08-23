import 'package:sem_feed/data/models/topic.dart';

abstract class TopicBlocState {}

class TopicBlocStateInit extends TopicBlocState {}

class TopicBlocStateLoading extends TopicBlocState {}

class TopicBlocStateLoaded extends TopicBlocState {
  final List<Topic> topices;
  TopicBlocStateLoaded(this.topices);
}

class TopicBlocStateError extends TopicBlocState {
  final String errorMessage;
  TopicBlocStateError(this.errorMessage);
}

class TopicBlocStateLogout extends TopicBlocState {
  final String errorMessage;
  TopicBlocStateLogout(this.errorMessage);
}
