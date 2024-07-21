
(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*64;
//s.options.blockSize = 64/4;
s.options.maxNodes = 1024 * 64;
s.waitForBoot
)

//////////phase shift
~c1 = Buffer.readChannel(s,,channels:0 );
(
(
SynthDef("help-phaseShift", { arg out=0;
        var in, chain;
        in = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0);
        chain = FFT(LocalBuf(2048), in);
        chain = PV_PhaseShift(chain,90.degrad);
        Out.ar(out, 0.1 * IFFT(chain));
}).play(s);
);
)

s.record(numChannels:1)

/////////////freeze

~c1 = Buffer.readChannel(s,,channels:[0,1] );

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

/////////////////synth
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
);

(
(
SynthDef.new(\o1, {
	arg n=1,decay=2,x=1,y=1,z=1,x1=1,y1=1,z1=1,rx=1,ry=1,rz=1,rx1=1,ry1=1,rz1=1,buffer1=0,buffer2=0;
    var in1,in2, chainx,chainy,b=0,ang,r1,r2,i,j,k,i1,j1,k1;
	var v,q,q1,v1,vp,vp1,chainxx,chainyy,cva,cvb,pitch,env,vektor,vektor1,qv;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	pitch=2.pow(n/12);

	env=EnvGen.ar(Env.perc(0.01,decay,pitch.reciprocal),doneAction:2);

	in1 = PitchShift.ar(PlayBuf.ar(1, buffer1, BufRateScale.kr(buffer1), loop: 0, doneAction:2),pitchRatio:pitch,mul:env);
	in2 = PitchShift.ar(PlayBuf.ar(1, buffer2, BufRateScale.kr(buffer2), loop: 0, doneAction:2),pitchRatio:pitch,mul:env);

	r1=[rx,ry,rz];
	r2=[rx1,ry1,rz1];

	i = Quaternion(0, r1.[0], 0, 0);
	j = Quaternion(0, 0,r1.[1], 0);
	k = Quaternion(0, 0, 0, r1.[2]);
	i1 = Quaternion(0, r2.[0], 0, 0);
	j1 = Quaternion(0, 0,r2.[1], 0);
	k1 = Quaternion(0, 0, 0, r2.[2]);

	vektor=i+j+k;
	vektor1=i1+j1+k1;

	vp=[x,y,z];
	vp1=[x1,y1,z1];

	v=Quaternion(0,vp.[0],vp.[1],vp.[2]);
	v1=Quaternion(0,vp1.[0],vp1.[1],vp1.[2]);

	ang=((360-(360/1.6180339887499)));

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{
	qv=(cos(ang.degrad/2)+(sin(ang.degrad/2)*(Quaternion(0,0,0,1))));

	vektor=qv*vektor*qv.conjugate;
	vektor1=qv*vektor1*qv.conjugate;

	q=(cos(ang.degrad/2)+(sin(ang.degrad/2)*(vektor)));
	q1=(cos(ang.degrad/2)+(sin(ang.degrad/2)*(vektor1)));

	v=q*v*q.conjugate;
	v1=q1*v1*q1.conjugate;

	cva=Cartesian(v.b,v.c,v.d);
	cvb=Cartesian(v1.b,v1.c,v1.d);

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;
	wrappedOut1.value(out,VBAP.ar(4,IFFT(chainxx),~b.bufnum,cva.theta.raddeg,cva.phi.raddeg)*env);
	wrappedOut2.value(out,VBAP.ar(4,IFFT(chainyy),~b.bufnum,cvb.theta.raddeg,cvb.phi.raddeg)*env);
	}
}).add;
);
(
SynthDef.new(\o2, {
	arg n=1,decay=2,x=1,y=1,z=1,x1=1,y1=1,z1=1,rx=1,ry=1,rz=1,rx1=1,ry1=1,rz1=1,buffer1=0,buffer2=0;
    var in1,in2, chainx,chainy,b=0,ang,r1,r2,i,j,k,i1,j1,k1;
	var v,q,q1,v1,vp,vp1,chainxx,chainyy,cva,cvb,pitch,env,vektor,vektor1,qv;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	pitch=2.pow(n/12);

	env=EnvGen.ar(Env.perc(0.01,decay,pitch.reciprocal),doneAction:2);

	in1 = PitchShift.ar(PlayBuf.ar(1, buffer1, BufRateScale.kr(buffer1), loop: 0, doneAction:2),pitchRatio:pitch,mul:env);
	in2 = PitchShift.ar(PlayBuf.ar(1, buffer2, BufRateScale.kr(buffer2), loop: 0, doneAction:2),pitchRatio:pitch,mul:env);

	r1=[rx,ry,rz];
	r2=[rx1,ry1,rz1];

	i = Quaternion(0, r1.[0], 0, 0);
	j = Quaternion(0, 0,r1.[1], 0);
	k = Quaternion(0, 0, 0, r1.[2]);
	i1 = Quaternion(0, r2.[0], 0, 0);
	j1 = Quaternion(0, 0,r2.[1], 0);
	k1 = Quaternion(0, 0, 0, r2.[2]);

	vektor=i+j+k;
	vektor1=i1+j1+k1;

	vp=[x,y,z];
	vp1=[x1,y1,z1];

	v=Quaternion(0,vp.[0],vp.[1],vp.[2]);
	v1=Quaternion(0,vp1.[0],vp1.[1],vp1.[2]);

	ang=((360-(360/1.6180339887499)));

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{
	qv=(cos(ang.degrad/2)+(sin(ang.degrad/2)*(Quaternion(0,0,0,1))));

	vektor=qv*vektor*qv.conjugate;
	vektor1=qv*vektor1*qv.conjugate;

	q=(cos(ang.degrad/2)+(sin(ang.degrad/2)*(vektor)));
	q1=(cos(ang.degrad/2)+(sin(ang.degrad/2)*(vektor1)));

	v=q*v*q.conjugate;
	v1=q1*v1*q1.conjugate;

	cva=Cartesian(v.b,v.c,v.d);
	cvb=Cartesian(v1.b,v1.c,v1.d);

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;
	wrappedOut1.value(out,VBAP.ar(4,IFFT(chainxx),~b.bufnum,cva.theta.raddeg,cva.phi.raddeg)*env);
	wrappedOut2.value(out,VBAP.ar(4,IFFT(chainyy),~b.bufnum,cvb.theta.raddeg,cvb.phi.raddeg)*env);
	}
}).add;
);
(
SynthDef.new(\o3, {
	arg n=1,decay=2,x=1,y=1,z=1,x1=1,y1=1,z1=1,rx=1,ry=1,rz=1,rx1=1,ry1=1,rz1=1,buffer1=0,buffer2=0;
    var in1,in2, chainx,chainy,b=0,ang,r1,r2,i,j,k,i1,j1,k1;
	var v,q,q1,v1,vp,vp1,chainxx,chainyy,cva,cvb,pitch,env,vektor,vektor1,qv;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	pitch=2.pow(n/12);

	env=EnvGen.ar(Env.perc(0.01,decay,pitch.reciprocal),doneAction:2);

	in1 = PitchShift.ar(PlayBuf.ar(1, buffer1, BufRateScale.kr(buffer1), loop: 0, doneAction:2),pitchRatio:pitch,mul:env);
	in2 = PitchShift.ar(PlayBuf.ar(1, buffer2, BufRateScale.kr(buffer2), loop: 0, doneAction:2),pitchRatio:pitch,mul:env);

	r1=[rx,ry,rz];
	r2=[rx1,ry1,rz1];

	i = Quaternion(0, r1.[0], 0, 0);
	j = Quaternion(0, 0,r1.[1], 0);
	k = Quaternion(0, 0, 0, r1.[2]);
	i1 = Quaternion(0, r2.[0], 0, 0);
	j1 = Quaternion(0, 0,r2.[1], 0);
	k1 = Quaternion(0, 0, 0, r2.[2]);

	vektor=i+j+k;
	vektor1=i1+j1+k1;

	vp=[x,y,z];
	vp1=[x1,y1,z1];

	v=Quaternion(0,vp.[0],vp.[1],vp.[2]);
	v1=Quaternion(0,vp1.[0],vp1.[1],vp1.[2]);

	ang=((360-(360/1.6180339887499)));

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{
	qv=(cos(ang.degrad/2)+(sin(ang.degrad/2)*(Quaternion(0,0,0,1))));

	vektor=qv*vektor*qv.conjugate;
	vektor1=qv*vektor1*qv.conjugate;

	q=(cos(ang.degrad/2)+(sin(ang.degrad/2)*(vektor)));
	q1=(cos(ang.degrad/2)+(sin(ang.degrad/2)*(vektor1)));

	v=q*v*q.conjugate;
	v1=q1*v1*q1.conjugate;

	cva=Cartesian(v.b,v.c,v.d);
	cvb=Cartesian(v1.b,v1.c,v1.d);

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;
	wrappedOut1.value(out,VBAP.ar(4,IFFT(chainxx),~b.bufnum,cva.theta.raddeg,cva.phi.raddeg)*env);
	wrappedOut2.value(out,VBAP.ar(4,IFFT(chainyy),~b.bufnum,cvb.theta.raddeg,cvb.phi.raddeg)*env);
	}
}).add;
);
)

