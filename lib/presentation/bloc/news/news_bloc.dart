import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sem_feed/data/exceptions/custom_token_exception.dart';
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
          if (event.isFirst == true) emit(NewsBlocStateLoading());
          var news = await newsService.getNews();
          if (event.searchText == "") {
            emit(NewsBlocStateLoaded(news));
          } else {
            final newsFiltered = news.where((news) {
              final den =
                  ("${news.title}, ${news.contentSnippet}").toLowerCase();
              final input = event.searchText.toLowerCase();

              return den.contains(input);
            }).toList();
            emit(NewsBlocStateLoaded(newsFiltered));
          }
        } on CustomTokenException catch (error) {
          print(error.cause);
          emit(NewsBlocStateLogout(error.cause));
        } catch (error) {
          print(error);
          emit(NewsBlocStateError(error.toString()));
        }
      },
    );
  }
}
