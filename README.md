I have created a small sample build of the feature I have a question about. The problem I am having is the code works fine in iOS 6-12.5.7 on old iPhone 6 as well as in simulator in Xcode 10. I made 0 changes and build in Xcode 15 for iOS 18.2 iPhone 15 or in simulator iOS 18.1 with no errors but there is a behavior change... 
UPDATE: since testing this I have learned there is a difference in how iOS 18 handles observing, which I think is my issue.

The expected behavior as follows:

The app consists of a view with a label and a button to bring you to settings for the app.

Access View:
The app requests access to contacts at launch, if it is not granted a warning view covers the app telling you that access needs to be granted. Tapping the button and changing the setting and returning to the app will automatically dissolve the warning.

Setings View:
In settings there is a "Name field" which if left empty causes a warning view to cover the app telling you that a setting is missing. Tapping the button and changing the setting and returning to the app will automatically dissolve the warning.

Xcode 10 - no issues

Xcode 15 - the access view warning behaves exactly as described. the settings view warning doesn't automatically happen when you switch back to the app from settings - it only does it at app launch.

I don't understand why 1 function works when switching back to the app and the other function doesn't.

I do not know how to use the new method of implementing observer to watch for settings changes in the way that it used to work.

Can someone help me understand the reason and solution for the behavior change?
