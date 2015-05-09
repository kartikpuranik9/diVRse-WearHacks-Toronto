var Myo = require('myo');

var myMyo = Myo.create();
myMyo.on('fist', function(edge){
    if(!edge) return;
    console.log('Clicked!');
	/*myMyo.mouse('left', 'click')*/
	/*myMyo.centerMousePosition();*/
<<<<<<< HEAD
	console.log(myMyo.getArm());
=======
	console.log(myMyo.getArm());//
>>>>>>> 8e5c3fc46cbe239d22aecdbe182ab7c153577ab7
    /*myMyo.vibrate();*/
});