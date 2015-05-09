var Myo = require('myo');

var myMyo = Myo.create();
myMyo.on('fist', function(edge){
    if(!edge) return;
    console.log('Clicked!');
	/*myMyo.mouse('left', 'click')*/
	/*myMyo.centerMousePosition();*/
	console.log(myMyo.getArm());//
    /*myMyo.vibrate();*/
});