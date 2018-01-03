#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

%hook MMLocationMgr

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation{
    %orig;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(CLLocation *)location{
	%orig;
}

%end

%hook MMViewLocationViewController

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(CLLocation *)location{
	%orig;
}

%end

%hook FavLocationDetailViewController

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(CLLocation *)location{
    %orig;
}

%end

%hook MMPickLocationViewController

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(CLLocation *)location{
    %orig;
}

%end

%hook TrackRoomView

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(CLLocation *)location{
	[[[UIApplication sharedApplication].keyWindow viewWithTag:1025] removeFromSuperview];
	%orig;
}

%end

%hook QMapView

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation{
    %orig;
}

%end


%hook WAMapView

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(CLLocation *)newLocation updatingLocation:(CLLocation *)oldLocation{
    %orig;
}

%end