(
(
var  angle1=0,angle2=0,angle3=0,angle4=0,q1,q2,q3,q4,v1,v2,v3,v4,ph1,ph2,ph3,ph4,r,m=1;
var i = Quaternion(0, 0, 0, 0),j = Quaternion(0, 0, 0, 0),k = Quaternion(0, 0, 0, 1),n1,n2,n3,n4;
var i1=0,i2=0,i3=0,i4=0;

r=[1,0,0].normalizeSum;

v1=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);


	~pos1 = 100.collect{
		angle1=((360-(360/1.6180339887499)));
	q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));
	i1=i1+1;
	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(0.0001);
	};
~pos2 = 100.collect{
		angle2=((360-(360/1.6180339887499)));
	q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
	i2=i2+1;
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(0.0001);
	};

~pos3 = 100.collect{
		angle3=((360-(360/1.6180339887499)));
	q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
	i3=i3+1;
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(0.0001);
	};

~pos4 = 100.collect{
		angle4=((360-(360/1.6180339887499)));
	q4=(cos(angle4.degrad/2)+(sin(angle4.degrad/2)*(i+j+k)));
	i4=i4+1;
	v4=q4*v4*q4.conjugate;
	ph4=(v4.d*m).round(0.0001);

	};

);
(
var  angle1=0,angle2=0,angle3=0,angle4=0,q1,q2,q3,q4,v1,v2,v3,v4,ph1,ph2,ph3,ph4,r,m=1;
var i = Quaternion(0, 1, 0, 0),j = Quaternion(0, 0, 0, 0),k = Quaternion(0, 0, 0, 0),n1,n2,n3,n4;
var i1=0,i2=0,i3=0,i4=0;

r=[0,0,1].normalizeSum;

v1=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);


	~rot1 = 100.collect{
		angle1=((360-(360/1.6180339887499)));
	q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));
	i1=i1+1;
	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(0.0001);
	};
