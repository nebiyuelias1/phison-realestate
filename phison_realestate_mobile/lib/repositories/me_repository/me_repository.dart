import 'package:phison_realestate_mobile/api/me/me_api_client.dart';
import 'package:phison_realestate_mobile/api/me/models/phison_user.dart';

class MeRepository {
  final MeApiClient _apiClient;

  MeRepository(this._apiClient);

  Future<PhisonUser> getMe() async {
    return await _apiClient.getMe();
  }
}
