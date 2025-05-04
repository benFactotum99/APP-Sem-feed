import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sem_feed/data/exceptions/custom_feed_rss_exception.dart';
import 'package:sem_feed/data/exceptions/custom_token_exception.dart';
import 'package:sem_feed/application/services/resource_service.dart';
import 'package:sem_feed/presentation/bloc/resource/resource_bloc_event.dart';
import 'package:sem_feed/presentation/bloc/resource/resource_bloc_state.dart';

class ResourceBloc extends Bloc<ResourceBlocEvent, ResourceBlocState> {
  final ResourceService resourceService;
  ResourceBloc({required this.resourceService})
      : super(ResourceBlocStateInit()) {
    on<ResourceBlocEventAdd>(
      (event, emit) async {
        try {
          emit(ResourceBlocStateAdding());
          await resourceService.addResource(event.url, event.topic);
          emit(ResourceBlocStateAdded());
        } on CustomTokenException catch (error) {
          print(error.cause);
          emit(ResourceBlocStateLogout(error.cause));
        } on CustomFeedRssException catch (error) {
          emit(ResourceBlocStateFeedRssNotFound(error.cause));
        } catch (error) {
          print(error);
          emit(ResourceBlocStateError(error.toString()));
        }
      },
    );
  }
}
