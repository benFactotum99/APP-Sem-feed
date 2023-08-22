import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sem_feed/data/repository/api/news_repository.dart';
import 'package:sem_feed/domain/services/news_service.dart';
import 'package:sem_feed/presentation/bloc/news/news_bloc_event.dart';
import 'package:sem_feed/presentation/bloc/news/news_bloc_state.dart';

class NewsBloc extends Bloc<NewsBlocEvent, NewsBlocState> {
  final NewsService newsService;
  NewsBloc({required this.newsService}) : super(NewsBlocStateLoading()) {
    on<NewsBlocEventFetch>(
      (event, emit) async {
        try {
          emit(NewsBlocStateLoading());
          var newses = await newsService.getNewses();
          emit(NewsBlocStateLoaded(newses));
          //TODO: andrebbero differenziate le eccezioni
        } catch (error) {
          print(error);
          emit(NewsBlocStateError("Errore"));
        }
      },
    );
  }
}
