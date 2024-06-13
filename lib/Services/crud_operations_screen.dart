import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CRUDOperationsScreen extends StatelessWidget {
  const CRUDOperationsScreen({super.key});

  Future<void> _get(BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:5186/api/Usuario/Get'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> users = jsonDecode(response.body);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Usuarios'),
            content: SingleChildScrollView(
              child: ListBody(
                children: users.map((user) => Text(user.toString())).toList(),
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

  Future<void> _put(BuildContext context) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:5186/api/Usuario/Put'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'id': 1, // Actualiza este valor según el ID del usuario
          'Nombre': 'Nombre Actualizado',
          'Apellido': 'Apellido Actualizado',
          'Nombre_usuario': 'NombreUsuarioActualizado',
          'Email': 'email@actualizado.com',
          'Foto_perfil': 'FotoActualizada',
          'Biografia': 'Biografía actualizada',
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Usuario actualizado exitosamente'),
        ));
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

  Future<void> _patch(BuildContext context) async {
    try {
      final response = await http.patch(
        Uri.parse('http://localhost:5186/api/Usuario/Patch'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'id': 1, // Actualiza este valor según el ID del usuario
          'Email': 'email@parcheado.com',
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Usuario parcheado exitosamente'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Error al parchear usuario'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Excepción al parchear usuario: $e'),
      ));
    }
  }

  Future<void> _delete(BuildContext context) async {
    try {
      final response = await http.delete(
        Uri.parse(
            'http://localhost:5186/api/Usuario/Delete/1'), // Actualiza este valor según el ID del usuario
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Usuario eliminado exitosamente'),
        ));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Operaciones CRUD'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _get(context);
              },
              child: const Text('GET'),
            ),
            ElevatedButton(
              onPressed: () {
                _put(context);
              },
              child: const Text('PUT'),
            ),
            ElevatedButton(
              onPressed: () {
                _patch(context);
              },
              child: const Text('PATCH'),
            ),
            ElevatedButton(
              onPressed: () {
                _delete(context);
              },
              child: const Text('DELETE'),
            ),
          ],
        ),
      ),
    );
  }
}
