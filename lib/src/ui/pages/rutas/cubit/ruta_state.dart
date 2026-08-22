part of 'ruta_cubit.dart';

class RutaState extends Equatable {
  final BuildContext context;
  final Widget child;
  final bool loading;
  final DatumCEntity? cobrador;
  final bool loadingBtn;
  final bool enabled;
  final List<DatumREntity>? rutas;
  const RutaState({
    required this.context,
    this.child = const SizedBox(),
    this.loading = false,
    this.cobrador,
    this.loadingBtn =false,
    this.enabled =false,
    this.rutas
  });

  @override
  List<Object?> get props => [context, child, loading, cobrador, loadingBtn, rutas,enabled];

  RutaState copyWith({
    BuildContext? context,
    Widget? child,
    bool? loading,
    DatumCEntity? cobrador,
    bool? loadingBtn,
    bool? enabled,
    List<DatumREntity>? rutas,
  }) => RutaState(
    context: context ?? this.context,
    child: child ?? this.child,
    loading: loading ?? this.loading,
    cobrador: cobrador ?? this.cobrador,
    loadingBtn: loadingBtn ?? this.loadingBtn,
    rutas:  rutas?? this.rutas,
    enabled:  enabled?? this.enabled,
  );
}
