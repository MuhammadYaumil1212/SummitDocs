import 'package:SummitDocs/Data/LoA/models/update_loa_params.dart';
import 'package:dartz/dartz.dart';

abstract class LoaRepository {
  Future<Either> updateLOA(UpdateLoaParams params);
  Future<Either> createLOA(UpdateLoaParams params);
  Future<Either> getAllLoa();
}
