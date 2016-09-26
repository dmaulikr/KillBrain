//defineClass('JPTableViewController : UITableViewController <UIAlertViewDelegate>', ['data'], {
//            dataSource: function() {
//            var data = self.data();
//            if (data) return data;
//            var data = [];
//            for (var i = 0; i < 20; i ++) {
//            data.push("cell from js " + i);
//            }
//            self.setData(data) // 相当于self.data = data
//            return data;
//            },
//            
//            viewDidLoad:function(){
//            self.super().viewDidLoad();
//            
//            console.log("kkkkkkkkkkkkkkkkkkkk");
//            },
//            
//            numberOfSectionsInTableView: function(tableView) {
//            return 1;
//            },
//            tableView_numberOfRowsInSection: function(tableView, section) {
//            return self.dataSource().length;
//            },
//            tableView_cellForRowAtIndexPath: function(tableView, indexPath) {
//            var cell = tableView.dequeueReusableCellWithIdentifier("cell")
//            if (!cell) {
//            cell = require('UITableViewCell').alloc().initWithStyle_reuseIdentifier(0, "cell")
//            }
//            cell.textLabel().setText(self.dataSource()[indexPath.row()])
//            return cell
//            },
//            tableView_heightForRowAtIndexPath: function(tableView, indexPath) {
//            return 60
//            },
//            tableView_didSelectRowAtIndexPath: function(tableView, indexPath) {
//            var alertView = require('UIAlertView').alloc().initWithTitle_message_delegate_cancelButtonTitle_otherButtonTitles("Alert",self.dataSource()[indexPath.row()], self, "OK",  null);
//            alertView.show()
//            },
//            alertView_willDismissWithButtonIndex: function(alertView, idx) {
//            console.log('click btn ' + alertView.buttonTitleAtIndex(idx).toJS())
//            }
//})


var SCREEN_WIDTH = require('UIScreen').mainScreen().bounds().width;
var SCREEN_HEIGHT = require('UIScreen').mainScreen().bounds().height;
include('JPTableView.js')
defineClass('JPTableViewController : UIViewController' , {

            viewDidLoad:function(){
            self.super().viewDidLoad();
            
            var JSTableView = JPTableView.alloc().initWithFrame({x:0, y:0, width:SCREEN_WIDTH, height: SCREEN_HEIGHT});
            self.view().addSubview(JSTableView);
            
            },
            
            })






























