import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/infrastructure/infrastructure.dart';

final userRepositoryProvider = Provider((ref) => UsersRepositoryImp(usersDatasource: UsersLocalStorageDatasource()));
