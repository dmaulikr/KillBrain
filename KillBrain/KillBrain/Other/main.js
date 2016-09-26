
include('JPTableViewController.js')

defineClass('ThirdViewController', {
            handleItem: function() {
            var tableViewCtrl = JPTableViewController.alloc().init();
            self.navigationController().pushViewController_animated(tableViewCtrl, YES);
            }
            })

