import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:phison_realestate_mobile/api/notification/notification_api_client.dart';
import 'package:phison_realestate_mobile/generated/l10n.dart';
import 'package:phison_realestate_mobile/pages/home_page/bloc/home_bloc.dart';
import 'package:phison_realestate_mobile/pages/home_page/view/home_page_app_bar.dart';
import 'package:phison_realestate_mobile/pages/home_page/view/property_card.dart';
import 'package:phison_realestate_mobile/repositories/notification_repository/notification_repository.dart';
import 'package:phison_realestate_mobile/repositories/properties_repository/properties_repository.dart';
import 'package:phison_realestate_mobile/shared/constants/app_assets_constant.dart';

import '../../app/bloc/bloc/app_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {super.key, required PropertiesRepository propertiesRepository})
      : _propertiesRepository = propertiesRepository;
  final PropertiesRepository _propertiesRepository;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final NotificationRepository _notificationRepository;
  @override
  void initState() {
    super.initState();
    final token = context.read<AppBloc>().state.authToken;
    _notificationRepository = NotificationRepository(
        client: NotificationApiClient.create(authToken: token));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        propertiesRepository: widget._propertiesRepository,
        notificationRepository: _notificationRepository,
      )
        ..add(FeaturedPropertiesQueryRequested())
        ..add(PropertiesQueryRequested())
        ..add(UnreadNotificationsCountRequested()),
      child: Scaffold(
        appBar: getHomePageAppBar(
          context: context,
          notificationRepository: _notificationRepository,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: _FeaturedProperties(),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 8.0),
              ),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).ourProperties,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 8.0),
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state.status.isSubmissionInProgress) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: _ProgressIndicator(),
                      ),
                    );
                  } else if (state.status.isSubmissionFailure) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Column(
                          children: [
                            Text(state.error!),
                            TextButton(
                              onPressed: () => context
                                  .read<HomeBloc>()
                                  .add(PropertiesQueryRequested()),
                              child: Text(S.of(context).tryAgain),
                            )
                          ],
                        ),
                      ),
                    );
                  } else if (state.properties.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(S.of(context).noPropertiesToShowAtTheMoment),
                      ),
                    );
                  } else if (state.properties.isNotEmpty) {
                    return SliverGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      childAspectRatio: 0.75,
                      children: [
                        ...state.properties.map(
                          (e) => PropertyCard(
                            isVertical: true,
                            property: e,
                          ),
                        ),
                      ],
                    );
                  }

                  return const SliverToBoxAdapter();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _FeaturedProperties extends StatelessWidget {
  const _FeaturedProperties();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.featuredPropertiesStatus.isSubmissionInProgress) {
          return const Center(
            child: _ProgressIndicator(),
          );
        } else if (state.featuredPropertiesStatus.isSubmissionFailure) {
          return Center(
            child: Column(
              children: [
                Text(state.featuredPropertiesError!),
                TextButton(
                    onPressed: () => context
                        .read<HomeBloc>()
                        .add(FeaturedPropertiesQueryRequested()),
                    child: Text(S.of(context).tryAgain))
              ],
            ),
          );
        } else if (state.featuredProperties.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).featuredProperties,
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(
                height: 4.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...state.featuredProperties.map(
                      (e) => Container(
                        width: 310,
                        margin: const EdgeInsets.only(right: 8.0),
                        child: PropertyCard(
                          property: e,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          color: PhisonColors.purple,
        ),
      ),
    );
  }
}