~rot2 = 100.collect{
		angle2=((360-(360/1.6180339887499)));
	q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
	i2=i2+1;
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(0.0001);
	};

~rot3 = 100.collect{
		angle3=((360-(360/1.6180339887499)));
	q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
	i3=i3+1;
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(0.0001);
	};

~rot4 = 100.collect{
		angle4=((360-(360/1.6180339887499)));
	q4=(cos(angle4.degrad/2)+(sin(angle4.degrad/2)*(i+j+k)));
	i4=i4+1;
	v4=q4*v4*q4.conjugate;
	ph4=(v4.d*m).round(0.0001);

	};

)
(
var  angle1=0,angle2=0,angle3=0,angle4=0,q1,q2,q3,q4,v1,v2,v3,v4,ph1,ph2,ph3,ph4,r,m=1;
var i = Quaternion(0, 1, 0, 0),j = Quaternion(0, 0, 0, 0),k = Quaternion(0, 0, 0, 0),n1,n2,n3,n4;
var i1=0,i2=0,i3=0,i4=0;

r=[0,1,2].normalizeSum;

v1=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);

~axis7=100.collect{[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;};

	~rotb1 = 100.collect{
		angle1=((360-(360/1.6180339887499)));
		i=Quaternion(0,~pos2.[i1],0,0);
	j=Quaternion(0,0,~pos3.[i1],0);
	k=Quaternion(0,0,0,~pos4.[i1]);
	q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));
	i1=i1+1;
	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(0.0001);
	};
