

require('UIColor,UIFont')
var SCREEN_WIDTH = require('UIScreen').mainScreen().bounds().width;
var SCREEN_HEIGHT = require('UIScreen').mainScreen().bounds().height;
defineClass('JPTableView : UIView',{
            
            initWithFrame:function(frame){
            self = self.super().initWithFrame(frame);
            if (self) {
            var imageSize = 40;
            var imageView = require('UIImageView')
                           .alloc()
                           .initWithFrame({x:5,y:100,width:imageSize,height:imageSize});
            
          
            // 添加图片
            var image = require('UIImage').imageNamed("log.png");
            imageView.setImage(image);
            
            // 添加label
            var nameLabel = require('UILabel')
                            .alloc()
                            .initWithFrame({x:imageSize + 10,y:100,width:60,height:40});
            
            nameLabel.setFont(UIFont.systemFontOfSize(16));
            nameLabel.setTextAlignment(1);
            nameLabel.setBackgroundColor(UIColor.greenColor());
            nameLabel.setText("like lin");
            
            var subLabel = require('UILabel')
                            .alloc()
                            .initWithFrame({x:imageSize + 10,y:150,width:60,height:40});
            
            subLabel.setFont(UIFont.systemFontOfSize(16));
            subLabel.setTextAlignment(1);
            subLabel.setText("tian shi");
            subLabel.setBackgroundColor(UIColor.greenColor());

            
            self.addSubview(imageView);
            self.addSubview(nameLabel);
            self.addSubview(subLabel);
            
            console.log("here");
            // 设置本视图的大小，不知道为什么要在这里设置
//            self.setFrame(frame);

            }
            
            self.setBackgroundColor(UIColor.yellowColor());
            return self;
            },
            
            
            
            })
