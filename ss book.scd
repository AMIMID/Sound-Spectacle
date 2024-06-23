
(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*64;
s.options.blockSize = 16;
s.options.maxLogins = 32;
s.waitForBoot
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
///////////////////////////////////////////////////////////////////////

Buffer.freeAll
(
// 3D
~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
)

(
// 3D random
~a = VBAPSpeakerArray.new(3, [[180.rand2, 90.rand2], [180.rand2, 90.rand2], [180.rand2, 90.rand2], [180.rand2, 90.rand2]]);
~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
)

(
~c1 = Buffer.readChannel(s,,channels:0 );
~c2 = Buffer.readChannel(s,,channels:1 );
~c3 = Buffer.readChannel(s,,channels:0 );
~c4 = Buffer.readChannel(s,,channels:1 );
~c5 = Buffer.readChannel(s,,channels:0 );
~c6 = Buffer.readChannel(s,,channels:1 );
~c7 = Buffer.readChannel(s,,channels:0 );
~c8 = Buffer.readChannel(s,,channels:1 );
~c9 = Buffer.readChannel(s,,channels:0 );
~c10 = Buffer.readChannel(s,,channels:1 );
~c11 = Buffer.readChannel(s,,channels:0 );
~c12 = Buffer.readChannel(s,,channels:1 );
~c13 = Buffer.readChannel(s,,channels:0 );
~c14 = Buffer.readChannel(s,,channels:1 );
~c15 = Buffer.readChannel(s,,channels:0 );
~c16 = Buffer.readChannel(s,,channels:1 );
)




(
(
SynthDef.new(\o1, {
    var in1,in2, chainx,chainy,b=0,angle,r1,r2,i,j,k,i1,j1,k1;
	var v,q,q1,v1,vp,chainxx,chainyy,cva,cvb;

    in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2), loop: 0, doneAction:2);

	vp=[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;
	v=Quaternion(0,vp.[0].sqrt.neg,vp.[1].sqrt,vp.[2].sqrt);
	v1=Quaternion(0,vp.[0].sqrt.neg,vp.[1].sqrt,vp.[2].sqrt);

	angle=((360-(360/1.6180339887499)));

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{

	r1=[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;
	r2=[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;

	i = Quaternion(0, r1.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r1.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r1.[2].sqrt);
	i1 = Quaternion(0, r2.[0].sqrt, 0, 0);
	j1 = Quaternion(0, 0,r2.[1].sqrt, 0);
	k1 = Quaternion(0, 0, 0, r2.[2].sqrt);

	q=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i+j+k)));
	q1=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i1+j1+k1)));
	v=q*v*q.conjugate;
	v1=q1*v1*q1.conjugate;

	cva=Cartesian(v.b,v.c,v.d);
	cvb=Cartesian(v1.b,v1.c,v1.d);

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,cva.theta.degrad,cva.phi.degrad));
		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,cvb.theta.degrad,cvb.phi.degrad));


	}
}).add;
);
(
SynthDef.new(\o2, {
    var in1,in2, chainx,chainy,b=0,angle,r1,r2,i,j,k,i1,j1,k1;
	var v,q,q1,v1,vp,chainxx,chainyy,cva,cvb;

    in1 = PlayBuf.ar(1, ~c3.bufnum, BufRateScale.kr(~c3), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c4.bufnum, BufRateScale.kr(~c4), loop: 0, doneAction:2);

	vp=[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;
	v=Quaternion(0,vp.[0].sqrt.neg,vp.[1].sqrt,vp.[2].sqrt);
	v1=Quaternion(0,vp.[0].sqrt.neg,vp.[1].sqrt,vp.[2].sqrt);

	angle=((360-(360/1.6180339887499)));

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{

	r1=[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;
	r2=[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;

	i = Quaternion(0, r1.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r1.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r1.[2].sqrt);
	i1 = Quaternion(0, r2.[0].sqrt, 0, 0);
	j1 = Quaternion(0, 0,r2.[1].sqrt, 0);
	k1 = Quaternion(0, 0, 0, r2.[2].sqrt);

	q=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i+j+k)));
	q1=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i1+j1+k1)));
	v=q*v*q.conjugate;
	v1=q1*v1*q1.conjugate;

	cva=Cartesian(v.b,v.c,v.d);
	cvb=Cartesian(v1.b,v1.c,v1.d);

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,cva.theta.degrad,cva.phi.degrad));
		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,cvb.theta.degrad,cvb.phi.degrad));


	}
}).add;
);
(
SynthDef.new(\o3, {
    var in1,in2, chainx,chainy,b=0,angle,r1,r2,i,j,k,i1,j1,k1;
	var v,q,q1,v1,vp,chainxx,chainyy,cva,cvb;

    in1 = PlayBuf.ar(1, ~c5.bufnum, BufRateScale.kr(~c5), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c6.bufnum, BufRateScale.kr(~c6), loop: 0, doneAction:2);

	vp=[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;
	v=Quaternion(0,vp.[0].sqrt.neg,vp.[1].sqrt,vp.[2].sqrt);
	v1=Quaternion(0,vp.[0].sqrt.neg,vp.[1].sqrt,vp.[2].sqrt);

	angle=((360-(360/1.6180339887499)));

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{

	r1=[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;
	r2=[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;

	i = Quaternion(0, r1.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r1.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r1.[2].sqrt);
	i1 = Quaternion(0, r2.[0].sqrt, 0, 0);
	j1 = Quaternion(0, 0,r2.[1].sqrt, 0);
	k1 = Quaternion(0, 0, 0, r2.[2].sqrt);

	q=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i+j+k)));
	q1=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i1+j1+k1)));
	v=q*v*q.conjugate;
	v1=q1*v1*q1.conjugate;

	cva=Cartesian(v.b,v.c,v.d);
	cvb=Cartesian(v1.b,v1.c,v1.d);

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,cva.theta.degrad,cva.phi.degrad));
		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,cvb.theta.degrad,cvb.phi.degrad));


	}
}).add;
);
(
SynthDef.new(\o4, {
    var in1,in2, chainx,chainy,b=0,angle,r1,r2,i,j,k,i1,j1,k1;
	var v,q,q1,v1,vp,chainxx,chainyy,cva,cvb;

    in1 = PlayBuf.ar(1, ~c7.bufnum, BufRateScale.kr(~c7), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c8.bufnum, BufRateScale.kr(~c8), loop: 0, doneAction:2);

	vp=[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;
	v=Quaternion(0,vp.[0].sqrt.neg,vp.[1].sqrt,vp.[2].sqrt);
	v1=Quaternion(0,vp.[0].sqrt.neg,vp.[1].sqrt,vp.[2].sqrt);

	angle=((360-(360/1.6180339887499)));

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{

	r1=[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;
	r2=[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;

	i = Quaternion(0, r1.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r1.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r1.[2].sqrt);
	i1 = Quaternion(0, r2.[0].sqrt, 0, 0);
	j1 = Quaternion(0, 0,r2.[1].sqrt, 0);
	k1 = Quaternion(0, 0, 0, r2.[2].sqrt);

	q=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i+j+k)));
	q1=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i1+j1+k1)));
	v=q*v*q.conjugate;
	v1=q1*v1*q1.conjugate;

	cva=Cartesian(v.b,v.c,v.d);
	cvb=Cartesian(v1.b,v1.c,v1.d);

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,cva.theta.degrad,cva.phi.degrad));
		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,cvb.theta.degrad,cvb.phi.degrad));


	}
}).add;
);
(
SynthDef.new(\o5, {
    var in1,in2, chainx,chainy,b=0,angle,r1,r2,i,j,k,i1,j1,k1;
	var v,q,q1,v1,vp,chainxx,chainyy,cva,cvb;

    in1 = PlayBuf.ar(1, ~c9.bufnum, BufRateScale.kr(~c9), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c10.bufnum, BufRateScale.kr(~c10), loop: 0, doneAction:2);

	vp=[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;
	v=Quaternion(0,vp.[0].sqrt.neg,vp.[1].sqrt,vp.[2].sqrt);
	v1=Quaternion(0,vp.[0].sqrt.neg,vp.[1].sqrt,vp.[2].sqrt);

	angle=((360-(360/1.6180339887499)));

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{

	r1=[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;
	r2=[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;

	i = Quaternion(0, r1.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r1.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r1.[2].sqrt);
	i1 = Quaternion(0, r2.[0].sqrt, 0, 0);
	j1 = Quaternion(0, 0,r2.[1].sqrt, 0);
	k1 = Quaternion(0, 0, 0, r2.[2].sqrt);

	q=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i+j+k)));
	q1=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i1+j1+k1)));
	v=q*v*q.conjugate;
	v1=q1*v1*q1.conjugate;

	cva=Cartesian(v.b,v.c,v.d);
	cvb=Cartesian(v1.b,v1.c,v1.d);

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,cva.theta.degrad,cva.phi.degrad));
		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,cvb.theta.degrad,cvb.phi.degrad));


	}
}).add;
);
(
SynthDef.new(\o6, {
    var in1,in2, chainx,chainy,b=0,angle,r1,r2,i,j,k,i1,j1,k1;
	var v,q,q1,v1,vp,chainxx,chainyy,cva,cvb;

    in1 = PlayBuf.ar(1, ~c11.bufnum, BufRateScale.kr(~c11), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c12.bufnum, BufRateScale.kr(~c12), loop: 0, doneAction:2);

	vp=[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;
	v=Quaternion(0,vp.[0].sqrt.neg,vp.[1].sqrt,vp.[2].sqrt);
	v1=Quaternion(0,vp.[0].sqrt.neg,vp.[1].sqrt,vp.[2].sqrt);

	angle=((360-(360/1.6180339887499)));

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{

	r1=[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;
	r2=[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;

	i = Quaternion(0, r1.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r1.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r1.[2].sqrt);
	i1 = Quaternion(0, r2.[0].sqrt, 0, 0);
	j1 = Quaternion(0, 0,r2.[1].sqrt, 0);
	k1 = Quaternion(0, 0, 0, r2.[2].sqrt);

	q=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i+j+k)));
	q1=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i1+j1+k1)));
	v=q*v*q.conjugate;
	v1=q1*v1*q1.conjugate;

	cva=Cartesian(v.b,v.c,v.d);
	cvb=Cartesian(v1.b,v1.c,v1.d);

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,cva.theta.degrad,cva.phi.degrad));
		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,cvb.theta.degrad,cvb.phi.degrad));


	}
}).add;
);
(
SynthDef.new(\o7, {
    var in1,in2, chainx,chainy,b=0,angle,r1,r2,i,j,k,i1,j1,k1;
	var v,q,q1,v1,vp,chainxx,chainyy,cva,cvb;

    in1 = PlayBuf.ar(1, ~c13.bufnum, BufRateScale.kr(~c13), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c14.bufnum, BufRateScale.kr(~c14), loop: 0, doneAction:2);

	vp=[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;
	v=Quaternion(0,vp.[0].sqrt.neg,vp.[1].sqrt,vp.[2].sqrt);
	v1=Quaternion(0,vp.[0].sqrt.neg,vp.[1].sqrt,vp.[2].sqrt);

	angle=((360-(360/1.6180339887499)));

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{

	r1=[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;
	r2=[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;

	i = Quaternion(0, r1.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r1.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r1.[2].sqrt);
	i1 = Quaternion(0, r2.[0].sqrt, 0, 0);
	j1 = Quaternion(0, 0,r2.[1].sqrt, 0);
	k1 = Quaternion(0, 0, 0, r2.[2].sqrt);

	q=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i+j+k)));
	q1=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i1+j1+k1)));
	v=q*v*q.conjugate;
	v1=q1*v1*q1.conjugate;

	cva=Cartesian(v.b,v.c,v.d);
	cvb=Cartesian(v1.b,v1.c,v1.d);

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,cva.theta.degrad,cva.phi.degrad));
		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,cvb.theta.degrad,cvb.phi.degrad));


	}
}).add;
);
(
SynthDef.new(\o8, {
    var in1,in2, chainx,chainy,b=0,angle,r1,r2,i,j,k,i1,j1,k1;
	var v,q,q1,v1,vp,chainxx,chainyy,cva,cvb;

    in1 = PlayBuf.ar(1, ~c15.bufnum, BufRateScale.kr(~c15), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c16.bufnum, BufRateScale.kr(~c16), loop: 0, doneAction:2);

	vp=[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;
	v=Quaternion(0,vp.[0].sqrt.neg,vp.[1].sqrt,vp.[2].sqrt);
	v1=Quaternion(0,vp.[0].sqrt.neg,vp.[1].sqrt,vp.[2].sqrt);

	angle=((360-(360/1.6180339887499)));

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{

	r1=[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;
	r2=[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;

	i = Quaternion(0, r1.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r1.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r1.[2].sqrt);
	i1 = Quaternion(0, r2.[0].sqrt, 0, 0);
	j1 = Quaternion(0, 0,r2.[1].sqrt, 0);
	k1 = Quaternion(0, 0, 0, r2.[2].sqrt);

	q=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i+j+k)));
	q1=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i1+j1+k1)));
	v=q*v*q.conjugate;
	v1=q1*v1*q1.conjugate;

	cva=Cartesian(v.b,v.c,v.d);
	cvb=Cartesian(v1.b,v1.c,v1.d);

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,cva.theta.degrad,cva.phi.degrad));
		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,cvb.theta.degrad,cvb.phi.degrad));


	}
}).add;
);
)

