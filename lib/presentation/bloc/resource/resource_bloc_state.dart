abstract class ResourceBlocState {}

class ResourceBlocStateInit extends ResourceBlocState {}

class ResourceBlocStateAdding extends ResourceBlocState {}

class ResourceBlocStateAdded extends ResourceBlocState {}

class ResourceBlocStateError extends ResourceBlocState {
  final String errorMessage;
  ResourceBlocStateError(this.errorMessage);
}

class ResourceBlocStateLogout extends ResourceBlocState {
  final String errorMessage;
  ResourceBlocStateLogout(this.errorMessage);
}

class ResourceBlocStateFeedRssNotFound extends ResourceBlocState {
  final String errorMessage;
  ResourceBlocStateFeedRssNotFound(this.errorMessage);
}
