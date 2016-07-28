# AndroTermux

Goal of this project is to develop basic start project for developing Android applications inside Termux terminal on Android devices.

## Requirements

1. Install Termux on your phone.
2. Install tools in your Termux:
  * apt install jack make aapt git
3. Clone this repository to your home dir:
  * git clone https://github.com/4544fa8d/AndroTermux.git
4. Pick Android SDK version which you want to use to build this application by copying file android.jar from locations like:
  * <Android SDK>/platforms/android-10/android.jar
  * <Android SDK>/platforms/android-23/android.jar
  * and so on... to ./lib/ directory of this project.
5. Run build process with command:
  * make
6. Your "Hello world" application should be waiting in bin/ directory.