(
Synth(\o1);
s.record(numChannels:4)
Synth(\o2);
s.record(numChannels:4)
Synth(\o3);
s.record(numChannels:4)
Synth(\o4);
s.record(numChannels:4)
Synth(\o5);
s.record(numChannels:4)
Synth(\o6);
s.record(numChannels:4)
Synth(\o7);
s.record(numChannels:4)
Synth(\o8);
s.record(numChannels:4)
)

/////////////////////////////////////////////////////////////////////////

Buffer.freeAll
(
// 3D
~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
)

(
// 3D random
~a = VBAPSpeakerArray.new(3, [[180.rand2, 90.rand2], [180.rand2, 90.rand2], [180.rand2, 90.rand2], [180.rand2, 90.rand2]]);
~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
)



(
SynthDef.new(\oa, {
	arg  n1=1, cutt=440,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1,ry=1,rz=1,rx1=1,ry1=1,rz1=1,ng1=1,ng2=1,ng3=1,ng4=1,ng5=1,ng6=1;
	var q,q1,i,j,k,i1,j1,k1,va,vb,cva,cvb,phx,phy;
	var freq, env1,env2,m=1,bank, pitch, fund, angle=0,angle1=90,r1,r2,p;
	var osc1_x,osc1_y,ang=(360-(360/1.6180339887499));
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	r1=[rx,ry,rz].normalizeSum;
	r2=[rx1,ry1,rz1].normalizeSum;

	i = Quaternion(0, r1.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r1.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r1.[2].sqrt);

	i1 = Quaternion(0, r2.[0].sqrt, 0, 0);
	j1 = Quaternion(0, 0,r2.[1].sqrt, 0);
	k1 = Quaternion(0, 0, 0, r2.[2].sqrt);

	p=[x,y,z].normalizeSum;

	va=Quaternion(0,p.[0].sqrt*ng1,p.[1].sqrt*ng2,p.[2].sqrt*ng3);
	vb=Quaternion(0,p.[0].sqrt*ng4,p.[1].sqrt*ng5,p.[2].sqrt*ng6);

	bank=8;
	pitch=2.pow(n1/(2*6));
	fund=(((4*2)-1)*((4*2)/2));
	freq = (fund*6)*pitch;

	bank.do{

angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);

	q=(cos(ang.degrad/2)+(sin(ang.degrad/2)*(i+j+k)));
	q1=(cos(ang.degrad/2)+(sin(ang.degrad/2)*(i1+j1+k1)));

	va=q*va*q.conjugate;

	vb=q1*vb*q1.conjugate;

	cva=Cartesian(va.b,va.c,va.d);
	cvb=Cartesian(vb.b,vb.c,vb.d);

	phx=exp(Complex(0,1)*(angle.degrad)).phase;
	phy=exp(Complex(0,1)*(angle1.degrad)).phase;


env1=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:phx.real.round(0.0001));
env2=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:phx.imag.round(0.0001));

osc1_x=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,phx,2pi)),~b.bufnum,cva.theta.degrad,cva.phi.degrad);
osc1_y=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,phy,2pi)),~b.bufnum,cvb.theta.degrad,cvb.phi.degrad);

