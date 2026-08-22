import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:personal/get_it.dart';
import 'package:personal/src/common/utils/app_dialog_util.dart';
import 'package:personal/src/common/utils/secure_storage_util.dart';
import 'package:personal/src/domain/dto/auth_dto.dart';
import 'package:personal/src/domain/repository/auth_repo.dart';
import 'package:personal/src/ui/pages/home/home_page.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final _authRepo = sl<AuthRepository>();

  ///Repositorios
  ///
  ///

  ///Constructor
  ///
  ///
  AuthCubit(BuildContext context) : super(AuthState(context: context)) {
    _validateToken();
  }

  ///Variables
  ///
  ///
  final user = TextEditingController();
  final password = TextEditingController();

  ///Eventos
  ///
  ///
  void onShowPassword() {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  ///Validaciones
  ///
  ///
  void btnEnabled() {
    bool e = false;

    if (user.text.isNotEmpty && password.text.isNotEmpty) {
      e = true;
    }
    emit(state.copyWith(ennaled: e));
  }

  ///Peticiones
  ///
  ///
  void login() async {
    emit(state.copyWith(loading: true));
    final r = await _authRepo.login(
      dto: AuthDto(username: user.text.trim(), password: password.text.trim()),
    );
    r.fold(
      (l) async {
        AppDialogUtil.error(state.context, message: l.props[0].toString());
      },
      (r) async {
        await SecureStorageUtil().write("token", r.accessToken);
        goToHome();
      },
    );
    emit(state.copyWith(loading: false));
  }

  ///Navegacion
  ///
  ///

  void goToHome() {
    Navigator.pushAndRemoveUntil(
      state.context,
      MaterialPageRoute(builder: (_) => HomePage()),
      (route) => false,
    );
  }

  void _validateToken() async {
    final String token = await SecureStorageUtil().read("token") ?? "";
    if (token.isNotEmpty) {
      if (!JwtDecoder.isExpired(token)) {
        goToHome();
      }
    }
  }

  ///Otros
}
