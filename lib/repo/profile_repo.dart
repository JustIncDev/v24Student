import 'package:firebase_auth/firebase_auth.dart';
import 'package:v24_student_app/domain/base.dart';
import 'package:v24_student_app/domain/user_profile.dart';
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

  Future<UserProfile?> editProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? country,
    String? avatar,
  }) {
    var requestData = UserProfile(
      firstName: firstName,
      lastName: lastName,
      firebaseEmail: FirebaseEmail(email, false),
      country: country,
      profilePicture: avatar,
      id: FirebaseAuth.instance.currentUser?.uid,
    );
    return _profileRemoteProvider.editProfile(requestData).then((profile) async {
      Log.info('Edit profile success');
      emitDataNotification(OwnerProfileDataNotification(profile: profile));
      return profile;
    }).catchError((e, s) {
      Log.error('Edit profile error: ', exc: e, stackTrace: s);
      // throw AppException.map(exp: e, stackTrace: s);
      throw Exception();
    });
  }
}
