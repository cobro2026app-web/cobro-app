part of 'ruta_cubit.dart';

class RutaState extends Equatable {
  final BuildContext context;
  final Widget child;
  final bool loading;
  final DatumCEntity? cobrador;
  final bool loadingBtn;
  final bool enabled;
  final List<DatumREntity>? rutas;
  final List<DetalleRutaEntity>? clientes;
  const RutaState({
    required this.context,
    this.child = const SizedBox(),
    this.loading = false,
    this.cobrador,
    this.loadingBtn = false,
    this.enabled = false,
    this.rutas,
    this.clientes,
  });

  @override
  List<Object?> get props => [
    context,
    child,
    loading,
    cobrador,
    loadingBtn,
    rutas,
    enabled,
    clientes ?? [],
  ];

  RutaState copyWith({
    BuildContext? context,
    Widget? child,
    bool? loading,
    DatumCEntity? cobrador,
    bool? loadingBtn,
    bool? enabled,
    List<DatumREntity>? rutas,
    List<DetalleRutaEntity>? clientes,
    bool limpiarCobrador = false,
  }) => RutaState(
    context: context ?? this.context,
    child: child ?? this.child,
    loading: loading ?? this.loading,
    cobrador: limpiarCobrador ? null : cobrador ?? this.cobrador,
    loadingBtn: loadingBtn ?? this.loadingBtn,
    rutas: rutas ?? this.rutas,
    enabled: enabled ?? this.enabled,
    clientes: clientes ?? this.clientes,
  );
}
