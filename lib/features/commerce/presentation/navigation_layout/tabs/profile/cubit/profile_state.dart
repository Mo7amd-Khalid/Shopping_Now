import 'package:E_Commerce/core/utils/resources.dart';
import 'package:E_Commerce/features/auth/data/models/user_data_dto.dart';

class ProfileState {
  Resources<UserDataDto> userData;
  ProfileState({this.userData = const Resources.initial()});

  ProfileState copyWith({Resources<UserDataDto>? userData})
  {
    return ProfileState(userData: userData ?? this.userData);
  }
}

sealed class ProfileActions{}

class GetProfileData extends ProfileActions{}

class Logout extends ProfileActions{}

sealed class ProfileNavigation{}

class NavigateToLoginScreen extends ProfileNavigation{}