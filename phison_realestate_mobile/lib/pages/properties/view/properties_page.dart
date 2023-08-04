import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:phison_realestate_mobile/pages/home_page/view/property_card.dart';
import 'package:phison_realestate_mobile/repositories/properties_repository/properties_repository.dart';
import 'package:phison_realestate_mobile/shared/widgets/phison_app_bar.dart';

import '../../../api/property/models/property.dart';
import '../../../generated/l10n.dart';
import '../bloc/properties_bloc.dart';

class PropertiesPage extends StatefulWidget {
  final PropertiesRepository propertiesRepository;

  const PropertiesPage({super.key, required this.propertiesRepository});

  @override
  State<PropertiesPage> createState() => _PropertiesPageState();
}

class _PropertiesPageState extends State<PropertiesPage> {
  final PagingController<String?, Property> _pagingController =
      PagingController(firstPageKey: null);
  late final PropertiesBloc _propertiesBloc;

  @override
  void initState() {
    _propertiesBloc = PropertiesBloc(widget.propertiesRepository);
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(String? pageKey) async {
    _propertiesBloc.add(FetchNextPageRequested(nextPage: pageKey));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: S.of(context).ourProperties,
        hideLeading: true,
      ),
      body: BlocProvider(
        create: (context) => _propertiesBloc,
        child: BlocListener<PropertiesBloc, PropertiesState>(
          listener: (context, state) {
            if (state.status.isSubmissionSuccess) {
              final isLastPage = !state.hasNextPage;
              isLastPage
                  ? _pagingController.appendLastPage(state.properties)
                  : _pagingController.appendPage(
                      state.properties, state.endCursor);
            } else if (state.status.isSubmissionFailure) {
              _pagingController.error = state.error;
            }
          },
          child: PagedListView<String?, Property>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Property>(
              itemBuilder: (context, item, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: PropertyCard(
                  property: item,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
