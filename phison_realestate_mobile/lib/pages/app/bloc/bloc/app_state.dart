part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

const englishLocale = 'en';
const amharicLocale = 'am_ET';

enum LocaleOption { english, amharic }

const localeOptionMap = {
  LocaleOption.english: englishLocale,
  LocaleOption.amharic: amharicLocale,
};

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = User.empty,
    this.authToken,
    this.currentLocale = const Locale.fromSubtags(languageCode: 'en'),
  });

  const AppState.authenticated(User user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  final AppStatus status;
  final User user;
  final String? authToken;
  final Locale? currentLocale;

  AppState copyWith(
          {String? authToken,
          AppStatus? status,
          User? user,
          Locale? currentLocale}) =>
      AppState._(
          status: status ?? this.status,
          authToken: authToken ?? this.authToken,
          user: user ?? this.user,
          currentLocale: currentLocale ?? this.currentLocale);

  @override
  List<Object?> get props => [status, user, authToken, currentLocale];
}
