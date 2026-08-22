import 'package:flutter/material.dart';
import 'package:personal/src/common/theme/theme.dart';

class RutaPage extends StatefulWidget {
  const RutaPage({super.key});

  @override
  State<RutaPage> createState() => _RutaPageState();
}

class _RutaPageState extends State<RutaPage> {
  final List<RutaModel> rutas = [
    RutaModel(
      nombre: 'Ruta Centro',
      descripcion: 'Zona centro y alrededores',
      cobrador: 'Carlos Pérez',
      clientes: 18,
      activa: true,
    ),
    RutaModel(
      nombre: 'Ruta Norte',
      descripcion: 'Barrio La Granja y sectores cercanos',
      cobrador: 'Juan Martínez',
      clientes: 25,
      activa: true,
    ),
    RutaModel(
      nombre: 'Ruta Sur',
      descripcion: 'Zona sur de la ciudad',
      cobrador: 'Pedro Gómez',
      clientes: 12,
      activa: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF202838),
          ),
        ),

        title: const Text(
          'Rutas',
          style: TextStyle(
            color: Color(0xFF202838),
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _crearRuta,
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Nueva ruta',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: Column(
        children: [
          _header(),

          const SizedBox(height: 18),

          Expanded(
            child: rutas.isEmpty
                ? _emptyState()
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      0,
                      20,
                      100,
                    ),
                    itemCount: rutas.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _rutaCard(rutas[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .15),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.route_outlined,
                color: Colors.white,
                size: 28,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gestión de rutas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    '${rutas.length} rutas configuradas',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${rutas.where((e) => e.activa).length} activas',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // CARD RUTA
  // ============================================================

  Widget _rutaCard(RutaModel ruta) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.black.withValues(alpha: .05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .025),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: .10),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.route_rounded,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ruta.nombre,
                      style: const TextStyle(
                        color: Color(0xFF202838),
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      ruta.descripcion,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF929BAB),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),

              _status(ruta.activa),
            ],
          ),

          const SizedBox(height: 16),

          Divider(
            height: 1,
            color: Colors.black.withValues(alpha: .06),
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: _info(
                  icon: Icons.person_outline_rounded,
                  title: 'Cobrador',
                  value: ruta.cobrador,
                ),
              ),

              Container(
                width: 1,
                height: 35,
                color: Colors.black.withValues(alpha: .06),
              ),

              Expanded(
                child: _info(
                  icon: Icons.people_outline_rounded,
                  title: 'Clientes',
                  value: '${ruta.clientes}',
                ),
              ),

              PopupMenuButton<String>(
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: Color(0xFF929BAB),
                ),
                onSelected: (value) {
                  _handleMenu(value, ruta);
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'ver',
                    child: Row(
                      children: [
                        Icon(Icons.visibility_outlined, size: 18),
                        SizedBox(width: 10),
                        Text('Ver ruta'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'editar',
                    child: Row(
                      children: [
                        Icon(Icons.edit_outlined, size: 18),
                        SizedBox(width: 10),
                        Text('Editar'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'cobrador',
                    child: Row(
                      children: [
                        Icon(Icons.person_outline, size: 18),
                        SizedBox(width: 10),
                        Text('Asignar cobrador'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'estado',
                    child: Row(
                      children: [
                        Icon(Icons.power_settings_new, size: 18),
                        SizedBox(width: 10),
                        Text('Cambiar estado'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // STATUS
  // ============================================================

  Widget _status(bool activa) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: activa
            ? Colors.green.withValues(alpha: .08)
            : Colors.red.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: activa ? Colors.green : Colors.red,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 5),

          Text(
            activa ? 'Activa' : 'Inactiva',
            style: TextStyle(
              color: activa ? Colors.green : Colors.red,
              fontSize: 9,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // INFO
  // ============================================================

  Widget _info({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: AppTheme.primaryColor,
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF929BAB),
                    fontSize: 9,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF394354),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // EMPTY
  // ============================================================

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: .08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.route_outlined,
                size: 38,
                color: AppTheme.primaryColor,
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'No hay rutas creadas',
              style: TextStyle(
                color: Color(0xFF202838),
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 7),

            const Text(
              'Crea una ruta para comenzar a organizar '
              'los clientes y asignar cobradores.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF929BAB),
                fontSize: 11,
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: _crearRuta,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Crear ruta'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ACCIONES
  // ============================================================

  void _crearRuta() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _crearRutaSheet(),
    );
  }

  void _handleMenu(String value, RutaModel ruta) {
    switch (value) {
      case 'ver':
        _verRuta(ruta);
        break;

      case 'editar':
        _editarRuta(ruta);
        break;

      case 'cobrador':
        _asignarCobrador(ruta);
        break;

      case 'estado':
        setState(() {
          ruta.activa = !ruta.activa;
        });
        break;
    }
  }

  void _verRuta(RutaModel ruta) {
    // Navegar a detalle de ruta
  }

  void _editarRuta(RutaModel ruta) {
    // Editar ruta
  }

  void _asignarCobrador(RutaModel ruta) {
    // Seleccionar cobrador
  }

  // ============================================================
  // CREAR RUTA
  // ============================================================

  Widget _crearRutaSheet() {
    final nombreController = TextEditingController();
    final descripcionController = TextEditingController();

    String cobrador = 'Seleccionar cobrador';

    return StatefulBuilder(
      builder: (context, setModalState) {
        return Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFFF5F7FC),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Nueva ruta',
                style: TextStyle(
                  color: Color(0xFF202838),
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Configura la ruta y asigna un cobrador.',
                style: TextStyle(
                  color: Color(0xFF929BAB),
                  fontSize: 11,
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: nombreController,
                decoration: _inputDecoration(
                  'Nombre de la ruta',
                  Icons.route_outlined,
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: descripcionController,
                maxLines: 2,
                decoration: _inputDecoration(
                  'Descripción / zona',
                  Icons.location_on_outlined,
                ),
              ),

              const SizedBox(height: 12),

              InkWell(
                onTap: () {
                  setModalState(() {
                    cobrador = 'Carlos Pérez';
                  });
                },
                child: InputDecorator(
                  decoration: _inputDecoration(
                    'Cobrador',
                    Icons.person_outline_rounded,
                  ),
                  child: Text(
                    cobrador,
                    style: TextStyle(
                      color: cobrador == 'Seleccionar cobrador'
                          ? const Color(0xFF929BAB)
                          : const Color(0xFF394354),
                      fontSize: 13,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    if (nombreController.text.trim().isEmpty) {
                      return;
                    }

                    setState(() {
                      rutas.add(
                        RutaModel(
                          nombre: nombreController.text.trim(),
                          descripcion:
                              descripcionController.text.trim(),
                          cobrador: cobrador == 'Seleccionar cobrador'
                              ? 'Sin asignar'
                              : cobrador,
                          clientes: 0,
                          activa: true,
                        ),
                      );
                    });

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Crear ruta',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  InputDecoration _inputDecoration(
    String label,
    IconData icon,
  ) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(
        icon,
        size: 20,
      ),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }
}

// ============================================================
// MODEL
// ============================================================

class RutaModel {
  String nombre;
  String descripcion;
  String cobrador;
  int clientes;
  bool activa;

  RutaModel({
    required this.nombre,
    required this.descripcion,
    required this.cobrador,
    required this.clientes,
    required this.activa,
  });
}