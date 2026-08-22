part of 'prestamo_cubit.dart';

class PrestamoState extends Equatable {
  final BuildContext context;
  final Widget child;
  final bool listClientes;
  final DatumClEntity? cliente;
  final SCobroEntity? periodoSeleccionado;
  final DateTime? fechaInicial;
  final DateTime? fechaFinal;
  final List<DateTime>? fechasPago;
  final bool loading;
  final bool isPrevious;
  final bool loadingBtn;
  const PrestamoState({
    required this.context,
    this.child = const SizedBox(),
    this.listClientes = true,
    this.cliente,
    this.periodoSeleccionado,
    this.fechaInicial,
    this.fechaFinal,
    this.fechasPago,
    this.loading = false,
    this.isPrevious = false,
    this.loadingBtn = false,
  });

  @override
  List<Object?> get props => [
    context,
    listClientes,
    child,
    cliente,
    periodoSeleccionado,
    fechaInicial ?? DateTime.now(),
    fechaFinal,
    fechasPago,
    loading,
    isPrevious,
    loadingBtn,
  ];
  PrestamoState copyWith({
    BuildContext? context,
    bool? listClientes,
    Widget? child,
    DatumClEntity? cliente,
    SCobroEntity? periodoSeleccionado,
    DateTime? fechaInicial,
    DateTime? fechaFinal,
    List<DateTime>? fechasPago,
    bool? loading,
    bool? isPrevious,
    bool? loadingBtn,
  }) => PrestamoState(
    context: context ?? this.context,
    listClientes: listClientes ?? this.listClientes,
    child: child ?? this.child,
    cliente: cliente ?? this.cliente,
    periodoSeleccionado: periodoSeleccionado ?? this.periodoSeleccionado,
    fechaInicial: fechaInicial ?? this.fechaInicial,
    fechaFinal: fechaFinal ?? this.fechaFinal,
    fechasPago: fechasPago ?? this.fechasPago,
    loading: loading ?? this.loading,
    isPrevious: isPrevious ?? this.isPrevious,
    loadingBtn: loadingBtn ?? this.loadingBtn,
  );
}
