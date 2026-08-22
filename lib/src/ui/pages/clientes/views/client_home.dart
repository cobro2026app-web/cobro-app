import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal/src/ui/pages/clientes/cubit/cliente_cubit.dart';
import 'package:personal/src/ui/pages/clientes/views/client_card_view.dart';
import 'package:personal/src/ui/pages/clientes/views/filter_client_view.dart';
import 'package:personal/src/ui/pages/clientes/views/header_cliente_view.dart';
import 'package:personal/src/ui/pages/clientes/views/search_cliente_view.dart';

class ClientHome extends StatelessWidget {
  const ClientHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClienteCubit, ClienteState>(
      builder: (context, state) {
        return Column(
          children: [
            HeaderClienteView(),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 30),
                children: [
                  SearchClienteView(),

                  const SizedBox(height: 18),

                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          '6 clientes encontrados',
                          style: TextStyle(
                            color: Color(0xFF929BAB),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      FilterClientView(),
                    ],
                  ),

                  const SizedBox(height: 12),
                  ...state.clientes!.map(
                    (c) => Container(
                      margin: EdgeInsets.only(top: 14),
                      child: ClientCardView(
                        initials:
                            '${c.nombres.substring(0, 1).toUpperCase()}${c.apellidos.substring(0, 1).toUpperCase()}',
                        name: c.nombres,
                        document: 'CC ${c.cedula}',
                        route: 'Ruta Norte',
                        phone: c.telefono,
                        balance: '\$1.200.000',
                        active: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
