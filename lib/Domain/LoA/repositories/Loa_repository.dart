import 'package:SummitDocs/Data/LoA/models/update_loa_params.dart';
import 'package:dartz/dartz.dart';

abstract class LoaRepository {
  //icicyta
  Future<Either> createLOA(UpdateLoaParams params);
  Future<Either> getAllLoa();

  //icodsa
  Future<Either> getAllIcodsaLoa();
  Future<Either> createIcodsaLOA(UpdateLoaParams params);
}
