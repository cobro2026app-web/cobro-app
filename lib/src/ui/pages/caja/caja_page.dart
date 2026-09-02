import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal/src/common/theme/theme.dart';
import 'package:personal/src/ui/pages/caja/cubit/caja_cubit.dart';
import 'package:personal/src/ui/pages/rutas/cubit/ruta_cubit.dart';
import 'package:personal/src/ui/widgets/btn_widget.dart';
import 'package:personal/src/ui/widgets/input_widget.dart';

class CajaPage extends StatefulWidget {
  const CajaPage({super.key});

  @override
  State<CajaPage> createState() => _CajaPageState();
}

class _CajaPageState extends State<CajaPage> {
  bool loading = false;
  late CajaCubit _cubit;

  @override
  void initState() {
    super.initState();

    _cubit = CajaCubit(context: context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _abrirCaja() async {
    final monto = 0;

    if (monto == null || monto <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa un monto inicial válido')),
      );
      return;
    }

    setState(() => loading = true);

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() => loading = false);

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocBuilder<CajaCubit, CajaState>(
        builder: (context, state) {
          return state.child;
        },
      ),
    );
  }
}
