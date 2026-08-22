import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:personal/src/domain/entities/cliente_entity.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  ///Repositorios
  ///
  ///

  ///Constructor
  HomeCubit({required BuildContext context})
    : super(HomeState(context: context));

  ///Variables
  ///
  ///
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  ///Eventos
  ///
  ///
  void onCurrenteIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  void onGetClients(List<DatumClEntity> c) {
    emit(state.copyWith(clientes: c));
  }

 

  ///Validaciones
  ///
  ///

  ///Peticiones
  ///
  ///

  ///Navegacion
  ///
  ///

  ///Otros
  ///
  ///
}
