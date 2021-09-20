/**
 * Copyright (C) 2021
 *
 * Description: The file class
 *
 * Change history:
 * Date             Defect#             Person             Comments
 * -------------------------------------------------------------------------------
 * August 4, 2021     ********           HoangNCM            Initialize
 *
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmc_erp/events/favor_event.dart';
import 'package:gmc_erp/services/FavorService.dart';
import 'package:gmc_erp/states/favor_states.dart';

class FavorBloc extends Bloc<FavorEvent, FavorState> {

  final FavorService _favorService;

  //initial State
  FavorBloc(FavorService favorService)
      : assert(favorService != null),
        _favorService = favorService,
        super(FavorInitial()){
  }

  @override
  Stream<FavorState> mapEventToState(FavorEvent event)  async*{
    if (event is getFavorEvent) {

      final result =  await _favorService.getFavor();
      // Write value
      yield FavorSuccess(favor: result);
      return;
    }

    if (event is postFavorEvent) {
      String moduleName = event.moduleName;

      final result = await _favorService.postFavor(moduleName);
      yield FavorPostSuccess(favor: result);
      return;
    }

    if (event is deleteFavorEvent) {
      int id = event.id;

      final result = await _favorService.deleteFavor(id);
      yield FavorDeleteSuccess(id: result);
      return;
    }
  }
}