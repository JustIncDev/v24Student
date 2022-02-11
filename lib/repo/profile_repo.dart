import 'package:v24_student_app/global/logger/logger.dart';
import 'package:v24_student_app/repo/base_repo.dart';
import 'package:v24_student_app/repo/provider/remote/profile_remote_provider.dart';

class ProfileRepo extends BaseRepo {
  ProfileRepo()
      : _profileRemoteProvider = ProfileRemoteProvider(),
        super();

  final ProfileRemoteProvider _profileRemoteProvider;

  Future<void> fetchProfile() {
    return _profileRemoteProvider.fetchProfile().then((profile) {
      emitDataNotification(OwnerProfileDataNotification(profile: profile));
      return null;
    }).catchError((e, s) {
      Log.error('Get profile error', exc: e, stackTrace: s);
    });
  }
}
