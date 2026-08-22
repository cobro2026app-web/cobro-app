import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:personal/get_it.dart';
import 'package:personal/src/common/shared/shared.dart';
import 'package:personal/src/common/utils/app_dialog_util.dart';
import 'package:personal/src/domain/dto/ruta_dto.dart';
import 'package:personal/src/domain/entities/cobrador_entity.dart';
import 'package:personal/src/domain/entities/ruta_entity.dart';
import 'package:personal/src/domain/repository/ruta_repo.dart';
import 'package:personal/src/domain/repository/usuario_repo.dart';
import 'package:personal/src/ui/pages/rutas/views/ruta_home.dart';

part 'ruta_state.dart';

class RutaCubit extends Cubit<RutaState> {
  final _cobradorRepo = sl<UsuarioRepository>();
  final _rutaRepo = sl<RutaRepo>();
  RutaCubit({required BuildContext context})
    : super(RutaState(context: context)) {
    onEventChild(RutaHome());
    getCobrador();
    listarRutas();
  }

  final nombreRuta = TextEditingController();
  final descripcionRuta = TextEditingController();

  void onEventChild(Widget child) {
    emit(state.copyWith(child: child));
  }

  void onGetCobrador(DatumCEntity c) {
    emit(state.copyWith(cobrador: c));
  }

  void enabledBtn() {
    bool e = false;
    if (nombreRuta.text.isNotEmpty &&
        descripcionRuta.text.isNotEmpty &&
        state.cobrador != null) {
      e = true;
    }
    emit(state.copyWith(enabled: e));
  }

  void listarRutas() async {
    emit(state.copyWith(loading: true));
    final r = await _rutaRepo.listar();
    r.fold(
      (l) {
        AppDialogUtil.error(state.context, message: l.props[0].toString());
      },
      (r) {
        emit(state.copyWith(rutas: r.data));
        Shared.setRutas = r.data;
      },
    );
    emit(state.copyWith(loading: false));
  }

  void getCobrador() async {
    if (Shared.getCobradores == null) {
      final r = await _cobradorRepo.listarCobradores();
      r.fold((l) {}, (r) {
        Shared.setCobradores = r.data;
      });
    }
  }

  void crearRuta() async {
    emit(state.copyWith(loadingBtn: true));
    final r = await _rutaRepo.crear(
      dto: RutaDto(
        nombre: nombreRuta.text,
        descripcion: descripcionRuta.text,
        cobradorId: state.cobrador!.id,
        habilitada: true,
      ),
    );
    r.fold(
      (l) {
        AppDialogUtil.error(state.context, message: l.props[0].toString());
      },
      (r) {
        AppDialogUtil.success(state.context, message: "Operación exitosa.");
        onEventChild(RutaHome());
        listarRutas();
      },
    );
    emit(state.copyWith(loadingBtn: false));
  }
}
