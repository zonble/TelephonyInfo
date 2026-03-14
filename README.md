TelephonyInfo
=============

> **⚠️ This project is no longer maintained and has been archived.**

TelephonyInfo is a simple iOS application that displays carrier and telephony information from the device using Apple's [CoreTelephony](https://developer.apple.com/documentation/coretelephony) framework.

## Features

- Displays the current cellular carrier name
- Shows the mobile country code (MCC)
- Shows the mobile network code (MNC)
- Shows the ISO country code
- Allows sending a screenshot of the carrier info via email

## Background

This project was built as a demonstration of the `CTTelephonyNetworkInfo` and `CTCarrier` APIs available in the CoreTelephony framework. It was originally developed for older versions of iOS.

## Legacy Notice

This project uses several deprecated iOS APIs including `UIAlertView` and `CTCarrier`. Apple has deprecated and removed many of the CoreTelephony carrier APIs in modern versions of iOS. This repository is archived and is kept for historical reference only. No further updates or maintenance are planned.
