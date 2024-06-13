import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({Key? key}) : super(key: key);

  Future<void> _get(BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:5186/api/Usuario/Get'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> users = jsonDecode(response.body);

        // Mostrar los usuarios en un AlertDialog con DataTable
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Usuarios'),
            content: SingleChildScrollView(
              child: DataTable(
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Nombre')),
                  DataColumn(label: Text('Apellido')),
                  DataColumn(label: Text('Nombre de Usuario')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Contraseña')),
                  DataColumn(label: Text('Acciones')),
                ],
                rows: users.map((user) {
                  return DataRow(cells: [
                    DataCell(Text(user['id_usuario'].toString())),
                    DataCell(Text(user['nombre'].toString())),
                    DataCell(Text(user['apellido'].toString())),
                    DataCell(Text(user['nombre_usuario'].toString())),
                    DataCell(Text(user['email'].toString())),
                    DataCell(Text(user['contrasena'].toString())),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _editUser(context, user);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteUser(context, user['id_usuario']);
                            },
                          ),
                        ],
                      ),
                    ),
                  ]);
                }).toList(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cerrar'),
              ),
            ],
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Error al obtener usuarios'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Excepción al obtener usuarios: $e'),
      ));
    }
  }

  Future<void> _deleteUser(BuildContext context, int userId) async {
    try {
      final response = await http.delete(
        Uri.parse('http://localhost:5186/api/Usuario/Delete/$userId'),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Usuario eliminado exitosamente'),
        ));
        // Refrescar la lista de usuarios después de eliminar uno
        _get(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Error al eliminar usuario'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Excepción al eliminar usuario: $e'),
      ));
    }
  }

  Future<void> _editUser(BuildContext context, Map<String, dynamic> user) async {
    // Implementar la lógica para editar el usuario
    // Puedes abrir un nuevo diálogo o una pantalla para editar la información del usuario
    // Aquí un ejemplo básico de cómo podrías hacerlo:
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Usuario'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ID: ${user['id_usuario']}'),
              TextFormField(
                initialValue: user['nombre'].toString(),
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextFormField(
                initialValue: user['apellido'].toString(),
                decoration: InputDecoration(labelText: 'Apellido'),
              ),
              TextFormField(
                initialValue: user['nombre_usuario'].toString(),
                decoration: InputDecoration(labelText: 'Nombre de Usuario'),
              ),
              TextFormField(
                initialValue: user['email'].toString(),
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                initialValue: user['contrasena'].toString(),
                decoration: InputDecoration(labelText: 'Contraseña'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              // Lógica para enviar la solicitud HTTP para actualizar el usuario
              _updateUser(context, user);
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  Future<void> _updateUser(BuildContext context, Map<String, dynamic> user) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:5186/api/Usuario/Put/${user['id_usuario']}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'Nombre': 'Nombre Actualizado', // Cambia esto con los valores actualizados
          'Apellido': 'Apellido Actualizado',
          'Nombre_usuario': 'NombreUsuarioActualizado',
          'Email': 'email@actualizado.com',
          'Contraseña': 'Contraseña Actualizada',
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Usuario actualizado exitosamente'),
        ));
        // Refrescar la lista de usuarios después de actualizar uno
        _get(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Error al actualizar usuario'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Excepción al actualizar usuario: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Usuario'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('images/logo_user.png'), // Coloca la imagen de perfil aquí
              radius: 50,
            ),
            const SizedBox(height: 20),
            Text(
              'Nombre de Usuario',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              '@nombreusuario',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _get(context);
              },
              child: const Text('Obtener Usuarios'),
            ),
          ],
        ),
      ),
    );
  }
}
