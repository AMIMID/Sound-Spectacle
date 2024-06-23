(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*64;
//s.options.blockSize = 64/4;
s.options.maxNodes = 1024 * 64;
s.waitForBoot
)


(
~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/synthesized tetrahedron.wav",channels:0 );
~c2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/synthesized tetrahedron.wav",channels:1 );
~c3 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/synthesized tetrahedron.wav",channels:2 );
~c4 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/synthesized tetrahedron.wav",channels:3 );
)


(
{
var pos1,pos2,pos3,pos4,ampx,ampy,amp3,amp4;

pos1=MouseX.kr(1.neg,1);
pos2=MouseX.kr(1.neg,1).neg;
pos3=MouseY.kr(1.neg,1).neg;
pos4=MouseY.kr(1.neg,1);

	Out.ar(0,Pan2.ar(PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0, doneAction:2),pos3));
	Out.ar(0,Pan2.ar(PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2), loop: 0, doneAction:2),pos4));
	Out.ar(0,Pan2.ar(PlayBuf.ar(1, ~c3.bufnum, BufRateScale.kr(~c3), loop: 0, doneAction:2),pos1));
	Out.ar(0,Pan2.ar(PlayBuf.ar(1, ~c4.bufnum, BufRateScale.kr(~c4), loop: 0, doneAction:2),pos2));
}.play;
)
////////////////////////////////////////////////////////////////
(
(
a={
	arg posx,posy,ampx,ampy,echox,echoy;
	var ch1,ch2,ch3,ch4,c,angle;

	ch1=FreeVerb.ar(PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0, doneAction:2));
	ch2=FreeVerb.ar(PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2), loop: 0, doneAction:2));
	ch3=FreeVerb.ar(PlayBuf.ar(1, ~c3.bufnum, BufRateScale.kr(~c3), loop: 0, doneAction:2));
	ch4=FreeVerb.ar(PlayBuf.ar(1, ~c4.bufnum, BufRateScale.kr(~c4), loop: 0, doneAction:2));

	angle=Complex(posx,posy).theta;
	c=exp(Complex(0,1)*angle);

	Out.ar(0,Pan2.ar(ch1,c.imag.neg.round(0.0001),ampy));
	Out.ar(0,Pan2.ar(ch2,c.imag.round(0.0001).poll,ampy));
	Out.ar(0,Pan2.ar(ch3,c.real.round(0.0001).poll,ampx));
	Out.ar(0,Pan2.ar(ch4,c.real.neg.round(0.0001),ampx));
}.play;
);

Window.closeAll;
////////////////////////////////////////////////////////////////////////////////////////////////window
w = Window("Nest", Rect(100,10,300,300))
.front
.alwaysOnTop_(true);

				Slider2D(w, Rect(10,80,200,200))
				.background_(Color.rand)
	.x_(0)
	.y_(0)
	.action_({
		arg obj;
		var posx, posy, pl,echox, echoy, distx, disty;

	posy = obj.y.linlin(0,1,1.neg,1).round(0.0001);
	posx = obj.x.linlin(0,1,1.neg,1).round(0.0001);
	echox= obj.x.linlin(0,1,1.neg,1).abs.reciprocal.wrap(0,1).round(0.0001);
	echoy= obj.y.linlin(0,1,1.neg,1).abs.reciprocal.wrap(0,1).round(0.0001);
	distx= obj.x.linlin(0,1,10.neg,10).abs.linexp(0,10,0.01,10).round(0.0001);
	disty= obj.y.linlin(0,1,10.neg,10).abs.linexp(0,10,0.01,10).round(0.0001);
		pl = [posx, posy];
		//pl.postln;
	a.set(\posx,posx,\posy,posy,\ampx,distx,\ampy,disty,\echox,echox,\echoy,echoy);
});
)

