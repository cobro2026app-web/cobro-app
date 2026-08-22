part of 'home_cubit.dart';

class HomeState extends Equatable {
  final BuildContext context;
  final int currentIndex;
  final List<DatumClEntity>? clientes;

  const HomeState({
    required this.context,
    this.currentIndex = 0,
    this.clientes,
  });

  @override
  List<Object?> get props => [
    context,
    currentIndex,
    clientes ?? [],
  ];
  HomeState copyWith({
    BuildContext? context,
    int? currentIndex,
    List<DatumClEntity>? clientes,
  }) {
    return HomeState(
      context: context ?? this.context,
      currentIndex: currentIndex ?? this.currentIndex,
      clientes: clientes ?? this.clientes,
    );
  }
}