m=m+1;

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env1),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc1_y)*env2),cutt));

	//Out.ar(0,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));


	};
}).add;
);
)



(
var  angle1=0,angle2=0,angle3=0,angle4=0,q1,q2,q3,q4,v1,v2,v3,v4,ph1,ph2,ph3,ph4,r,m=2;
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt, 0),k = Quaternion(0, 0, 0, (1/3).sqrt);
var i1=0,i2=0,i3=0,i4=0;

r=[1/2,2/3,3/4].normalizeSum;

v1=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);
v2=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);

~axis=10000.collect{[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;};

	~phase1 = 10000.collect{
		angle1=((360-(360/1.6180339887499)));
		q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));
	i=Quaternion(0,~axis.[i1].[0].sqrt,0,0);
	j=Quaternion(0,0,~axis.[i1].[1].sqrt,0);
	k=Quaternion(0,0,0,~axis.[i1].[2].sqrt);
	i1=i1+1;
	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(0.25);
	};

~phase2 = 10000.collect{
		angle2=((360-(360/1.6180339887499)));
		q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
	i=Quaternion(0,~axis.[i2].[0].sqrt,0,0);
	j=Quaternion(0,0,~axis.[i2].[1].sqrt,0);
	k=Quaternion(0,0,0,~axis.[i2].[2].sqrt);
	i2=i2+1;
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(0.25);
	};

