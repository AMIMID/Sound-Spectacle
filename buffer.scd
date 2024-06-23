
(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/15);
s.options.memSize = 8192*64;
s.options.blockSize = 16;
s.options.maxLogins = 32;
s.waitForBoot
)

Server.killAll
(
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt, 0),k = Quaternion(0, 0, 0, (1/3).sqrt),q1,q2,v1,v2,v3,angle=0,ph1x,ph1y,ph1z,ph2x,ph2y,ph2z,ph3x,ph3y,ph3z;


10.do{
	angle=(angle+(137.5)).wrap(0,360);
 	q1=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	v1=Quaternion(0,1,2,3);
	v1=q1*v1;
 	//v1.coordinates.round(0.0001).postln;
	v1.b.postln;
	ph1x=Complex(v1.a.round(0.0001),v1.b.round(0.0001)).phase;
	ph1y=Complex(v1.a.round(0.0001),v1.c.round(0.0001)).phase;
	ph1z=Complex(v1.a.round(0.0001),v1.d.round(0.0001)).phase;
	//ph1x.postln;
	//ph1y.postln;
	//ph1z.postln;
 }

)
2.7713283734942
3.0323613723907
2.4481334285491

~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/analogue dreams.wav",channels:0 );
(
(
SynthDef("help-phaseShift", { arg out=0;
        var in, chain;
        in = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0);
        chain = FFT(LocalBuf(2048), in);
        chain = PV_PhaseShift(chain,0.degrad);
        Out.ar(out, 0.1 * IFFT(chain));
}).play(s);
);
(
SynthDef("help-phaseShift", { arg out=1;
        var in, chain;
        in = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0);
        chain = FFT(LocalBuf(2048), in);
        chain = PV_PhaseShift(chain,90.degrad);
        Out.ar(out, 0.1 * IFFT(chain));
}).play(s);
);
(
SynthDef("help-phaseShift", { arg out=2;
        var in, chain;
        in = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0);
        chain = FFT(LocalBuf(2048), in);
        chain = PV_PhaseShift(chain,2.4481334285491);
        Out.ar(out, 0.1 * IFFT(chain));
}).play(s);
);
)

s.record(numChannels:3)

(
~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/SC_240603_090817.wav",channels:0 );
~c2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/SC_240603_090817.wav",channels:1 );
~c3 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/SC_240603_090817.wav",channels:1 );
)





(
{
    var in1,in2,in3, chainx,chainy,chainz,b=0,detune1,angle=0,sx,sy,sz,tx,ty,tz;
	var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt, 0),k = Quaternion(0, 0, 0, (1/3).sqrt);
	var v,q,vp,chainxx,chainyy,chainzz;

    in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0);
	 in2 = PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2), loop: 0);
in3 = PlayBuf.ar(1, ~c3.bufnum, BufRateScale.kr(~c3), loop: 0);


	vp=[1,2,3].normalizeSum;

	v=Quaternion(0,vp.[0].sqrt,vp.[1].sqrt,vp.[2].sqrt);
	angle=((360-(360/1.6180339887499)));

	chainx = FFT(LocalBuf(1024), in1);
		chainy = FFT(LocalBuf(1024), in2);
	  chainz = FFT(LocalBuf(1024), in3);

   250.do{



		q=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i+j+k)));
		v=q*v*q.conjugate;


   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

   chainzz = chainz.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);


	b=b+1;


Out.ar(0,Pan2.ar(LeakDC.ar(IFFT(chainxx)),v.b));
Out.ar(0,Pan2.ar(LeakDC.ar(IFFT(chainyy)),v.c));
Out.ar(0,Pan2.ar(LeakDC.ar(IFFT(chainzz)),v.d));

	}
}.play
)


~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/165994__vflefevre__rain-gutter-spb-035.wav",channels:[0,1] );


(SynthDef.new(\oe, {
	var osc1;
	osc1=BBandPass.ar(PlayBuf.ar(2, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0),600,MouseX.kr(0.0001,1,1),MouseX.kr(1000,1,1));
	Out.ar(0,LeakDC.ar(osc1));
}).add;)

Synth(\oe);
s.record;

