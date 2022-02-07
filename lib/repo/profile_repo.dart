import 'package:v24_student_app/domain/user_profile.dart';
import 'package:v24_student_app/repo/base_repo.dart';
import 'package:v24_student_app/repo/provider/remote/profile_remote_provider.dart';

class ProfileRepo extends BaseRepo {
  ProfileRepo()
      : _profileRemoteProvider = ProfileRemoteProvider(),
        super();

  final ProfileRemoteProvider _profileRemoteProvider;

  Future<UserProfile?> getUserProfile() {
    return _profileRemoteProvider.getUserProfile();
  }
}