~rotb2 = 100.collect{
		angle2=((360-(360/1.6180339887499)));
			i=Quaternion(0,~pos2.[i2],0,0);
	j=Quaternion(0,0,~pos3.[i2],0);
	k=Quaternion(0,0,0,~pos4.[i2]);
	q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
	i2=i2+1;
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(0.0001);
	};

~rotb3 = 100.collect{
		angle3=((360-(360/1.6180339887499)));
			i=Quaternion(0,~pos2.[i3],0,0);
	j=Quaternion(0,0,~pos3.[i3],0);
	k=Quaternion(0,0,0,~pos4.[i3]);
	q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
	i3=i3+1;
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(0.0001);
	};

~rotb4 = 100.collect{
		angle4=((360-(360/1.6180339887499)));
			i=Quaternion(0,~pos2.[i4],0,0);
	j=Quaternion(0,0,~pos3.[i4],0);
	k=Quaternion(0,0,0,~pos4.[i4]);
	q4=(cos(angle4.degrad/2)+(sin(angle4.degrad/2)*(i+j+k)));
	i4=i4+1;
	v4=q4*v4*q4.conjugate;
	ph4=(v4.d*m).round(0.0001);

	};

);
(
var  angle1=0,angle2=0,angle3=0,angle4=0,q1,q2,q3,q4,v1,v2,v3,v4,ph1,ph2,ph3,ph4,r,m=1;
var i = Quaternion(0, 1, 0, 0),j = Quaternion(0, 0, 0, 0),k = Quaternion(0, 0, 0, 0),n1,n2,n3,n4;
var i1=0,i2=0,i3=0,i4=0;

r=[0,2,3].normalizeSum;

v1=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);

~axis8=100.collect{[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;};

	~rotc1 = 100.collect{
		angle1=((360-(360/1.6180339887499)));
			i=Quaternion(0,~pos2.[i1],0,0);
	j=Quaternion(0,0,~pos3.[i1],0);
	k=Quaternion(0,0,0,~pos4.[i1]);
	q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));
	i1=i1+1;
	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(0.0001);
	};
~rotc2 = 100.collect{
		angle2=((360-(360/1.6180339887499)));
			i=Quaternion(0,~pos2.[i2],0,0);
	j=Quaternion(0,0,~pos3.[i2],0);
	k=Quaternion(0,0,0,~pos4.[i2]);
	q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
	i2=i2+1;
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(0.0001);
	};

~rotc3 = 100.collect{
		angle3=((360-(360/1.6180339887499)));
			i=Quaternion(0,~pos2.[i3],0,0);
	j=Quaternion(0,0,~pos3.[i3],0);
	k=Quaternion(0,0,0,~pos4.[i3]);
	q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
	i3=i3+1;
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(0.0001);
	};

~rotc4 = 100.collect{
		angle4=((360-(360/1.6180339887499)));
			i=Quaternion(0,~pos2.[i4],0,0);
	j=Quaternion(0,0,~pos3.[i4],0);
	k=Quaternion(0,0,0,~pos4.[i4]);
	q4=(cos(angle4.degrad/2)+(sin(angle4.degrad/2)*(i+j+k)));
	i4=i4+1;
	v4=q4*v4*q4.conjugate;
	ph4=(v4.d*m).round(0.0001);

	};

);
(
var  angle1=0,angle2=0,angle3=0,angle4=0,q1,q2,q3,q4,v1,v2,v3,v4,ph1,ph2,ph3,ph4,r,m=1;
var i = Quaternion(0, 1, 0, 0),j = Quaternion(0, 0, 0, 0),k = Quaternion(0, 0, 0, 0),n1,n2,n3,n4;
var i1=0,i2=0,i3=0,i4=0;

r=[0,3,4].normalizeSum;

v1=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);

~axis9=100.collect{[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;};

	~rotd1 = 100.collect{
		angle1=((360-(360/1.6180339887499)));
				i=Quaternion(0,~pos2.[i1],0,0);
	j=Quaternion(0,0,~pos3.[i1],0);
	k=Quaternion(0,0,0,~pos4.[i1]);
	q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));
	i1=i1+1;
	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(0.0001);
	};
