part of 'show_cubit.dart';

@immutable
sealed class ShowState {}

final class ShowInitial extends ShowState {}

final class Loading extends ShowState {}

final class DoneState extends ShowState {}

final class GetUrlsState extends ShowState {}

final class GetInfoTextState extends ShowState {}

final class SwiperIndexChangedState extends ShowState {}
