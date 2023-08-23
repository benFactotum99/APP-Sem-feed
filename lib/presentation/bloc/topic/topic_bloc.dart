import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sem_feed/data/exceptions/custom_token_exception.dart';
import 'package:sem_feed/domain/services/topic_service.dart';
import 'package:sem_feed/presentation/bloc/topic/topic_bloc_event.dart';
import 'package:sem_feed/presentation/bloc/topic/topic_bloc_state.dart';

class TopicBloc extends Bloc<TopicBlocEvent, TopicBlocState> {
  final TopicService topicService;
  TopicBloc({required this.topicService}) : super(TopicBlocStateLoading()) {
    on<TopicBlocEventFetch>(
      (event, emit) async {
        try {
          emit(TopicBlocStateLoading());
          var topices = await topicService.getTopics();
          emit(TopicBlocStateLoaded(topices));
        } on CustomTokenException catch (error) {
          print(error.cause);
          emit(TopicBlocStateLogout(error.cause));
        } catch (error) {
          print(error);
          emit(TopicBlocStateError(error.toString()));
        }
      },
    );
  }
}
