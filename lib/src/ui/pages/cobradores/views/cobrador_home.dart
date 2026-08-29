import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal/src/common/shared/shared.dart';
import 'package:personal/src/ui/pages/cobradores/cubit/cobrador_cubit.dart';
import 'package:personal/src/ui/pages/cobradores/views/collect_card_c_view.dart';
import 'package:personal/src/ui/pages/cobradores/views/header_c_ciew.dart';
import 'package:personal/src/ui/pages/cobradores/views/section_header_c_view.dart';

class CobradorHome extends StatelessWidget {
  const CobradorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CobradorCubit, CobradorState>(
      builder: (context, state) {
        return Column(
          children: [
            HeaderCCiew(),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                children: [
                  SectionHeaderCView(),

                  ...state.cobradores!.map(
                    (c) => Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      child: CollectCardCView(
                        name: c.nombre,
                        phone: c.telefono,
                        id: c.id,
                        route:
                            Shared.getRutas!
                                .where((e) => e.cobrador?.id == c.id)
                                .map((e) => e.nombre)
                                .firstOrNull ??
                            'Sin ruta',

                        clients: 18,
                        collected: '\$3.100.000',
                        avatar: '👩‍💼',
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
