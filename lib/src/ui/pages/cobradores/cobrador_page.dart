import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal/src/ui/pages/cobradores/cubit/cobrador_cubit.dart';

class CobradorPage extends StatelessWidget {
  const CobradorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      body: BlocProvider(
        create: (context) => CobradorCubit(context: context),
        child: BlocBuilder<CobradorCubit, CobradorState>(
          builder: (context, state) {
            return SafeArea(
              child: state.loading
                  ? Center(child: CircularProgressIndicator.adaptive())
                  : state.child,
            );
          },
        ),
      ),
    );
  }
}