~rotd2 = 100.collect{
		angle2=((360-(360/1.6180339887499)));
				i=Quaternion(0,~pos2.[i2],0,0);
	j=Quaternion(0,0,~pos3.[i2],0);
	k=Quaternion(0,0,0,~pos4.[i2]);
	q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
	i2=i2+1;
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(0.0001);
	};

~rotd3 = 100.collect{
		angle3=((360-(360/1.6180339887499)));
				i=Quaternion(0,~pos2.[i3],0,0);
	j=Quaternion(0,0,~pos3.[i3],0);
	k=Quaternion(0,0,0,~pos4.[i3]);
	q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
	i3=i3+1;
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(0.0001);
	};

~rotd4 = 100.collect{
		angle4=((360-(360/1.6180339887499)));
				i=Quaternion(0,~pos2.[i4],0,0);
	j=Quaternion(0,0,~pos3.[i4],0);
	k=Quaternion(0,0,0,~pos4.[i4]);
	q4=(cos(angle4.degrad/2)+(sin(angle4.degrad/2)*(i+j+k)));
	i4=i4+1;
	v4=q4*v4*q4.conjugate;
	ph4=(v4.d*m).round(0.0001);

	};

);
(
var  angle1=0,angle2=0,angle3=0,angle4=0,q1,q2,q3,q4,v1,v2,v3,v4,ph1,ph2,ph3,ph4,r,m=1;
var i = Quaternion(0, 0, 0, 0),j = Quaternion(0, 0, 0, 0),k = Quaternion(0, 0, 0, 1),n1,n2,n3,n4;
var i1=0,i2=0,i3=0,i4=0;

r=[2,1,0].normalizeSum;

v1=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);

~axis4=100.collect{[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;};

	~posb1 = 100.collect{
		angle1=((360-(360/1.6180339887499)));
		i=Quaternion(0,~rot2.[i1],0,0);
	j=Quaternion(0,0,~rot3.[i1],0);
	k=Quaternion(0,0,0,~rot4.[i1]);
	q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));
	i1=i1+1;
	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(0.0001);
	};
~posb2 = 100.collect{
		angle2=((360-(360/1.6180339887499)));
		i=Quaternion(0,~rot2.[i2],0,0);
	j=Quaternion(0,0,~rot3.[i2],0);
	k=Quaternion(0,0,0,~rot4.[i2]);
	q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
	i2=i2+1;
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(0.0001);
	};

~posb3 = 100.collect{
		angle3=((360-(360/1.6180339887499)));
		i=Quaternion(0,~rot2.[i3],0,0);
	j=Quaternion(0,0,~rot3.[i3],0);
	k=Quaternion(0,0,0,~rot4.[i3]);
	q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
	i3=i3+1;
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(0.0001);
	};

~posb4 = 100.collect{
		angle4=((360-(360/1.6180339887499)));
		i=Quaternion(0,~rot2.[i4],0,0);
	j=Quaternion(0,0,~rot3.[i4],0);
	k=Quaternion(0,0,0,~rot4.[i4]);
	q4=(cos(angle4.degrad/2)+(sin(angle4.degrad/2)*(i+j+k)));
	i4=i4+1;
	v4=q4*v4*q4.conjugate;
	ph4=(v4.d*m).round(0.0001);

	};

);
(
var  angle1=0,angle2=0,angle3=0,angle4=0,q1,q2,q3,q4,v1,v2,v3,v4,ph1,ph2,ph3,ph4,r,m=1;
var i = Quaternion(0, 0, 0, 0),j = Quaternion(0, 0, 0, 0),k = Quaternion(0, 0, 0, 1),n1,n2,n3,n4;
var i1=0,i2=0,i3=0,i4=0;

r=[3,2,0].normalizeSum;

v1=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);

~axis5=100.collect{[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;};

	~posc1 = 100.collect{
		angle1=((360-(360/1.6180339887499)));
		i=Quaternion(0,~rot2.[i1],0,0);
	j=Quaternion(0,0,~rot3.[i1],0);
	k=Quaternion(0,0,0,~rot4.[i1]);
	q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));
	i1=i1+1;
	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(0.0001);
	};
