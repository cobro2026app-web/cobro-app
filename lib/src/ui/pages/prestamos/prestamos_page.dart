import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal/src/ui/pages/prestamos/cubit/prestamo_cubit.dart';

class PrestamosPage extends StatefulWidget {
  const PrestamosPage({super.key});

  @override
  State<PrestamosPage> createState() => _PrestamosPageState();
}

class _PrestamosPageState extends State<PrestamosPage> {
  late PrestamoCubit _cubit;
  @override
  void initState() {
    super.initState();
    _cubit = PrestamoCubit(context);
    _cubit.listarPrestamo();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FC),
        body: BlocBuilder<PrestamoCubit, PrestamoState>(
          builder: (context, state) {
            return SafeArea(
              child: state.loading
                  ? Center(child: CircularProgressIndicator.adaptive())
                  : state.child,
            );
          },
        ),
      ),
    );
  }
}
