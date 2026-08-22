import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal/src/common/theme/theme.dart';
import 'package:personal/src/ui/pages/rutas/cubit/ruta_cubit.dart';
import 'package:personal/src/ui/pages/rutas/views/crear_ruta_view.dart';

class RutaPage extends StatefulWidget {
  const RutaPage({super.key});

  @override
  State<RutaPage> createState() => _RutaPageState();
}

class _RutaPageState extends State<RutaPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RutaCubit(context: context),
      child: SafeArea(
        child: BlocBuilder<RutaCubit, RutaState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: const Color(0xFFF5F7FC),

              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  context.read<RutaCubit>().onEventChild(CrearRutaView());
                },
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                icon: const Icon(Icons.add_rounded),
                label: const Text(
                  'Nueva ruta',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),

              body: state.loading
                  ? Center(child: CircularProgressIndicator.adaptive())
                  : state.child,
            );
          },
        ),
      ),
    );
  }
}

// ============================================================
// MODEL
// ============================================================