~posc2 = 100.collect{
		angle2=((360-(360/1.6180339887499)));
		i=Quaternion(0,~rot2.[i2],0,0);
	j=Quaternion(0,0,~rot3.[i2],0);
	k=Quaternion(0,0,0,~rot4.[i2]);
	q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
	i2=i2+1;
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(0.0001);
	};

~posc3 = 100.collect{
		angle3=((360-(360/1.6180339887499)));
		i=Quaternion(0,~rot2.[i3],0,0);
	j=Quaternion(0,0,~rot3.[i3],0);
	k=Quaternion(0,0,0,~rot4.[i3]);
	q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
	i3=i3+1;
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(0.0001);
	};

~posc4 = 100.collect{
		angle4=((360-(360/1.6180339887499)));
		i=Quaternion(0,~rot2.[i4],0,0);
	j=Quaternion(0,0,~rot3.[i4],0);
	k=Quaternion(0,0,0,~rot4.[i4]);
	q4=(cos(angle4.degrad/2)+(sin(angle4.degrad/2)*(i+j+k)));
	i4=i4+1;
	v4=q4*v4*q4.conjugate;
	ph4=(v4.d*m).round(0.0001);

	};

);
(
var  angle1=0,angle2=0,angle3=0,angle4=0,q1,q2,q3,q4,v1,v2,v3,v4,ph1,ph2,ph3,ph4,r,m=1;
var i = Quaternion(0, 0, 0, 0),j = Quaternion(0, 0, 0, 0),k = Quaternion(0, 0, 0, 1),n1,n2,n3,n4;
var i1=0,i2=0,i3=0,i4=0;

r=[4,3,0].normalizeSum;

v1=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);

~axis6=100.collect{[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;};

	~posd1 = 100.collect{
		angle1=((360-(360/1.6180339887499)));
		i=Quaternion(0,~rot2.[i1],0,0);
	j=Quaternion(0,0,~rot3.[i1],0);
	k=Quaternion(0,0,0,~rot4.[i1]);
	q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));
	i1=i1+1;
	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(0.0001);
	};
~posd2 = 100.collect{
		angle2=((360-(360/1.6180339887499)));
		i=Quaternion(0,~rot2.[i2],0,0);
	j=Quaternion(0,0,~rot3.[i2],0);
	k=Quaternion(0,0,0,~rot4.[i2]);
	q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
	i2=i2+1;
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(0.0001);
	};

~posd3 = 100.collect{
		angle3=((360-(360/1.6180339887499)));
		i=Quaternion(0,~rot2.[i3],0,0);
	j=Quaternion(0,0,~rot3.[i3],0);
	k=Quaternion(0,0,0,~rot4.[i3]);
	q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
	i3=i3+1;
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(0.0001);
	};

~posd4 = 100.collect{
		angle4=((360-(360/1.6180339887499)));
		i=Quaternion(0,~rot2.[i4],0,0);
	j=Quaternion(0,0,~rot3.[i4],0);
	k=Quaternion(0,0,0,~rot4.[i4]);
	q4=(cos(angle4.degrad/2)+(sin(angle4.degrad/2)*(i+j+k)));
	i4=i4+1;
	v4=q4*v4*q4.conjugate;
	ph4=(v4.d*m).round(0.0001);

	};

);
(
var  angle1=0,angle2=0,angle3=0,angle4=0,q1,q2,q3,q4,v1,v2,v3,v4,ph1,ph2,ph3,ph4,r,m=2;
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt, 0),k = Quaternion(0, 0, 0, (1/3).sqrt);
var i1=0,i2=0,i3=0,i4=0;

r=[3,2,1].normalizeSum;

v1=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);

~axis1=100.collect{[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;};

	~phase1 = 100.collect{
		angle1=((360-(360/1.6180339887499)));
	i=Quaternion(0,~rot2.[i1],0,0);
	j=Quaternion(0,0,~rot3.[i1],0);
	k=Quaternion(0,0,0,~rot4.[i1]);
	q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));
	i1=i1+1;
	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(1/16);
	};

