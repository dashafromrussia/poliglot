import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/core/useCases.dart';
import 'package:poliglot/entities/user.data.dart';
import 'package:poliglot/feature_update/domain/repositories/updateServiceData.dart';

class UpdateUser extends UseCase<bool, UpdateUserParams> {
  final UpdateServiceData updateService;

  UpdateUser({required this.updateService});

  @override
  Future<Either<Failure, bool>> callData(UpdateUserParams params) async {
    return await updateService.updateData(params.user);
  }
}

class UpdateUserParams extends Equatable {
final User user;
  const UpdateUserParams({required this.user});

  @override
  List<Object> get props => [user];
}
