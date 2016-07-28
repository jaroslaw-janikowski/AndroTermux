APP_NAME = Test

debug: compile make_apt sign_apt_debug

compile:
	aapt package -v -f -m -S ./res -J ./src -M ./AndroidManifest.xml -I $./lib/android.jar
	jack --classpath ./lib/android.jar --output-dex ./obj --import-resource ./res ./src/ ./gen

make_apt:
	aapt package -v -f -M ./AndroidManifest.xml -S ./res -I ./lib/android.jar -F ./bin/$(APP_NAME).unsigned.apk
	jar -uf $(DEV_HOME)/bin/$(APP_NAME).unsigned.apk -C $(DEV_HOME)/obj classes.dex

sign_apt_debug:
	jarsigner -verbose -keystore ./debug.keystore -storepass android -keypass android -signedjar ./bin/Teutons.signed.apk ./bin/$(APP_NAME).unsigned.apk AndroidDebugKey

clean:
	rm -rf $(DEV_HOME)/obj/*
	rm -rf $(DEV_HOME)/bin/*
	rm -rf $(DEV_HOME)/gen/*