~phase3 = 10000.collect{
		angle3=((360-(360/1.6180339887499)));
		q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
	i=Quaternion(0,~axis.[i3].[0].sqrt,0,0);
	j=Quaternion(0,0,~axis.[i3].[1].sqrt,0);
	k=Quaternion(0,0,0,~axis.[i3].[2].sqrt);
	i3=i3+1;
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(0.25);

	};

~phase4 = 10000.collect{
		angle4=((360-(360/1.6180339887499)));
		q4=(cos(angle4.degrad/2)+(sin(angle4.degrad/2)*(i+j+k)));
	i=Quaternion(0,~axis.[i4].[0].sqrt,0,0);
	j=Quaternion(0,0,~axis.[i4].[1].sqrt,0);
	k=Quaternion(0,0,0,~axis.[i4].[2].sqrt);
	i4=i4+1;
	v4=q4*v4*q4.conjugate;
	ph4=(v4.d*m).round(0.25);
	};

);


(
var  angle1=0,angle2=0,angle3=0,angle4=0,q1,q2,q3,q4,v1,v2,v3,v4,ph1,ph2,ph3,ph4,r,m=12;
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt, 0),k = Quaternion(0, 0, 0, (1/3).sqrt),n1,n2,n3,n4;
var i1=0,i2=0,i3=0,i4=0;

