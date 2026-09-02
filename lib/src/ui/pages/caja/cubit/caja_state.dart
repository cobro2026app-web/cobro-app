part of 'caja_cubit.dart';

class CajaState extends Equatable {
  final BuildContext context;
  final Widget child;
  final bool loading;
  final bool btnLoading;
  const CajaState({
    required this.context,
    this.child = const SizedBox(),
    this.loading = false,
    this.btnLoading = false,
  });

  @override
  List<Object> get props => [context, loading, btnLoading, child];
  CajaState copyWith({
    BuildContext? context,
    Widget? child, 
    bool? loading,
    bool? btnLoading,
  }) => CajaState(
    context: context ?? this.context,
    child: child?? this.child,
    loading: loading ?? this.loading,
    btnLoading: btnLoading ?? this.btnLoading,
  );
}
