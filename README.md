
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


flutter build apk --release --target-platform=android-arm64 --build-name=1.0.4 --build-number=41
flutter build apk --release --target-platform=android-arm --build-name=1.0.3 --build-number=40

# Realese steps

git tag -a <2> -m '<2> beta'
git tag -s <2> -m 'Signed <2> tag'
git push origin <2>

