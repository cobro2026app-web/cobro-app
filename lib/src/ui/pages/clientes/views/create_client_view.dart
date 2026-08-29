import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal/src/common/shared/shared.dart';
import 'package:personal/src/common/theme/theme.dart';
import 'package:personal/src/domain/entities/ruta_entity.dart';
import 'package:personal/src/ui/pages/clientes/cubit/cliente_cubit.dart';
import 'package:personal/src/ui/pages/clientes/views/client_home.dart';
import 'package:personal/src/ui/pages/clientes/views/cliente_detalle_view.dart';
import 'package:personal/src/ui/widgets/widgets.dart';

class CreateClientView extends StatelessWidget {
  final bool isEdit;
  const CreateClientView({super.key, this.isEdit = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClienteCubit, ClienteState>(
      builder: (context, state) {
        final c = context.read<ClienteCubit>();
        return Scaffold(
          backgroundColor: const Color(0xFFF5F7FC),
          appBar: AppBar(
            backgroundColor: AppTheme.primaryColor,
            elevation: 0,
            leading: IconButton(
              onPressed: () =>
                  c.setChild(isEdit ? ClienteDetalleView() : ClientHome()),
              icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            ),
            title: Text(
              isEdit ? "Editar cliente" : 'Nuevo cliente',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(),

                const SizedBox(height: 24),

                _sectionTitle(
                  icon: Icons.person_outline_rounded,
                  title: 'Información personal',
                ),

                const SizedBox(height: 14),

                InputWidget.input(
                  label: 'Nombres',
                  hintText: 'Ingrese los nombres',
                  prefixIcon: Icons.person_outline_rounded,
                  controller: c.nameTxt,
                  textInputAction: TextInputAction.next,
                  enabled: !state.loadingBtn,

                  onChanged: (value) => c.enabledBtn(),
                ),

                const SizedBox(height: 16),

                InputWidget.input(
                  label: 'Apellidos',
                  hintText: 'Ingrese los apellidos',
                  prefixIcon: Icons.person_outline_rounded,
                  controller: c.lastNameTxt,
                  textInputAction: TextInputAction.next,
                  enabled: !state.loadingBtn,

                  onChanged: (value) => c.enabledBtn(),
                ),

                const SizedBox(height: 16),

                InputWidget.input(
                  label: 'Número de cédula',
                  hintText: 'Ingrese el número de cédula',
                  prefixIcon: Icons.badge_outlined,
                  controller: c.ideTxt,
                  keyboardType: TextInputType.number,
                  enabled: !state.loadingBtn,

                  onChanged: (value) => c.enabledBtn(),
                ),

                const SizedBox(height: 28),

                _sectionTitle(
                  icon: Icons.phone_outlined,
                  title: 'Información de contacto',
                ),

                const SizedBox(height: 14),

                InputWidget.input(
                  label: 'Número de contacto',
                  hintText: 'Ej: 300 123 4567',
                  prefixIcon: Icons.phone_outlined,
                  controller: c.contactTxt,
                  keyboardType: TextInputType.phone,
                  enabled: !state.loadingBtn,

                  onChanged: (value) => c.enabledBtn(),
                ),

                const SizedBox(height: 16),

                InputWidget.input(
                  label: 'Número de WhatsApp',
                  hintText: 'Ej: 300 123 4567',
                  prefixIcon: Icons.chat_outlined,
                  controller: c.whatsappTxt,
                  keyboardType: TextInputType.phone,
                  enabled: !state.loadingBtn,

                  onChanged: (value) => c.enabledBtn(),
                ),

                const SizedBox(height: 28),

                _sectionTitle(
                  icon: Icons.location_on_outlined,
                  title: 'Información de dirección',
                ),

                const SizedBox(height: 14),

                InputWidget.input(
                  label: 'Dirección',
                  hintText: 'Ej: Calle 32 # 14-25',
                  prefixIcon: Icons.home_outlined,
                  controller: c.directionTxt,
                  enabled: !state.loadingBtn,

                  onChanged: (value) => c.enabledBtn(),
                ),

                const SizedBox(height: 16),

                InputWidget.input(
                  label: 'Descripción de la dirección',
                  hintText: 'Ej: Casa blanca, frente a la tienda...',
                  prefixIcon: Icons.description_outlined,
                  controller: c.addressDescriptionTxt,
                  maxLines: 3,
                  enabled: !state.loadingBtn,

                  onChanged: (value) => c.enabledBtn(),
                ),

                const SizedBox(height: 16),

                InputWidget.input(
                  label: 'Barrio / Sector',
                  hintText: 'Ingrese el barrio o sector',
                  prefixIcon: Icons.map_outlined,
                  controller: c.barrioTxt,
                  enabled: !state.loadingBtn,

                  onChanged: (value) => c.enabledBtn(),
                ),

                const SizedBox(height: 28),
                const SizedBox(height: 16),

                DropdownButtonFormField<DatumREntity>(
                  initialValue: state.ruta,
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: 'Ruta',
                    hintText: 'Seleccione una ruta',
                    prefixIcon: const Icon(Icons.route_outlined),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.grey.withValues(alpha: .15),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: AppTheme.primaryColor,
                        width: 1.5,
                      ),
                    ),
                  ),
                  items: Shared.getRutas!.map((ruta) {
                    return DropdownMenuItem<DatumREntity>(
                      value: ruta,
                      child: Text(ruta.nombre, overflow: TextOverflow.ellipsis),
                    );
                  }).toList(),
                  onChanged: state.loadingBtn
                      ? null
                      : (value) {
                          if (value != null) {
                            c.onEventRuta(value);
                            c.enabledBtn();
                          }
                        },
                ),
                const SizedBox(height: 28),

                _sectionTitle(
                  icon: Icons.notes_rounded,
                  title: 'Información adicional',
                ),

                const SizedBox(height: 14),

                InputWidget.input(
                  label: 'Descripción',
                  enabled: !state.loadingBtn,
                  hintText: 'Agregue alguna observación del cliente...',
                  prefixIcon: Icons.notes_rounded,
                  controller: c.observationTxt,
                  maxLines: 4,
                  onChanged: (value) => c.enabledBtn(),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: BtnWidget.btn(
                    text: isEdit ? "Editar cliente" : 'Crear cliente',
                    loading: state.loadingBtn,
                    icon: Icons.person_add_alt_1_rounded,
                    onPressed: state.btnEnabled
                        ? () {
                            if (isEdit) {
                              c.editarCliente() ;              
                            } else {
                              c.crearCliente();
                            }
                          }
                        : null,
                    enabled: state.btnEnabled,
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () => c.setChild(ClientHome()),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      side: BorderSide(
                        color: Colors.grey.withValues(alpha: 0.25),
                      ),
                    ),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(
                        color: Color(0xFF687386),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _header() {
    return Visibility(
      visible: !isEdit,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.primaryColor,
              AppTheme.primaryColor.withValues(alpha: .80),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          children: [
            Icon(Icons.person_add_alt_1_rounded, color: Colors.white, size: 32),

            SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Registrar cliente',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Complete la información del nuevo cliente.',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle({required IconData icon, required String title}) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withValues(alpha: .10),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppTheme.primaryColor, size: 18),
        ),

        const SizedBox(width: 10),

        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF202838),
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