r=[1/2,2/3,3/4].normalizeSum;

v1=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);
v2=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);

~axis=10000.collect{[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;};

	~n1 = 10000.collect{
		angle1=((360-(360/1.6180339887499)));
		q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));
		i=Quaternion(0,~axis.[i1].[0].sqrt,0,0);
	j=Quaternion(0,0,~axis.[i1].[1].sqrt,0);
	k=Quaternion(0,0,0,~axis.[i1].[2].sqrt);
	i1=i1+1;
	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(1);
	};
~n2 = 10000.collect{
		angle2=((360-(360/1.6180339887499)));
		q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
		i=Quaternion(0,~axis.[i2].[0].sqrt,0,0);
	j=Quaternion(0,0,~axis.[i2].[1].sqrt,0);
	k=Quaternion(0,0,0,~axis.[i2].[2].sqrt);
	i2=i2+1;
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(1);
	};

~n3 = 10000.collect{
		angle3=((360-(360/1.6180339887499)));
		q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
		i=Quaternion(0,~axis.[i3].[0].sqrt,0,0);
	j=Quaternion(0,0,~axis.[i3].[1].sqrt,0);
	k=Quaternion(0,0,0,~axis.[i3].[2].sqrt);
	i3=i3+1;
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(1);
	};

~n4 = 10000.collect{
		angle4=((360-(360/1.6180339887499)));
		q4=(cos(angle4.degrad/2)+(sin(angle4.degrad/2)*(i+j+k)));
		i=Quaternion(0,~axis.[i4].[0].sqrt,0,0);
	j=Quaternion(0,0,~axis.[i4].[1].sqrt,0);
	k=Quaternion(0,0,0,~axis.[i4].[2].sqrt);
	i4=i4+1;
	v4=q4*v4*q4.conjugate;
	ph4=(v4.d*m).round(1);

	};

)


