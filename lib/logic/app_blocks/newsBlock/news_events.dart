import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {}

class FetchNews extends NewsEvent {
  FetchNews({required this.articles});

  final List<String> articles;
  @override
  List<Object> get props => [];
}