~phase2 = 100.collect{
		angle2=((360-(360/1.6180339887499)));
	i=Quaternion(0,~rot2.[i2],0,0);
	j=Quaternion(0,0,~rot3.[i2],0);
	k=Quaternion(0,0,0,~rot4.[i2]);
	q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
	i2=i2+1;
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(1/16);
	};

~phase3 = 100.collect{
		angle3=((360-(360/1.6180339887499)));
	i=Quaternion(0,~rot2.[i3],0,0);
	j=Quaternion(0,0,~rot3.[i3],0);
	k=Quaternion(0,0,0,~rot4.[i3]);
	q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
	i3=i3+1;
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(1/16);

	};

~phase4 = 100.collect{
		angle4=((360-(360/1.6180339887499)));
	i=Quaternion(0,~rot2.[i4],0,0);
	j=Quaternion(0,0,~rot3.[i4],0);
	k=Quaternion(0,0,0,~rot4.[i4]);
	q4=(cos(angle4.degrad/2)+(sin(angle4.degrad/2)*(i+j+k)));
	i4=i4+1;
	v4=q4*v4*q4.conjugate;
	ph4=(v4.d*m).round(1/16);
	};

);
(
var  angle1=0,angle2=0,angle3=0,angle4=0,q1,q2,q3,q4,v1,v2,v3,v4,ph1,ph2,ph3,ph4,r,m=12;
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt, 0),k = Quaternion(0, 0, 0, (1/3).sqrt),n1,n2,n3,n4;
var i1=0,i2=0,i3=0,i4=0;

r=[1,2,3].normalizeSum;

v1=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);

~axis2=100.collect{[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;};

	~n1 = 100.collect{
		angle1=((360-(360/1.6180339887499)));
	i=Quaternion(0,~pos2.[i1],0,0);
	j=Quaternion(0,0,~pos3.[i1],0);
	k=Quaternion(0,0,0,~pos4.[i1]);
	q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));
	i1=i1+1;
	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(1);
	};
~n2 = 100.collect{
		angle2=((360-(360/1.6180339887499)));
	i=Quaternion(0,~pos2.[i2],0,0);
	j=Quaternion(0,0,~pos3.[i2],0);
	k=Quaternion(0,0,0,~pos4.[i2]);
	q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
	i2=i2+1;
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(1);
	};

~n3 = 100.collect{
		angle3=((360-(360/1.6180339887499)));
	i=Quaternion(0,~pos2.[i3],0,0);
	j=Quaternion(0,0,~pos3.[i3],0);
	k=Quaternion(0,0,0,~pos4.[i3]);
	q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
	i3=i3+1;
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(1);
	};

~n4 = 100.collect{
		angle4=((360-(360/1.6180339887499)));
	i=Quaternion(0,~pos2.[i4],0,0);
	j=Quaternion(0,0,~pos3.[i4],0);
	k=Quaternion(0,0,0,~pos4.[i4]);
	q4=(cos(angle4.degrad/2)+(sin(angle4.degrad/2)*(i+j+k)));
	i4=i4+1;
	v4=q4*v4*q4.conjugate;
	ph4=(v4.d*m).round(1);

	};
);
)



(
~phase2=~phase2++~phase2.reverse;
~n2=~n2++~n2.reverse;
~phase3=~phase3++~phase3.reverse;
~n3=~n3++~n3.reverse;
~phase4=~phase4++~phase4.reverse;
~n4=~n4++~n4.reverse;
~posb2=~posb2++~posb2.reverse;
~posb3=~posb3++~posb3.reverse;
~posb4=~posb4++~posb4.reverse;
~rotb2=~rotb2++~rotb2.reverse;
~rotb3=~rotb3++~rotb3.reverse;
~rotb4=~rotb4++~rotb4.reverse;
~posc2=~posc2++~posc2.reverse;
~posc3=~posc3++~posc3.reverse;
~posc4=~posc4++~posc4.reverse;
~rotc2=~rotc2++~rotc2.reverse;
~rotc3=~rotc3++~rotc3.reverse;
~rotc4=~rotc4++~rotc4.reverse;
~posd2=~posd2++~posd2.reverse;
~posd3=~posd3++~posd3.reverse;
~posd4=~posd4++~posd4.reverse;
~rotd2=~rotd2++~rotd2.reverse;
~rotd3=~rotd3++~rotd3.reverse;
~rotd4=~rotd4++~rotd4.reverse;

~posb22=~posb2.reverse++~posb2;
~posb33=~posb3.reverse++~posb3;
~posb44=~posb4.reverse++~posb4;
~rotb22=~rotb2.reverse++~rotb2;
~rotb33=~rotb3.reverse++~rotb3;
~rotb44=~rotb4.reverse++~rotb4;
~posc22=~posc2.reverse++~posc2;
~posc33=~posc3.reverse++~posc3;
~posc44=~posc4.reverse++~posc4;
~rotc22=~rotc2.reverse++~rotc2;
~rotc33=~rotc3.reverse++~rotc3;
~rotc44=~rotc4.reverse++~rotc4;
~posd22=~posd2.reverse++~posd2;
~posd33=~posd3.reverse++~posd3;
~posd44=~posd4.reverse++~posd4;
~rotd22=~rotd2.reverse++~rotd2;
~rotd33=~rotd3.reverse++~rotd3;
~rotd44=~rotd4.reverse++~rotd4;
)

