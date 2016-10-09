APP_NAME = Test
APP_PACKAGE = com.test

debug: compile make_apt sign_apt_debug
release: compile make_apt sign_apt_release

compile:
	aapt package -v -f -m -S ./res -J ./src -M ./AndroidManifest.xml -I ./lib/android.jar
	jack --classpath ./lib/android.jar --output-dex ./obj --import-resource ./res ./src/ ./gen

make_apt:
	aapt package -v -f -M ./AndroidManifest.xml -S ./res -I ./lib/android.jar -F ./bin/$(APP_NAME).unsigned.apk
	cd obj && zip -u ../bin/$(APP_NAME).unsigned.apk classes.dex && cd ..

sign_apt_debug:
	# sign and align APK archive
	apksigner -p android debug.keystore ./bin/$(APP_NAME).unsigned.apk ./bin/$(APP_NAME).signed.apk

sign_apt_release:
	# sign and align APK archive
	apksigner -p android release.keystore ./bin/$(APP_NAME).unsigned.apk ./bin/$(APP_NAME).signed.apk

clean:
	rm -rf ./obj/*
	rm -rf ./bin/*
	rm -rf ./gen/*
