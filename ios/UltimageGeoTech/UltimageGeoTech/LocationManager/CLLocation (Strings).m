/*
     File: CLLocation (Strings).m
 Abstract: This is an Objective C category on the CLLocation class that extends the class by adding some convenience methods for presenting localized string representations of various properties.
 
  Version: 2.2
 
  
 */

#import "CLLocation (Strings).h"


@implementation CLLocation (Strings)

- (NSString *)localizedCoordinateString {
    if (self.horizontalAccuracy < 0) {
        return NSLocalizedString(@"DataUnavailable", @"DataUnavailable");
    }
    NSString *latString = (self.coordinate.latitude < 0) ? NSLocalizedString(@"South", @"South") : NSLocalizedString(@"North", @"North");
    NSString *lonString = (self.coordinate.longitude < 0) ? NSLocalizedString(@"West", @"West") : NSLocalizedString(@"East", @"East");
    return [NSString stringWithFormat:NSLocalizedString(@"LatLongFormat", @"LatLongFormat"), fabs(self.coordinate.latitude), latString, fabs(self.coordinate.longitude), lonString];
}

- (NSString *)localizedAltitudeString {
    if (self.verticalAccuracy < 0) {
        return NSLocalizedString(@"DataUnavailable", @"DataUnavailable");
    }
    NSString *seaLevelString = (self.altitude < 0) ? NSLocalizedString(@"BelowSeaLevel", @"BelowSeaLevel") : NSLocalizedString(@"AboveSeaLevel", @"AboveSeaLevel");
    return [NSString stringWithFormat:NSLocalizedString(@"AltitudeFormat", @"AltitudeFormat"), fabs(self.altitude), seaLevelString];
}

- (NSString *)localizedHorizontalAccuracyString {
    if (self.horizontalAccuracy < 0) {
        return NSLocalizedString(@"DataUnavailable", @"DataUnavailable");
    }
    return [NSString stringWithFormat:NSLocalizedString(@"AccuracyFormat", @"AccuracyFormat"), self.horizontalAccuracy];
}

- (NSString *)localizedVerticalAccuracyString {
    if (self.verticalAccuracy < 0) {
        return NSLocalizedString(@"DataUnavailable", @"DataUnavailable");
    }
    return [NSString stringWithFormat:NSLocalizedString(@"AccuracyFormat", @"AccuracyFormat"), self.verticalAccuracy];
}    

- (NSString *)localizedCourseString {
    if (self.course < 0) {
        return NSLocalizedString(@"DataUnavailable", @"DataUnavailable");
    }
    return [NSString stringWithFormat:NSLocalizedString(@"CourseFormat", @"CourseFormat"), self.course];
}

- (NSString *)localizedSpeedString {
    if (self.speed < 0) {
        return NSLocalizedString(@"DataUnavailable", @"DataUnavailable");
    }
    return [NSString stringWithFormat:NSLocalizedString(@"SpeedFormat", @"SpeedFormat"), self.speed];
}

@end