(
b=Pdef(\2, Pbind(\instrument, \o1,
	\dur,Pseq(~phase2.abs,1),
\n,PdegreeToKey(Pseq(~n2,inf),Scale.mixolydian),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\x,Pseq(~posb2,inf),
	\y,Pseq(~posb3,inf),
	\z,Pseq(~posb4,inf),
	\rx,Pseq(~rotb2,inf),
	\ry,Pseq(~rotb3,inf),
	\rz,Pseq(~rotb4,inf),
	\x1,Pseq(~posb22,inf),
	\y1,Pseq(~posb33,inf),
	\z1,Pseq(~posb44,inf),
	\rx1,Pseq(~rotb22,inf),
	\ry1,Pseq(~rotb33,inf),
	\rz1,Pseq(~rotb44,inf),
	\buffer1,Pseq([0,1,2,3],inf),
	\buffer2,Pseq([0,1,2,3],inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \o2,
	\dur,Pseq(~phase3.abs,1),
\n,PdegreeToKey(Pseq(~n3,inf),Scale.mixolydian),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\x,Pseq(~posc2,inf),
	\y,Pseq(~posc3,inf),
	\z,Pseq(~posc4,inf),
	\rx,Pseq(~rotc2,inf),
	\ry,Pseq(~rotc3,inf),
	\rz,Pseq(~rotc4,inf),
	\x1,Pseq(~posc22,inf),
	\y1,Pseq(~posc33,inf),
	\z1,Pseq(~posc44,inf),
	\rx1,Pseq(~rotc22,inf),
	\ry1,Pseq(~rotc33,inf),
	\rz1,Pseq(~rotc44,inf),
	\buffer1,Pseq([0,1,2,3],inf),
	\buffer2,Pseq([0,1,2,3],inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \o3,
	\dur,Pseq(~phase4.abs,1),
\n,PdegreeToKey(Pseq(~n4,inf),Scale.mixolydian),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\x,Pseq(~posd2,inf),
	\y,Pseq(~posd3,inf),
	\z,Pseq(~posd4,inf),
	\rx,Pseq(~rotd2,inf),
	\ry,Pseq(~rotd3,inf),
	\rz,Pseq(~rotd4,inf),
	\x1,Pseq(~posd22,inf),
	\y1,Pseq(~posd33,inf),
	\z1,Pseq(~posd44,inf),
	\rx1,Pseq(~rotd22,inf),
	\ry1,Pseq(~rotd33,inf),
	\rz1,Pseq(~rotd44,inf),
	\buffer1,Pseq([0,1,2,3],inf),
	\buffer2,Pseq([0,1,2,3],inf),
	\decay,Pbrown(2,8,1,inf);
));
)

(
b.play;
//s.record(numChannels:4)
//)
//(
c.play;
//s.record(numChannels:4)
//)
//(
d.play;
s.record(numChannels:4)
)

(
Tdef.new(\h,{loop({

	b.play;
c.play;
d.play;
	(1).wait;
		bb.play;
cc.play;
dd.play;


	}
)})
)


Tdef(\h).stop;
Tdef(\h).play;
Tdef(\h).clear;
