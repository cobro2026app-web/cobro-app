import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal/get_it.dart';
import 'package:personal/src/common/utils/app_dialog_util.dart';
import 'package:personal/src/domain/dto/crear_cliente_dto.dart';
import 'package:personal/src/domain/entities/cliente_entity.dart';
import 'package:personal/src/domain/repository/cliente_repo.dart';
import 'package:personal/src/ui/pages/clientes/views/client_home.dart';
import 'package:personal/src/ui/pages/home/cubit/home_cubit.dart';

part 'cliente_state.dart';

class ClienteCubit extends Cubit<ClienteState> {
  ///Repositorios
  ///
  ///

  final _clienteRepo = sl<ClienteRepository>();

  ///Constructor
  ///
  ///

  ClienteCubit(BuildContext context) : super(ClienteState(context: context)) {
    setChild(ClientHome());
    listClientes();
  }

  ///Variables
  ///
  ///
  final nameTxt = TextEditingController();
  final lastNameTxt = TextEditingController();
  final ideTxt = TextEditingController();
  final contactTxt = TextEditingController();
  final whatsappTxt = TextEditingController();
  final directionTxt = TextEditingController();
  final addressDescriptionTxt = TextEditingController();
  final barrioTxt = TextEditingController();
  final observationTxt = TextEditingController();

  ///Eventos
  ///
  ///
  void setChild(Widget child) {
    emit(state.copyWith(child: child));
  }

  ///Validaciones
  ///
  ///
  void enabledBtn() {
    final checkEnabled = [
      nameTxt,
      lastNameTxt,
      ideTxt,
      contactTxt,
      whatsappTxt,
      directionTxt,
      barrioTxt,
    ].every((text) => text.text.trim().isNotEmpty);
log("$checkEnabled");
    emit(state.copyWith(btnEnabled: checkEnabled));
  }

  ///Peticiones
  ///
  ///
  void listClientes() async {
    emit(state.copyWith(loading: true));
    final r = await _clienteRepo.listar();

    r.fold(
      (l) {
        AppDialogUtil.error(state.context, message: l.props[0].toString());
      },
      (r) {
        emit(state.copyWith(clientes: r.data));
        state.context.read<HomeCubit>().onGetClients(r.data);
      },
    );
    emit(state.copyWith(loading: false));
  }

  void crearCliente() async {
    emit(state.copyWith(loadingBtn: true));
    final r = await _clienteRepo.crear(
      dto: CrearClienteDto(
        nombres: nameTxt.text.trim(),
        apellidos: lastNameTxt.text.trim(),
        cedula: ideTxt.text.trim(),
        telefono: contactTxt.text.trim(),
        whatsapp: whatsappTxt.text.trim(),
        direccion: addressDescriptionTxt.text.trim(),
        descripcionDireccion: observationTxt.text.trim(),
      ),
    );
    r.fold(
      (l) {
        AppDialogUtil.error(state.context, message: l.props[0].toString());
      },
      (r) {
        AppDialogUtil.success(
          state.context,
          message: "Cliente creado con éxito.",
        );
        listClientes();
        setChild(ClientHome());
      },
    );
    emit(state.copyWith(loadingBtn: false));
  }

  ///Navegacion
  ///
  ///

  ///Otros
  ///
  ///
  ///
  void clear() {
    nameTxt.clear();
    lastNameTxt.clear();
    ideTxt.clear();
    contactTxt.clear();
    whatsappTxt.clear();
    directionTxt.clear();
    addressDescriptionTxt.clear();
    barrioTxt.clear();
    observationTxt.clear();

    emit(state.copyWith(btnEnabled: false));
  }

  @override
  Future<void> close() {
    nameTxt.dispose();
    lastNameTxt.dispose();
    ideTxt.dispose();
    contactTxt.dispose();
    whatsappTxt.dispose();
    directionTxt.dispose();
    addressDescriptionTxt.dispose();
    barrioTxt.dispose();
    observationTxt.dispose();
    return super.close();
  }
}
