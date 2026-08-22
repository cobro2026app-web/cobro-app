import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal/src/ui/pages/clientes/cubit/cliente_cubit.dart';

class Clientepage extends StatelessWidget {
  const Clientepage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClienteCubit(context),
      child: BlocBuilder<ClienteCubit, ClienteState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: const Color(0xFFF5F7FC),
              body: state.loading
                  ? Center(child: CircularProgressIndicator.adaptive())
                  : state.child,
            ),
          );
        },
      ),
    );
  }
}
