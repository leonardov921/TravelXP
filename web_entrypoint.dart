import 'package:url_strategy/url_strategy.dart';
import 'package:flutter_application_travelxp/main.dart' as app;

void main() {
  // Configuración específica para la web.
  setPathUrlStrategy();

  // Iniciar la aplicación.
  app.main();
}
