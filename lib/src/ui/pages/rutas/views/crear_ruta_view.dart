import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal/src/common/shared/shared.dart';
import 'package:personal/src/common/theme/theme.dart';
import 'package:personal/src/domain/entities/cobrador_entity.dart';
import 'package:personal/src/ui/pages/rutas/cubit/ruta_cubit.dart';
import 'package:personal/src/ui/pages/rutas/views/cobrador_searchDelegate.dart';
import 'package:personal/src/ui/pages/rutas/views/ruta_home.dart';
import 'package:personal/src/ui/widgets/btn_widget.dart';

class CrearRutaView extends StatelessWidget {
  const CrearRutaView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RutaCubit, RutaState>(
      builder: (context, state) {
        final c = context.read<RutaCubit>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppTheme.primaryColor,
            title: Text("Crear ruta", style: TextStyle(color: Colors.white)),
            leading: IconButton(
              onPressed: () {
                context.read<RutaCubit>().onEventChild(RutaHome());
              },
              icon: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                const Text(
                  'Configura la ruta y asigna un cobrador.',
                  style: TextStyle(color: Color(0xFF929BAB), fontSize: 14),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: c.nombreRuta,
                  decoration: _inputDecoration(
                    'Nombre de la ruta',
                    Icons.route_outlined,
                  ),
                  onChanged: (e) {
                    c.enabledBtn();
                  },
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: c.descripcionRuta,
                  maxLines: 2,
                  decoration: _inputDecoration(
                    'Descripción / zona',
                    Icons.location_on_outlined,
                  ),
                  onChanged: (e) {
                    c.enabledBtn();
                  },
                ),

                const SizedBox(height: 12),

                GestureDetector(
                  onTap: () async {
                    final cobradores = Shared.getCobradores;

                    final cobrador = await showSearch<DatumCEntity?>(
                      context: context,
                      delegate: CobradorSearchDelegate(cobradores ?? []),
                    );

                    if (cobrador != null) {
                      c.onGetCobrador(cobrador);
                      c.enabledBtn();
                    }
                  },
                  child: InputDecorator(
                    decoration: _inputDecoration(
                      'Cobrador',
                      Icons.person_outline_rounded,
                    ),
                    child: Text(
                      state.cobrador != null
                          ? "${state.cobrador!.nombre} ${state.cobrador!.apellido}"
                          : 'Seleccionar cobrador',
                      style: const TextStyle(
                        color: Color(0xFF394354),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                BtnWidget.btn(
                  text: "Crear ruta",
                  enabled: state.enabled,
                  loading: state.loadingBtn,
                  onPressed: () {
                    context.read<RutaCubit>().crearRuta();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, size: 20),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }
}
