import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:phison_realestate_mobile/pages/home_page/bloc/home_bloc.dart';
import 'package:phison_realestate_mobile/pages/home_page/view/home_page_app_bar.dart';
import 'package:phison_realestate_mobile/pages/home_page/view/property_card.dart';
import 'package:phison_realestate_mobile/repositories/properties_repository/properties_repository.dart';
import 'package:phison_realestate_mobile/shared/constants/app_assets_constant.dart';

class HomePage extends StatelessWidget {
  const HomePage(
      {super.key, required PropertiesRepository propertiesRepository})
      : _propertiesRepository = propertiesRepository;
  final PropertiesRepository _propertiesRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getHomePageAppBar(context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: BlocProvider(
          create: (context) => HomeBloc(_propertiesRepository)
            ..add(FeaturedPropertiesQueryRequested())
            ..add(PropertiesQueryRequested()),
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
                      'Our Properties',
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
                              child: const Text('Try Again'),
                            )
                          ],
                        ),
                      ),
                    );
                  } else if (state.properties.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Text('🙁 No properties to show at the moment'),
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
                    child: const Text('Try Again'))
              ],
            ),
          );
        } else if (state.featuredProperties.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Featured Properties',
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
