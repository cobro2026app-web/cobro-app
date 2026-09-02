import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal/src/common/theme/theme.dart';
import 'package:personal/src/ui/pages/rutas/cubit/ruta_cubit.dart';
import 'package:personal/src/ui/pages/rutas/views/crear_ruta_view.dart';
import 'package:personal/src/ui/pages/rutas/views/ruta_detalle_view.dart';
import 'package:personal/src/ui/pages/rutas/views/ruta_home.dart';
import 'package:personal/src/ui/views/form_client_view.dart';

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
            final c = context.read<RutaCubit>();
            return Scaffold(
              backgroundColor: const Color(0xFFF5F7FC),

              floatingActionButton: Visibility(
                visible:
                    state.child is RutaHome || state.child is RutaDetalleView,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    if (state.child is RutaDetalleView) {
                      c.onEventChild(
                        Scaffold(
                          appBar: AppBar(
                            leading: IconButton(
                              onPressed: () {
                                c.onEventChild(RutaHome());
                              },
                              icon: Icon(Icons.arrow_back, color: Colors.white),
                            ),
                            backgroundColor: AppTheme.primaryColor,
                            title: Text(
                              "Nuevo cliente",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          body: FormClientView(
                            action: (e) {
                              c.crearCliente(e);
                            },
                            onBack: () {
                              c.onEventChild(RutaHome());
                            },
                          ),
                        ),
                      );
                      return;
                    }
                    c.clear();
                    c.onEventChild(CrearRutaView());
                  },
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  icon: const Icon(Icons.add_rounded),
                  label: Text(
                    state.child is RutaDetalleView
                        ? "Agregar cliente"
                        : 'Nueva ruta',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
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
