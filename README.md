# BLEBrowser

Bluetooth devices browser for iOS

### Application’s features:

- discover advertising peripheral devices (rssi is ‘live’ while scanning is in progress)
- connect to peripheral device (if it is connectable)
- read list of service of device that connected
- read list of characteristics of particular service
- read value of particular characteristic (if it possible)

In this application I use more than one CBCentralManager in one application first time. I think it can be very useful in some projects.
Especially if an application will connect to more than one device at the same time.
Also I added data type of some standard characteristics to improve reading it’s values.
For example, 26% ‘Battery Level’ characteristic in ‘Battery Information’ service on my iPad:
https://github.com/ZiRTeam/BLEBrowser/blob/master/Screenshots/image6.png
