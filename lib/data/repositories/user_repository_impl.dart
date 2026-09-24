import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<UserProfile>> getHomeUsers() async {
    return await remoteDataSource.fetchHomeUsers();
  }
}
