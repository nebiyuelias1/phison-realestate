import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phison_realestate_mobile/pages/property_detail/bloc/property_detail_bloc.dart';
import 'package:phison_realestate_mobile/pages/property_detail/view/payment_info.dart';
import 'package:phison_realestate_mobile/pages/property_detail/view/property_location_map.dart';
import 'package:phison_realestate_mobile/pages/property_detail/view/property_media_toggle.dart';
import 'package:phison_realestate_mobile/repositories/properties_repository/properties_repository.dart';
import 'package:phison_realestate_mobile/shared/constants/app_assets_constant.dart';
import 'package:phison_realestate_mobile/shared/widgets/phison_app_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../api/property/models/property.dart';
import '../../../generated/l10n.dart';
import 'icon_row.dart';

class PropertyDetailPage extends StatefulWidget {
  final Property property;
  const PropertyDetailPage({super.key, required this.property});

  @override
  State<PropertyDetailPage> createState() => _PropertyDetailPageState();
}

class _PropertyDetailPageState extends State<PropertyDetailPage> {
  final _flexibleSpaceBarRadius = const Radius.circular(24.0);
  PropertyMediaTypes _currentActiveMediaType = PropertyMediaTypes.image;
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.property.video != null) {
      _currentActiveMediaType = PropertyMediaTypes.video;
      _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.property.video!)!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: true,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PropertyDetailBloc(
        property: widget.property,
        propertiesRepository: context.read<PropertiesRepository>(),
      )..add(
          GetPropertyDetailRequested(
            id: widget.property.id,
          ),
        ),
      child: Scaffold(
        body: BlocBuilder<PropertyDetailBloc, PropertyDetailState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: false,
                  snap: false,
                  floating: false,
                  expandedHeight: 200.0,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: _flexibleSpaceBarRadius,
                        bottomRight: _flexibleSpaceBarRadius,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: FlexibleSpaceBar(
                      background: _getBackground(state.property),
                    ),
                  ),
                  leading: const AppBarLeadingIcon(),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 8.0),
                ),
                SliverToBoxAdapter(
                  child: PropertyMediaToggle(
                    property: state.property,
                    onImagePlaybackRequested: () {
                      setState(() {
                        _currentActiveMediaType = PropertyMediaTypes.image;
                      });
                    },
                    onVideoPlaybackRequested: () {
                      setState(() {
                        _currentActiveMediaType = PropertyMediaTypes.video;
                      });
                    },
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 8.0),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.property.name,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Text(
                          widget.property.description,
                        ),
                        // TODO: Show property status and percentage
                        /**
                               *
                              Text(
                                'Charcteristics & Status',
                                style: Theme.of(context).textTheme.headline4!.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              const Text('Block Work'),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade400,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                height: 32,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 32,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: PhisonColors.purple.shade900,
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '42% Completed',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                               */
                        const SizedBox(
                          height: 8.0,
                        ),
                        IconRow(
                          property: widget.property,
                        ),
                        Text(
                          S.of(context).location,
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(
                                  8.0,
                                ),
                              ),
                              child: const Icon(
                                Icons.location_pin,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Expanded(
                              child: Text(
                                widget.property.address,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        PropertyLocationMap(
                          property: state.property,
                        ),
                        PaymentInfo(
                          property: state.property,
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _getBackground(Property property) {
    if (_currentActiveMediaType == PropertyMediaTypes.image) {
      return property.images.isEmpty
          ? Image.asset(
              'assets/images/welcomeImage.png',
              fit: BoxFit.cover,
            )
          : CarouselSlider(
              options: CarouselOptions(
                height: 450.0,
                autoPlay: true,
              ),
              items: property.images.map((p) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.network(p.image);
                  },
                );
              }).toList(),
            );
    }

    return _controller == null
        ? const SizedBox.shrink()
        : YoutubePlayer(
            controller: _controller!,
            showVideoProgressIndicator: true,
            progressColors: const ProgressBarColors(
              playedColor: PhisonColors.purple,
              handleColor: PhisonColors.purple,
            ),
          );
  }
}
