import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:personal/src/ui/pages/caja/views/abrir_caja_view.dart';

part 'caja_state.dart';

class CajaCubit extends Cubit<CajaState> {
  ///Repositorios
  ///
  ///

  ///Constructor
  CajaCubit({required BuildContext context})
    : super(CajaState(context: context)) {
    onGetChild(AbrirCajaView());
  }

  ///Variables
  ///
  ///
  final montoInicial = TextEditingController();

  ///Eventos
  ///
  void onGetChild(Widget c) {
    emit(state.copyWith(child: c));
  }

  ///Validaciones
  ///

  ///Peticiones
  ///

  //navegacion
  //

  ///Otros
}
