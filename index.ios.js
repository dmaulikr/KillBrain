'use strict';

import React, { Component } from 'react';
import  {
   AppRegistry,
   StyleSheet,
   Text,
   View
} from 'react-native'

var conststyles = StyleSheet.create({
    container: {
      flex:1,
      backgroundColor: 'red'
    }
});

class KillBrain extends Component {
      render(){
          return (
             <View style={conststyles.container}>
                <Text>我是iOS大牛，我正在getting React Native新技能！我还想还是喜欢她！</Text>
             </View>
          )
      }
};
AppRegistry.registerComponent('KillBrain',() => KillBrain);