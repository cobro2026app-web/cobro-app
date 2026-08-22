part of 'cliente_cubit.dart';

class ClienteState extends Equatable {
  final BuildContext context;
  final Widget child;
  final bool loading;
  final bool btnEnabled;
  final bool loadingBtn;
  final List<DatumClEntity>? clientes;
  final DatumREntity? ruta;

  const ClienteState({
    required this.context,
    this.loading = false,
    this.btnEnabled = false,
    this.loadingBtn = false,
    this.child = const SizedBox(),
    this.clientes,
    this.ruta,
  });

  @override
  List<Object?> get props => [
    context,
    loading,
    btnEnabled,
    child,
    clientes ?? [],
    loadingBtn,
    ruta,
  ];

  ClienteState copyWith({
    BuildContext? context,
    bool? loading,
    bool? loadingBtn,
    bool? btnEnabled,
    Widget? child,
    List<DatumClEntity>? clientes,
    DatumREntity? ruta,
  }) {
    return ClienteState(
      context: context ?? this.context,
      loading: loading ?? this.loading,
      btnEnabled: btnEnabled ?? this.btnEnabled,
      child: child ?? this.child,
      clientes: clientes ?? this.clientes,
      loadingBtn: loadingBtn ?? this.loadingBtn,
      ruta: ruta ?? this.ruta,
    );
  }
}
