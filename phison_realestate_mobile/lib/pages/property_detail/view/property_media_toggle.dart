import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/shared/constants/app_assets_constant.dart';
import 'package:youtube/youtube_thumbnail.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../api/property/models/property.dart';

enum PropertyMediaTypes {
  video,
  image,
}

class PropertyMediaToggle extends StatefulWidget {
  final VoidCallback onVideoPlaybackRequested;
  final VoidCallback onImagePlaybackRequested;
  final Property property;

  const PropertyMediaToggle({
    super.key,
    required this.onVideoPlaybackRequested,
    required this.onImagePlaybackRequested,
    required this.property,
  });

  @override
  State<PropertyMediaToggle> createState() => _PropertyMediaToggleState();
}

class _PropertyMediaToggleState extends State<PropertyMediaToggle> {
  PropertyMediaTypes _currentType = PropertyMediaTypes.video;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.property.video != null)
          _VideoThumbnail(
            property: widget.property,
            onPlaybackRequested: () {
              setState(() {
                _currentType = PropertyMediaTypes.video;
                widget.onVideoPlaybackRequested();
              });
            },
            isActive: widget.property.video != null &&
                _currentType == PropertyMediaTypes.video,
          ),
        if (widget.property.video != null)
          const SizedBox(
            width: 8.0,
          ),
        _ImageThumbnail(
          property: widget.property,
          onPlaybackRequested: () {
            setState(() {
              _currentType = PropertyMediaTypes.image;
              widget.onImagePlaybackRequested();
            });
          },
          isActive: widget.property.video == null ||
              _currentType == PropertyMediaTypes.image,
        ),
      ],
    );
  }
}

class _VideoThumbnail extends StatelessWidget {
  final Property property;
  final VoidCallback onPlaybackRequested;
  final bool isActive;
  const _VideoThumbnail({
    required this.onPlaybackRequested,
    required this.isActive,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPlaybackRequested,
      child: Container(
        width: 56,
        height: 56,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              YoutubeThumbnail(
                youtubeId: YoutubePlayer.convertUrlToId(property.video!)!,
              ).mq(),
            ),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(16.0),
          ),
          color: Colors.transparent,
          border: isActive
              ? Border.all(color: PhisonColors.orange, width: 2.0)
              : null,
        ),
        child: Image.asset('assets/images/play-icon.png'),
      ),
    );
  }
}

class _ImageThumbnail extends StatelessWidget {
  final VoidCallback onPlaybackRequested;
  final bool isActive;
  final Property property;

  const _ImageThumbnail({
    required this.onPlaybackRequested,
    required this.isActive,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPlaybackRequested,
      child: Container(
        width: 56,
        height: 56,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: _getImage(),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(16.0),
          ),
          color: Colors.transparent,
          border: isActive
              ? Border.all(color: PhisonColors.orange, width: 2.0)
              : null,
        ),
        child: property.images.isNotEmpty
            ? const Icon(
                Icons.photo_library,
                color: Colors.white,
              )
            : null,
      ),
    );
  }

  ImageProvider<Object> _getImage() {
    if (property.propertyImage == null) {
      return const AssetImage('assets/images/welcomeImage.png');
    }

    return NetworkImage(property.propertyImage!);
  }
}
