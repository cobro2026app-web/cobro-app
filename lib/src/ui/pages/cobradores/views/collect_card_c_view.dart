import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal/src/common/utils/contact_util.dart';
import 'package:personal/src/ui/pages/cobradores/cubit/cobrador_cubit.dart';
import 'package:personal/src/ui/pages/cobradores/views/corbador_detalle_view.dart';
import 'package:personal/src/ui/pages/cobradores/views/status_collect_card.dart';

class CollectCardCView extends StatelessWidget {
  final String name;
  final String route;
  final String id;
  final String phone;
  final int clients;
  final String collected;
  final String avatar;
  final bool active;
  const CollectCardCView({
    super.key,
    required this.name,
    required this.route,
    required this.clients,
    required this.collected,
    required this.avatar,
    required this.active,
    required this.phone,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withValues(alpha: .04)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .045),
            blurRadius: 16,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ------------------------------------------------
              // AVATAR
              // ------------------------------------------------
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F4FF),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(avatar, style: const TextStyle(fontSize: 25)),
                ),
              ),

              const SizedBox(width: 12),

              // ------------------------------------------------
              // INFO
              // ------------------------------------------------
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFF202838),
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),

                        const SizedBox(width: 7),

                        StatusCollectCard(active: active),
                      ],
                    ),

                    const SizedBox(height: 5),

                    Text(
                      '$route · $clients clientes',
                      style: const TextStyle(
                        color: Color(0xFF7B8494),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAFBF3),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      collected,
                      style: const TextStyle(
                        color: Color(0xFF00A86B),
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Recaudado hoy',
                      style: TextStyle(color: Color(0xFF7B8494), fontSize: 10),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              _actionButton(
                action: () {
                  ContactUtil.open(telefono: phone, action: ContactAction.call);
                },
                icon: Icons.phone_outlined,
                color: const Color(0xFF4F7CFF),
              ),

              const SizedBox(width: 8),

              _actionButton(
                action: () {
                  context.read<CobradorCubit>().detalleCobrador(id);
                  context.read<CobradorCubit>().eventChild(
                    CobradorDetalleView(),
                  );
                },

                icon: Icons.visibility,
                color: const Color(0xFFFFA62B),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required Function() action,
    required IconData icon,
    required Color color,
  }) {
    return GestureDetector(
      onTap: action,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withValues(alpha: .09),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 19),
      ),
    );
  }
}
