import 'package:sem_feed/data/models/topic.dart';

abstract class NewsBlocEvent {}

class NewsBlocEventFetch extends NewsBlocEvent {
  final isFirst;
  final searchText;
  NewsBlocEventFetch({required this.isFirst, this.searchText = ""});
}
