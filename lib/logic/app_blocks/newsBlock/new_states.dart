abstract class NewsStates {}

class NewsIsLoading extends NewsStates {}

class NewsIsLoaded extends NewsStates {
  final List<dynamic> articles;
  NewsIsLoaded({required this.articles});
}

class NewsNotRequested extends NewsStates {}
