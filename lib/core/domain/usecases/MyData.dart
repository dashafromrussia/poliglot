import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/core/useCases.dart';
import 'package:poliglot/core/domain/repositoris/myData.dart';
import 'package:poliglot/entities/user.data.dart';

class GetMyData extends UseCase<List<User>,MyDataParams> {
  final MyInfoService myDataService;

 GetMyData({required this.myDataService});

  @override
  Future<Either<Failure,List<User>>>callData(MyDataParams params) async {
   return await myDataService.getMyData();
  }
}

class MyDataParams extends Equatable {

  const MyDataParams();

  @override
  List<Object> get props => [];
}
