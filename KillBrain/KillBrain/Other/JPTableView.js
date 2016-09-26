

require('UIColor,UIFont,UITableView,NSBundle,MAMapView')
include('Conmon.js')

defineClass('JPTableView : UIView',[
            'mapView',
            'tableView',
            'searchBar'
            ], {
            
            initWithFrame:function(frame){
            self = self.super().initWithFrame(frame);
            if (self) {

            var mapView = MAMapView.alloc().initWithFrame({x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT})
            self.setMapView(mapView)
            self.addSubview(mapView);
            
            }
            return self;
            },
            
            })
