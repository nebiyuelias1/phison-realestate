import 'package:phison_realestate_mobile/repositories/core/params.dart';

class NotificationQueryParam extends ItemQueryParam {
  final bool? isRead;

  NotificationQueryParam({this.isRead, String? after}) : super(after: after);
}
