import 'package:sem_feed/data/models/news.dart';

abstract class NewsBlocState {}

class NewsBlocStateInit extends NewsBlocState {}

class NewsBlocStateLoading extends NewsBlocState {}

class NewsBlocStateLoaded extends NewsBlocState {
  final List<News> newses;
  NewsBlocStateLoaded(this.newses);
}

class NewsBlocStateError extends NewsBlocState {
  final String errorMessage;
  NewsBlocStateError(this.errorMessage);
}

class NewsBlocStateLogout extends NewsBlocState {
  final String errorMessage;
  NewsBlocStateLogout(this.errorMessage);
}
