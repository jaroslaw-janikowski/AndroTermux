APP_NAME = Test
APP_PACKAGE = com.test

debug: compile make_apt sign_apt_debug
release: compile make_apt sign_apt_release align_apt

compile:
	aapt package -v -f -m -S ./res -J ./src -M ./AndroidManifest.xml -I ./lib/android.jar
	jack --classpath ./lib/android.jar --output-dex ./obj --import-resource ./res ./src/ ./gen

make_apt:
	aapt package -v -f -M ./AndroidManifest.xml -S ./res -I ./lib/android.jar -F ./bin/$(APP_NAME).unsigned.apk
	jar -uf ./bin/$(APP_NAME).unsigned.apk -C ./obj classes.dex

sign_apt_debug:
	jarsigner -verbose -keystore ./debug.keystore -storepass android -keypass android -signedjar ./bin/$(APP_NAME).signed.apk ./bin/$(APP_NAME).unsigned.apk AndroidDebugKey

sign_apt_release:
	jarsigner -verbose -keystore ./release.keystore -storepass password -keypass password -signedjar ./bin/$(APP_NAME).signed.apk ./bin/$(APP_NAME).unsigned.apk AndroidTestKey

align_apt:
	zipalign -v -f 4 ./bin/$(APP_NAME).signed.apk ./bin/$(APP_NAME).apk

clean:
	rm -rf ./obj/*
	rm -rf ./bin/*
	rm -rf ./gen/*
