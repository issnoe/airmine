
# Airmine

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
flutter build apk --release --target-platform=android-arm --build-name=1.0.5 --build-number=42

# Realese steps

git tag -a <2> -m '<2> beta'
git tag -s <2> -m 'Signed <2> tag'
git push origin <2>

# Task

- [ ] Check issue related with cached network image
- [ ] https://pub.dev/packages/cached_network_image
  - [ ] ? This error is from database stoge
  - [ ] Check versions from master compare hotfix

- [ ] Update key from google count matersoft
- [ ] Change with example to render image