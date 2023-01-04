import 'package:flutter/material.dart';
import 'package:phison_realestate_mobile/presentation/constants/app_assets_constant.dart';

enum PropertyMediaTypes {
  video,
  image,
}

class PropertyMediaToggle extends StatefulWidget {
  final VoidCallback onVideoPlaybackRequested;
  final VoidCallback onImagePlaybackRequested;

  const PropertyMediaToggle({
    super.key,
    required this.onVideoPlaybackRequested,
    required this.onImagePlaybackRequested,
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
        _VideoThumbnail(
          onPlaybackRequested: () {
            setState(() {
              _currentType = PropertyMediaTypes.video;
              widget.onVideoPlaybackRequested();
            });
          },
          isActive: _currentType == PropertyMediaTypes.video,
        ),
        const SizedBox(
          width: 8.0,
        ),
        _ImageThumbnail(
          onPlaybackRequested: () {
            setState(() {
              _currentType = PropertyMediaTypes.image;
              widget.onImagePlaybackRequested();
            });
          },
          isActive: _currentType == PropertyMediaTypes.image,
        ),
      ],
    );
  }
}

class _VideoThumbnail extends StatelessWidget {
  final VoidCallback onPlaybackRequested;
  final bool isActive;
  const _VideoThumbnail({
    required this.onPlaybackRequested,
    required this.isActive,
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
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              'assets/images/welcomeImage.png',
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

  const _ImageThumbnail({
    required this.onPlaybackRequested,
    required this.isActive,
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
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              'assets/images/welcomeImage.png',
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
      ),
    );
  }
}
