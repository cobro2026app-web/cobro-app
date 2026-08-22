import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal/src/ui/pages/prestamos/cubit/prestamo_cubit.dart';

class PrestamosPage extends StatelessWidget {
  const PrestamosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PrestamoCubit(context),
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
