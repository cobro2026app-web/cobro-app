import 'package:flutter/material.dart';
import 'package:personal/src/domain/entities/pago_entity.dart';

Future<void> showPagosDialog({
  required BuildContext context,
  required List<PagoEntity> pagos,
}) {
  pagos.sort((a, b) => b.fechaPago!.compareTo(a.fechaPago!));
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Container(
          constraints: const BoxConstraints(maxHeight: 600),
          decoration: BoxDecoration(
            color: const Color(0xFFF6F7FB),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _dialogHeader(context, pagos),

              Flexible(
                child: pagos.isEmpty
                    ? _emptyPayments()
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                        shrinkWrap: true,
                        itemCount: pagos.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          return _paymentCard(pagos[index]);
                        },
                      ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _dialogHeader(BuildContext context, List<PagoEntity> pagos) {
  final aplicados = pagos
      .where((e) => e.estado == 'APLICADO')
      .fold<num>(0, (total, pago) => total + pago.valor);

  return Container(
    padding: const EdgeInsets.fromLTRB(18, 18, 12, 15),
    child: Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F4FF),
            borderRadius: BorderRadius.circular(13),
          ),
          child: const Icon(
            Icons.payments_outlined,
            color: Color(0xFF4164E8),
            size: 23,
          ),
        ),

        const SizedBox(width: 11),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pagos realizados',
                style: TextStyle(
                  color: Color(0xFF202838),
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                '${pagos.where((e) => e.estado == 'APLICADO').length} pagos • ${_formatMoney(aplicados)}',
                style: const TextStyle(color: Color(0xFF929BAB)),
              ),
            ],
          ),
        ),

        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.close_rounded,
            color: Color(0xFF8A93A3),
            size: 21,
          ),
        ),
      ],
    ),
  );
}

Widget _paymentCard(PagoEntity pago) {
  final reversado = pago.estado == 'REVERSADO';

  return Container(
    padding: const EdgeInsets.all(13),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.black.withValues(alpha: .05)),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: reversado
                ? const Color(0xFFFFF1F1)
                : const Color(0xFFEAF8EF),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(
            reversado ? Icons.undo_rounded : Icons.check_rounded,
            color: reversado ? const Color(0xFFE05252) : Colors.green,
            size: 20,
          ),
        ),

        const SizedBox(width: 11),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                reversado ? 'Pago reversado' : 'Pago realizado',
                style: const TextStyle(
                  color: Color(0xFF202838),
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                _formatDate(pago.fechaPago!),
                style: const TextStyle(color: Color(0xFF929BAB)),
              ),

              if (reversado && pago.motivoReversion != null) ...[
                const SizedBox(height: 3),
                Text(
                  pago.motivoReversion!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Color(0xFFE05252), fontSize: 9),
                ),
              ],
            ],
          ),
        ),

        const SizedBox(width: 8),

        Text(
          _formatMoney(pago.valor),
          style: TextStyle(
            color: reversado
                ? const Color(0xFFE05252)
                : const Color(0xFF202838),
            fontSize: 13,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    ),
  );
}

Widget _emptyPayments() {
  return const Padding(
    padding: EdgeInsets.all(35),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.payments_outlined, size: 42, color: Color(0xFFB8BFCC)),

        SizedBox(height: 10),

        Text(
          'Sin pagos registrados',
          style: TextStyle(
            color: Color(0xFF394354),
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
        ),

        SizedBox(height: 4),

        Text(
          'Este préstamo aún no tiene pagos.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFF929BAB), fontSize: 10),
        ),
      ],
    ),
  );
}

String _formatMoney(num value) {
  return '\$${value.toStringAsFixed(0)}';
}

String _formatDate(DateTime date) {
  final d = date.day.toString().padLeft(2, '0');
  final m = date.month.toString().padLeft(2, '0');
  final y = date.year;

  final hour = date.hour.toString().padLeft(2, '0');
  final minute = date.minute.toString().padLeft(2, '0');

  return '$d/$m/$y • $hour:$minute';
}
