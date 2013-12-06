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


Contact
================

Follow XEETech on Twitter (<a href="https://twitter.com/XEE_Tech">XEE Tech</a>).

Connect with us on LinkedIn (<a href="http://www.linkedin.com/company/xee-tech">@XEE_Tech</a>).


License
================
XEEPluralizer is available under the MIT license. See the LICENSE file for more info.
