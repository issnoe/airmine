
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

  --build-name=1.0.1 --build-number=3

flutter build apk --release --target-platform=android-arm64 --build-name=1.0.1 --build-number=3

# Realese steps

git tag -a <1.0.1> -m '<1.0.1> beta'
git tag -s <1.0.1> -m 'Signed <1.0.1> tag'
git push origin <1.0.1>

