library Utility;

const String databaseName = "AMADatabase.db";

const String aboutText = "Hello, and welcome to AMA, an agenda mobile app for the <Programming> 2020 conference, to be held in March 2020, in Porto. Here, you can schedule your activities and appointments so you can organize yourself better, and get the best out of the conference. Enjoy!";

const String noSessionsTitle = "This schedule has no sessions!";

const String noSessionsText = "Tap the ADD button in order to discover all the sessions available to you on this day!";

const String sessionSearchText = "Welcome to our Session Search feature, were you can discover all the exciting sessions around you, with just the tap of a button! Using Bluetooth Low Energy (BLE) beacons, we are able to tell you if there are any activities near you, that will start in under 15 mins. Tap the \"scan\" button whenever you're ready!";

const int numSecondsForTimeoutBLE = 15;

const int numMinutesForNotif = 15;

const String jsonURL = 'https://2019.programming-conference.org/dataexport/810b23a0-737b-4f74-9170-75d515274859/confero.json';

const urlPattern = r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";

const String BTAvailableText = "Bluetooth is available on this device!";
const String BTNotAvailableText = "Unfortunately, it seems like this device does not suport Bluetooth connection, so this functionality cannot be used. We are sorry.";
const String BTDisabledText = "The Bluetooth functionality of this device is turned off. In order to use the Session Search feature, please turn the Bluetooth on.";
const String BTEnabledText = "Bluetooth is turned on! Tap on the \"scan\" in order to commence Session Search.";