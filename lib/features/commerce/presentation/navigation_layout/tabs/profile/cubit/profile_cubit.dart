import 'package:E_Commerce/core/base/base_cubit.dart';
import 'package:E_Commerce/core/utils/resources.dart';
import 'package:E_Commerce/features/auth/data/models/user_data_dto.dart';
import 'package:E_Commerce/features/auth/domain/use_case/auth_use_case.dart';
import 'package:E_Commerce/features/commerce/presentation/navigation_layout/tabs/profile/cubit/profile_state.dart';
import 'package:E_Commerce/network/results.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileCubit extends BaseCubit<ProfileState, ProfileActions, ProfileNavigation>{
  ProfileCubit(this._authUseCase) : super(ProfileState());

  final AuthUseCase _authUseCase;

  @override
  Future<void> doActions(ProfileActions action) async{
    switch (action) {

      case GetProfileData():{
        _getUserData();
      }
      case Logout():{
        _logout();
      }
    }
  }

  Future<void> _getUserData() async{
    emit(state.copyWith(userData: const Resources.loading()));
    var response = await _authUseCase.getUserData();
    switch (response) {

      case Success<UserDataDto>():
        emit(state.copyWith(userData: Resources.success(data: response.data, message: response.message)));
      case Failure<UserDataDto>():
        emit(state.copyWith(userData: Resources.failure(exception: response.exception, message: response.errorMessage)));
    }
  }

  Future<void> _logout() async{
    await _authUseCase.logout();
    emit(state.copyWith(userData: const Resources.success(data: null, message: "Logout Done Successfully")));
    emitNavigation(NavigateToLoginScreen());

  }
}