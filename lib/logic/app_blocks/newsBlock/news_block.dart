import 'package:bloc/bloc.dart';
import 'package:weather_application/data/repositories/article_repository.dart';
import 'package:weather_application/logic/app_blocks/newsBlock/new_states.dart';
import 'package:weather_application/logic/app_blocks/newsBlock/news_events.dart';

class NewsBlock extends Bloc<NewsEvent, NewsStates> {
  NewsBlock({required this.articleRepository}) : super(NewsNotRequested()) {
    on<FetchNews>(_requestNews);
  }

  final ArticleRepository articleRepository;

  Future<void> _requestNews(FetchNews event, Emitter<NewsStates> emit) async {
    articleRepository.searchKeyWords = event.articles;
    emit(NewsIsLoading());
    await articleRepository
        .getArticles()
        .then((value) => emit(NewsIsLoaded(articles: value)));
  }
}
