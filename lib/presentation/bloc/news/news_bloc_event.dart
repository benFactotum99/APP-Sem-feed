abstract class NewsBlocEvent {}

class NewsBlocEventFetch extends NewsBlocEvent {
  final isFirst;
  NewsBlocEventFetch({required this.isFirst});
}
