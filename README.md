![Alt text](/images/xee_01.png)

XEELocationManager
==================
XEELocationManager is a simple facade wrapper around CoreLocation's CLLocationManager.


Usage
==================

```objc

[[XEELocationManager sharedManager] fetchCurrentLocation:^(CLLocation *location) {
  NSLog(@"%@", location);
} refresh:YES];

```
