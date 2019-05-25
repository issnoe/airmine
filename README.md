
# Descripción
- Con esta aplicación podrás saber el índice de la calidad del aire en tu ubicación, por medio de un potente algoritmo de machine learning.

# Características

- Ubicación automática
- Escala de índices del aire
- Recomendaciones

# Próxima versión

- Notificaciones
- Pronósticos
- Clima
- Índice UV
- Plantación para corredores
- Planeación vehicular

# Deploy

- Change name (cmd + P)
  - android/app/src/main/AndroidManifest.xml
  - android/app/build.gradle

- Change version 1 +
  - flutterVersionCode
  - flutterVersionName

flutter build apk --release --target-platform=android-arm64

