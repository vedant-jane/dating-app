import 'package:flutter_test/flutter_test.dart';
import 'package:dating_app/main.dart';
import 'package:dating_app/data/repositories/user_repository_impl.dart';
import 'package:dating_app/data/datasources/user_remote_datasource.dart';

void main() {
  test('UserRemoteDataSource fetches profiles successfully', () async {
    final remoteDataSource = UserRemoteDataSourceImpl();
    final users = await remoteDataSource.fetchHomeUsers();
    expect(users.isNotEmpty, true);
    expect(users.first.name.isNotEmpty, true);
  });

  testWidgets('App initializes smoke test', (WidgetTester tester) async {
    final remoteDataSource = UserRemoteDataSourceImpl();
    final userRepository = UserRepositoryImpl(remoteDataSource: remoteDataSource);

    await tester.pumpWidget(DatingApp(userRepository: userRepository));
    expect(find.byType(DatingApp), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 2500));
    await tester.pump(const Duration(milliseconds: 500));
  });
}
