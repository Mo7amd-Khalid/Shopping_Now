abstract interface class AuthLocalDataSource {

  Future<void> saveToken(String token);

}