


include('JPTableView.js')
include('Conmon.js')
require('MAMapView')

defineClass("JPTableViewController : UIViewController<MAMapViewDelegate>" ,[
            'jsView'
           ], {
            viewDidLoad:function(){
            self.super().viewDidLoad();
            var JSTableView = JPTableView.alloc().initWithFrame({x:0, y:0, width:SCREEN_WIDTH, height: SCREEN_HEIGHT});
            JSTableView.mapView().setDelegate(self);
            JSTableView.mapView().setUserTrackingMode(1);
            JSTableView.mapView().setShowsUserLocation(YES);
            self.view().addSubview(JSTableView);
            self.setJsView(JSTableView)
            },
            mapView_didUpdateUserLocation_updatingLocation:function(mapView,userLocation,updatingLocation) {
            console.log("mapView_didUpdateUserLocation_updatingLocation")
            },
            
          })
























