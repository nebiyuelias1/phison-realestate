// Flutter imports:
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phison_realestate_mobile/pages/app/bloc/bloc/app_bloc.dart';
import 'package:phison_realestate_mobile/pages/main/view/main_page.dart';
import 'package:phison_realestate_mobile/pages/welcome/view/view.dart';

//project imports:
import '../../../repositories/authentication_repository/authentication_repository.dart';
import '../../../shared/theme/phison_theme.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PHISON',
      theme: PhisonTheme.lightTheme,
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: (AppStatus state, List<Page<dynamic>> pages) {
          switch (state) {
            case AppStatus.authenticated:
              return [MainPage.page()];
            case AppStatus.unauthenticated:
            default:
              return [WelcomePage.page()];
          }
        },
      ),
    );
  }
}
