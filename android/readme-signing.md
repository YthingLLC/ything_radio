
https://docs.flutter.dev/deployment/android#signing-the-app

keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
