part of 'properties_bloc.dart';

abstract class PropertiesEvent extends Equatable {
  const PropertiesEvent();

  @override
  List<Object?> get props => [];
}

class FetchNextPageRequested extends PropertiesEvent {
  final String? nextPage;

  const FetchNextPageRequested({this.nextPage});


  @override
  List<Object?> get props => [nextPage];
}