(
~n1=~n1*(2);
~n2=~n2*(2);
~n3=~n3*(2);
~n4=~n4*(2);
)

Scale.directory


(
b=Pdef(\2, Pbind(\instrument, \ob,
	//\dur,1/2,
	\dur,Pseq(~phase2.abs,inf),
\n1,PdegreeToKey(Pseq(~n2,1),Scale.phrygian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\x,Pbrown(0,1,0.1,inf),
	\y,Pbrown(0,1,0.1,inf),
	\z,Pbrown(0,1,0.1,inf),
	\rx,Pbrown(0,1,0.1,inf),
	\ry,Pbrown(0,1,0.1,inf),
	\rz,Pbrown(0,1,0.1,inf),
		\rx1,Pbrown(0,1,0.1,inf),
	\ry1,Pbrown(0,1,0.1,inf),
	\rz1,Pbrown(0,1,0.1,inf),
		\ng1,Prand([1.neg,1,1.neg,1],inf),
	\ng2,Prand([1.neg,1,1.neg,1],inf),
	\ng3,Prand([1.neg,1,1.neg,1],inf),
			\ng4,Prand([1.neg,1,1.neg,1],inf),
	\ng5,Prand([1.neg,1,1.neg,1],inf),
	\ng6,Prand([1.neg,1,1.neg,1],inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	//\dur,1/2,
	\dur,Pseq(~phase3.abs,inf),
\n1,PdegreeToKey(Pseq(~n3,1),Scale.phrygian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\x,Pbrown(0,1,0.1,inf),
	\y,Pbrown(0,1,0.1,inf),
	\z,Pbrown(0,1,0.1,inf),
	\rx,Pbrown(0,1,0.1,inf),
	\ry,Pbrown(0,1,0.1,inf),
	\rz,Pbrown(0,1,0.1,inf),
		\rx1,Pbrown(0,1,0.1,inf),
	\ry1,Pbrown(0,1,0.1,inf),
	\rz1,Pbrown(0,1,0.1,inf),
		\ng1,Prand([1.neg,1,1.neg,1],inf),
	\ng2,Prand([1.neg,1,1.neg,1],inf),
	\ng3,Prand([1.neg,1,1.neg,1],inf),
			\ng4,Prand([1.neg,1,1.neg,1],inf),
	\ng5,Prand([1.neg,1,1.neg,1],inf),
	\ng6,Prand([1.neg,1,1.neg,1],inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	//\dur,1/2,
	\dur,Pseq(~phase4.abs,inf),
\n1,PdegreeToKey(Pseq(~n4,1),Scale.phrygian),
	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\x,Pbrown(0,1,0.1,inf),
	\y,Pbrown(0,1,0.1,inf),
	\z,Pbrown(0,1,0.1,inf),
	\rx,Pbrown(0,1,0.1,inf),
	\ry,Pbrown(0,1,0.1,inf),
	\rz,Pbrown(0,1,0.1,inf),
	\rx1,Pbrown(0,1,0.1,inf),
	\ry1,Pbrown(0,1,0.1,inf),
	\rz1,Pbrown(0,1,0.1,inf),
		\ng1,Prand([1.neg,1,1.neg,1],inf),
	\ng2,Prand([1.neg,1,1.neg,1],inf),
	\ng3,Prand([1.neg,1,1.neg,1],inf),
		\ng4,Prand([1.neg,1,1.neg,1],inf),
	\ng5,Prand([1.neg,1,1.neg,1],inf),
	\ng6,Prand([1.neg,1,1.neg,1],inf),
	\decay,Pbrown(2,8,1,inf);
));
);

(
b.play;
c.play;
d.play;
s.record(numChannels:4)
)