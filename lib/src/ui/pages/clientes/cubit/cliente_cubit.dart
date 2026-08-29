import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal/get_it.dart';
import 'package:personal/src/common/shared/shared.dart';
import 'package:personal/src/common/utils/app_dialog_util.dart';
import 'package:personal/src/common/utils/update_util.dart';
import 'package:personal/src/domain/dto/crear_cliente_dto.dart';
import 'package:personal/src/domain/entities/cliente_entity.dart';
import 'package:personal/src/domain/entities/ruta_entity.dart';
import 'package:personal/src/domain/repository/cliente_repo.dart';
import 'package:personal/src/domain/repository/ruta_repo.dart';
import 'package:personal/src/ui/pages/clientes/views/client_home.dart';
import 'package:personal/src/ui/pages/clientes/views/cliente_detalle_view.dart';
import 'package:personal/src/ui/pages/home/cubit/home_cubit.dart';

part 'cliente_state.dart';

class ClienteCubit extends Cubit<ClienteState> {
  ///Repositorios
  ///
  ///

  final _clienteRepo = sl<ClienteRepository>();
  final _rutaRepo = sl<RutaRepo>();

  ///Constructor
  ///
  ///

  ClienteCubit(BuildContext context) : super(ClienteState(context: context)) {
    setChild(ClientHome());
    listarRuta();
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

  void onEventRuta(DatumREntity r) {
    emit(state.copyWith(ruta: r));
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
    emit(state.copyWith(btnEnabled: checkEnabled && state.ruta != null));
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
        rutaId: state.ruta!.id,
        nombres: nameTxt.text.trim(),
        apellidos: lastNameTxt.text.trim(),
        cedula: ideTxt.text.trim(),
        telefono: contactTxt.text.trim(),
        whatsapp: whatsappTxt.text.trim(),
        barrio: barrioTxt.text,
        observacion: observationTxt.text,
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

  void listarRuta() async {
    if (Shared.getRutas != null) return;
    final r = await _rutaRepo.listar();
    r.fold((l) {}, (r) {
      Shared.setRutas = r.data;
    });
  }

  void editarCliente() async {
    emit(state.copyWith(loadingBtn: true));

    final cliente = state.cliente;

    if (cliente == null) {
      emit(state.copyWith(loadingBtn: false));
      return;
    }

    final dto = CrearClienteDto(
      rutaId: UpdateUtil.valorModificado(cliente.rutaId, state.ruta?.id),

      nombres: UpdateUtil.valorModificado(cliente.nombres, nameTxt.text.trim()),

      apellidos: UpdateUtil.valorModificado(
        cliente.apellidos,
        lastNameTxt.text.trim(),
      ),

      cedula: UpdateUtil.valorModificado(cliente.cedula, ideTxt.text.trim()),

      telefono: UpdateUtil.valorModificado(
        cliente.telefono,
        contactTxt.text.trim(),
      ),

      whatsapp: UpdateUtil.valorModificado(
        cliente.whatsapp,
        whatsappTxt.text.trim(),
      ),

      direccion: UpdateUtil.valorModificado(
        cliente.direccion,
        addressDescriptionTxt.text.trim(),
      ),

      descripcionDireccion: UpdateUtil.valorModificado(
        cliente.descripcionDireccion,
        observationTxt.text.trim(),
      ),
      barrio: UpdateUtil.valorModificado(cliente.barrio, barrioTxt.text),
      observacion: UpdateUtil.valorModificado(
        cliente.observacion,
        observationTxt.text,
      ),
    );

    final r = await _clienteRepo.editar(dto: dto, id: state.cliente!.id);

    r.fold(
      (l) {
        AppDialogUtil.error(state.context, message: l.props[0].toString());
      },
      (r) {
        AppDialogUtil.success(
          state.context,
          message: "Cliente editado con éxito.",
        );

        listClientes();
        setChild(ClientHome());
      },
    );

    emit(state.copyWith(loadingBtn: false));
  }

  void detalleCliente(String id) async {
    emit(state.copyWith(loading: true));
    final r = await _clienteRepo.obtenerCliente(id: id);
    r.fold(
      (l) {
        AppDialogUtil.error(state.context, message: l.props[0].toString());
      },
      (r) {
        emit(state.copyWith(cliente: r, child: ClienteDetalleView()));
      },
    );
    emit(state.copyWith(loading: false));
  }
  void buscar(String q)async{
    emit(state.copyWith(search: true));
    final r = await _clienteRepo.buscar(q: q);
    r.fold((l){}, (r){
      emit(state.copyWith(clientes: r.data));
    });
    emit(state.copyWith(search: false));


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

    emit(state.copyWith(btnEnabled: false, limpiarRuta: true));
  }

  void loadInfo() {
    final c = state.cliente!;
    nameTxt.text = c.nombres;
    lastNameTxt.text = c.apellidos;
    ideTxt.text = c.cedula;
    contactTxt.text = c.telefono;
    whatsappTxt.text = c.whatsapp;
    directionTxt.text = c.direccion;
    addressDescriptionTxt.text = c.descripcionDireccion;
    barrioTxt.text = c.barrio;
    observationTxt.text = c.observacion;
    emit(
      state.copyWith(
        ruta: Shared.getRutas!.firstWhere((e) => e.id == c.rutaId),
      ),
    );
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
