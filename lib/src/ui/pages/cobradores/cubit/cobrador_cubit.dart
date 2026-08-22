import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:personal/get_it.dart';
import 'package:personal/src/common/shared/shared.dart';
import 'package:personal/src/common/utils/app_dialog_util.dart';
import 'package:personal/src/domain/dto/crear_cobrador_dto.dart';
import 'package:personal/src/domain/entities/cobrador_entity.dart';
import 'package:personal/src/domain/repository/usuario_repo.dart';
import 'package:personal/src/ui/pages/cobradores/views/cobrador_home.dart';

part 'cobrador_state.dart';

class CobradorCubit extends Cubit<CobradorState> {
  ///Repositorios
  ///
  ///
  final _usuarioRepo = sl<UsuarioRepository>();

  ///Constructor
  ///
  ///
  CobradorCubit({required BuildContext context})
    : super(CobradorState(context: context)) {
    eventChild(CobradorHome());
    listarCobrador();
  }

  ///Variables
  ///
  ///
  final nameTxt = TextEditingController();
  final lastNameTxt = TextEditingController();
  final ideTxt = TextEditingController();
  final contacTxt = TextEditingController();
  final userTxt = TextEditingController();
  final passTxt = TextEditingController();

  ///Eventos
  ///
  ///
  void eventChild(Widget child) {
    emit(state.copyWith(child: child));
  }

  void onShowPassword() {
    emit(state.copyWith(showPass: !state.showPass));
  }

  ///Validaciones
  ///
  ///
  void enbaledBtn() {
    final checkEnabled = [
      nameTxt,
      lastNameTxt,
      ideTxt,
      contacTxt,
      userTxt,
      passTxt,
    ].every((text) => text.text.trim().isNotEmpty);
    emit(state.copyWith(btnEnabled: checkEnabled));
  }

  ///Peticiones
  ///
  ///
  void listarCobrador() async {
    emit(state.copyWith(loading: true));
    final r = await _usuarioRepo.listarCobradores();
    r.fold(
      (l) {
        AppDialogUtil.error(state.context, message: l.props[0].toString());
      },
      (r) {
        emit(state.copyWith(cobradores: r.data));
        Shared.setCobradores = r.data;
      },
    );

    emit(state.copyWith(loading: false));
  }

  void crearCobrador() async {
    emit(state.copyWith(loadingbtn: true));
    final r = await _usuarioRepo.crearCobrador(
      dto: CrearCobradorDto(
        nombre: nameTxt.text.trim(),
        apellido: lastNameTxt.text.trim(),
        telefono: contacTxt.text.trim(),
        username: userTxt.text.trim(),
        password: passTxt.text.trim(),
        documento: ideTxt.text.trim(),
      ),
    );
    r.fold(
      (l) {
        AppDialogUtil.error(state.context, message: l.props[0].toString());
      },
      (e) {
        AppDialogUtil.success(
          state.context,
          message: "Cobrador creado con éxito.",
        );
        listarCobrador();
        eventChild(CobradorHome());
      },
    );
    emit(state.copyWith(loadingbtn: false));
  }

  ///Navegacion
  ///
  ///

  ///Otros
  ///
  ///
  void clear() {
    nameTxt.clear();
    lastNameTxt.clear();
    ideTxt.clear();
    contacTxt.clear();
    userTxt.clear();
    passTxt.clear();
    emit(state.copyWith(btnEnabled: false));
  }

  @override
  Future<void> close() {
    nameTxt.dispose();
    lastNameTxt.dispose();
    ideTxt.dispose();
    contacTxt.dispose();
    userTxt.dispose();
    passTxt.dispose();
    return super.close();
  }
}
