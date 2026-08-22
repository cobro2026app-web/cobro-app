import 'package:flutter/material.dart';
import 'package:personal/src/ui/pages/prestamos/views/filter_button.dart';
import 'package:personal/src/ui/pages/prestamos/views/header_p_view.dart';
import 'package:personal/src/ui/pages/prestamos/views/prestamo_card_view.dart';
import 'package:personal/src/ui/pages/prestamos/views/sear_p_view.dart';

class PrestamosHome extends StatelessWidget {
  const PrestamosHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderPView(),

        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 30),
            children: [
              SearPView(),

              const SizedBox(height: 18),

              Row(
                children: [
                  const Expanded(
                    child: Text(
                      '24 préstamos registrados',
                      style: TextStyle(
                        color: Color(0xFF929BAB),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  FilterButton(),
                ],
              ),

              const SizedBox(height: 14),

              PrestamoCardView(
                client: 'Lucía Fernández',
                document: 'CC 1.234.567.890',
                route: 'Ruta Norte',
                amount: '\$1.000.000',
                installment: '\$50.000',
                paid: '12 / 20',
                status: 'Activo',
                statusColor: const Color(0xFF4164E8),
                statusBackground: const Color(0xFFEEF4FF),
              ),

              const SizedBox(height: 12),

              PrestamoCardView(
                client: 'Roberto Sánchez',
                document: 'CC 9.876.543.210',
                route: 'Ruta Sur',
                amount: '\$500.000',
                installment: '\$25.000',
                paid: '20 / 20',
                status: 'Pagado',
                statusColor: const Color(0xFF00A86B),
                statusBackground: const Color(0xFFEAFBF3),
              ),

              const SizedBox(height: 12),

              PrestamoCardView(
                client: 'Carmen Jiménez',
                document: 'CC 1.098.765.432',
                route: 'Ruta Centro',
                amount: '\$800.000',
                installment: '\$40.000',
                paid: '8 / 20',
                status: 'Atrasado',
                statusColor: const Color(0xFFE53935),
                statusBackground: const Color(0xFFFFEEEE),
              ),

              const SizedBox(height: 12),

              PrestamoCardView(
                client: 'José Martínez',
                document: 'CC 7.654.321.098',
                route: 'Ruta Norte',
                amount: '\$600.000',
                installment: '\$30.000',
                paid: '5 / 20',
                status: 'Activo',
                statusColor: const Color(0xFF4164E8),
                statusBackground: const Color(0xFFEEF4FF),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