(
~fftsize=8192;
~hop=0.25;
~win=0;
~f={Buffer.alloc(s,~c1.duration.calcPVRecSize(~fftsize,~hop))}!2;
)
(
{
	var sig,chain,localbuf;
	sig=PlayBuf.ar(2, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0,doneAction:2);
	localbuf={LocalBuf.new(~fftsize)}!2;
	chain=FFT(localbuf,sig,~hop,~win);
	chain=PV_RecordBuf(chain,~f,run:1,hop:~hop,wintype:~win);
	0;
}.play;
)

(
x={
	var sig,chain,localbuf;
	localbuf={LocalBuf.new(~fftsize)}!2;
		chain=PV_PlayBuf(localbuf,~f,\rate.kr(1),loop:inf);
		sig=IFFT(chain,~win);
	}.play;
)

x.set(\rate,0);
x.set(\rate,1/1);
x.set(\rate,-2/3);
x.release(2);


//////////////////////

(
~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/165994__vflefevre__rain-gutter-spb-035.wav",channels:0 );
~c2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/165994__vflefevre__rain-gutter-spb-035.wav",channels:1 );
~c3 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/165994__vflefevre__rain-gutter-spb-035.wav",channels:1 );
)





(
SynthDef.new(\oa, {
	arg decay=0.5,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1,ng1=1,ng2=1,ng3=1;
    var in1,in2,in3, chainx,chainy,chainz,b=0,angle,r,i,j,k;
	var v,q,vp,env,chainxx,chainyy,chainzz;

    in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0);
	 in2 = PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2), loop: 0);
in3 = PlayBuf.ar(1, ~c3.bufnum, BufRateScale.kr(~c3), loop: 0);


	r=[rx,ry,rz].normalizeSum;

	i = Quaternion(0, r.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r.[2].sqrt);

	vp=[x,y,z].normalizeSum;


	v=Quaternion(0,vp.[0].sqrt*ng1,vp.[1].sqrt*ng2,vp.[2].sqrt*ng3);
	angle=((360-(360/1.6180339887499)));

env=EnvGen.ar(Env.perc(0.01,decay),doneAction:2);

	chainx = FFT(LocalBuf(1024), in1);
		chainy = FFT(LocalBuf(1024), in2);
	  chainz = FFT(LocalBuf(1024), in3);

   250.do{


		q=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i+j+k)));
		v=q*v*q.conjugate;


   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

   chainzz = chainz.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);


	b=b+1;


Out.ar(0,Pan2.ar(LeakDC.ar(IFFT(chainxx)),v.b,env));
Out.ar(0,Pan2.ar(LeakDC.ar(IFFT(chainyy)),v.c,env));
Out.ar(0,Pan2.ar(LeakDC.ar(IFFT(chainzz)),v.d,env));

	}
}).add;
)

Synth(\oa);

(
var  angle1=0,angle2=0,angle3=0,angle4=0,q1,q2,q3,q4,v1,v2,v3,v4,ph1,ph2,ph3,ph4,r,m=1;
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt, 0),k = Quaternion(0, 0, 0, (1/3).sqrt);

r=[1/2,2/3,3/4].normalizeSum;

v1=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);
v2=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);


	~phase1 = 10000.collect{
		angle1=((360-(360/1.6180339887499)));
		q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));
	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(0.25);
	};

~phase2 = 10000.collect{
		angle2=((360-(360/1.6180339887499)));
		q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(0.25);
	};

~phase3 = 10000.collect{
		angle3=((360-(360/1.6180339887499)));
		q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(0.25);

	};

~phase4 = 10000.collect{
		angle4=((360-(360/1.6180339887499)));
		q4=(cos(angle4.degrad/2)+(sin(angle4.degrad/2)*(i+j+k)));
	v4=q4*v4*q4.conjugate;
	ph4=(v4.d*m).round(0.25);
	};

)


(
a=Pdef(\1, Pbind(\instrument, \oa,
		\dur,Pseq(~phase4.abs,inf),
	//\dur,1,
//		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\x,Pbrown(0,1,0.1,inf),
	\y,Pbrown(0,1,0.1,inf),
	\z,Pbrown(0,1,0.1,inf),
	\rx,Pbrown(0,1,0.1,inf),
	\ry,Pbrown(0,1,0.1,inf),
	\rz,Pbrown(0,1,0.1,inf),
		\ng1,Prand([1.neg,1,1.neg,1],inf),
	\ng2,Prand([1.neg,1,1.neg,1],inf),
	\ng3,Prand([1.neg,1,1.neg,1],inf),
	\decay,0.03;
));
)


(
a.play;


)
