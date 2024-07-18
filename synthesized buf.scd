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
var  angle1=0,angle2=0,angle3=0,angle4=0,q1,q2,q3,q4,v1,v2,v3,v4,ph1,ph2,ph3,ph4,r,m=1;
var i = Quaternion(0, 0, 0, 0),j = Quaternion(0, 0, 0, 0),k = Quaternion(0, 0, 0, 1),n1,n2,n3,n4;
var i1=0,i2=0,i3=0,i4=0;

r=[1,0,0].normalizeSum;

v1=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);


	~pos1 = 10000.collect{
		angle1=((360-(360/1.6180339887499)));
	q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));
	i1=i1+1;
	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(0.0001);
	};
~pos2 = 10000.collect{
		angle2=((360-(360/1.6180339887499)));
	q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
	i2=i2+1;
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(0.0001);
	};

~pos3 = 10000.collect{
		angle3=((360-(360/1.6180339887499)));
	q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
	i3=i3+1;
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(0.0001);
	};

~pos4 = 10000.collect{
		angle4=((360-(360/1.6180339887499)));
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

r=[0,1,0].normalizeSum;

v1=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);


	~pos5 = 10000.collect{
		angle1=((360-(360/1.6180339887499)));
	q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));
	i1=i1+1;
	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(0.0001);
	};
~pos6 = 10000.collect{
		angle2=((360-(360/1.6180339887499)));
	q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
	i2=i2+1;
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(0.0001);
	};

~pos7 = 10000.collect{
		angle3=((360-(360/1.6180339887499)));
	q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
	i3=i3+1;
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(0.0001);
	};

~pos8 = 10000.collect{
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


	~rot1 = 10000.collect{
	q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));
	i1=i1+1;
	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(0.0001);
	};
~rot2 = 10000.collect{
		angle2=((360-(360/1.6180339887499)));
	q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
	i2=i2+1;
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(0.0001);
	};

~rot3 = 10000.collect{
		angle3=((360-(360/1.6180339887499)));
	q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
	i3=i3+1;
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(0.0001);
	};

~rot4 = 10000.collect{
		angle4=((360-(360/1.6180339887499)));
	q4=(cos(angle4.degrad/2)+(sin(angle4.degrad/2)*(i+j+k)));
	i4=i4+1;
	v4=q4*v4*q4.conjugate;
	ph4=(v4.d*m).round(0.0001);

	};

);
(
var  angle1=0,angle2=0,angle3=0,angle4=0,q1,q2,q3,q4,v1,v2,v3,v4,ph1,ph2,ph3,ph4,r,m=1;
var i = Quaternion(0, 0, 0, 0),j = Quaternion(0, 0, 1, 0),k = Quaternion(0, 0, 0, 0),n1,n2,n3,n4;
var i1=0,i2=0,i3=0,i4=0;

r=[0,0,1].normalizeSum;

v1=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);


	~rot5 = 10000.collect{
	q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));
	i1=i1+1;
	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(0.0001);
	};
~rot6= 10000.collect{
		angle2=((360-(360/1.6180339887499)));
	q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
	i2=i2+1;
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(0.0001);
	};

~rot7 = 10000.collect{
		angle3=((360-(360/1.6180339887499)));
	q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
	i3=i3+1;
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(0.0001);
	};

~rot8 = 10000.collect{
		angle4=((360-(360/1.6180339887499)));
	q4=(cos(angle4.degrad/2)+(sin(angle4.degrad/2)*(i+j+k)));
	i4=i4+1;
	v4=q4*v4*q4.conjugate;
	ph4=(v4.d*m).round(0.0001);

	};

)


(
(
SynthDef.new(\o1, {
    var in1,in2, chainx,chainy,b=0,angle,r1,r2,i,j,k,i1,j1,k1;
	var v,q,q1,v1,vp,chainxx,chainyy,cva,cvb,pl=0;

    in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2), loop: 0, doneAction:2);

	v=Quaternion(0,~pos2.[0],~pos3.[0],~pos4.[0]);
	v1=Quaternion(0,~pos6.[0],~pos7.[0],~pos8.[0]);

	angle=((360-(360/1.6180339887499)));

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{

		r1=[~rot2.[pl],~rot3.[pl],~rot4.[pl]];
	r2=[~rot6.[pl],~rot7.[pl],~rot8.[pl]];

	i = Quaternion(0, r1.[0], 0, 0);
	j = Quaternion(0, 0,r1.[1], 0);
	k = Quaternion(0, 0, 0, r1.[2]);
	i1 = Quaternion(0, r2.[0], 0, 0);
	j1 = Quaternion(0, 0,r2.[1], 0);
	k1 = Quaternion(0, 0, 0, r2.[2]);

	q=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i+j+k)));
	q1=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i1+j1+k1)));
	v=q*v*q.conjugate;
	v1=q1*v1*q1.conjugate;

	cva=Cartesian(v.b,v.c,v.d);
	cvb=Cartesian(v1.b,v1.c,v1.d);

		pl=pl+1;

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,cva.theta.raddeg,cva.phi.raddeg));
		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,cvb.theta.raddeg,cvb.phi.raddeg));


	}
}).add;
);
(
SynthDef.new(\o2, {
    var in1,in2, chainx,chainy,b=0,angle,r1,r2,i,j,k,i1,j1,k1;
	var v,q,q1,v1,vp,chainxx,chainyy,cva,cvb,pl=0;

    in1 = PlayBuf.ar(1, ~c3.bufnum, BufRateScale.kr(~c3), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c4.bufnum, BufRateScale.kr(~c4), loop: 0, doneAction:2);

	v=Quaternion(0,~pos2.[1],~pos3.[1],~pos4.[1]);
	v1=Quaternion(0,~pos6.[1],~pos7.[1],~pos8.[1]);

	angle=((360-(360/1.6180339887499)));

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{

		r1=[~rot2.[pl],~rot3.[pl],~rot4.[pl]];
	r2=[~rot6.[pl],~rot7.[pl],~rot8.[pl]];

	i = Quaternion(0, r1.[0], 0, 0);
	j = Quaternion(0, 0,r1.[1], 0);
	k = Quaternion(0, 0, 0, r1.[2]);
	i1 = Quaternion(0, r2.[0], 0, 0);
	j1 = Quaternion(0, 0,r2.[1], 0);
	k1 = Quaternion(0, 0, 0, r2.[2]);

	q=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i+j+k)));
	q1=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i1+j1+k1)));
	v=q*v*q.conjugate;
	v1=q1*v1*q1.conjugate;

	cva=Cartesian(v.b,v.c,v.d);
	cvb=Cartesian(v1.b,v1.c,v1.d);

		pl=pl+1;

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,cva.theta.raddeg,cva.phi.raddeg));
		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,cvb.theta.raddeg,cvb.phi.raddeg));


	}
}).add;
);
(
SynthDef.new(\o3, {
    var in1,in2, chainx,chainy,b=0,angle,r1,r2,i,j,k,i1,j1,k1;
	var v,q,q1,v1,vp,chainxx,chainyy,cva,cvb,pl=0;

    in1 = PlayBuf.ar(1, ~c5.bufnum, BufRateScale.kr(~c5), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c6.bufnum, BufRateScale.kr(~c6), loop: 0, doneAction:2);

	v=Quaternion(0,~pos2.[2],~pos3.[2],~pos4.[2]);
	v1=Quaternion(0,~pos6.[2],~pos7.[2],~pos8.[2]);

	angle=((360-(360/1.6180339887499)));

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{

		r1=[~rot2.[pl],~rot3.[pl],~rot4.[pl]];
	r2=[~rot6.[pl],~rot7.[pl],~rot8.[pl]];

	i = Quaternion(0, r1.[0], 0, 0);
	j = Quaternion(0, 0,r1.[1], 0);
	k = Quaternion(0, 0, 0, r1.[2]);
	i1 = Quaternion(0, r2.[0], 0, 0);
	j1 = Quaternion(0, 0,r2.[1], 0);
	k1 = Quaternion(0, 0, 0, r2.[2]);

	q=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i+j+k)));
	q1=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i1+j1+k1)));
	v=q*v*q.conjugate;
	v1=q1*v1*q1.conjugate;

	cva=Cartesian(v.b,v.c,v.d);
	cvb=Cartesian(v1.b,v1.c,v1.d);

		pl=pl+1;

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,cva.theta.raddeg,cva.phi.raddeg));
		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,cvb.theta.raddeg,cvb.phi.raddeg));


	}
}).add;
);
(
SynthDef.new(\o4, {
    var in1,in2, chainx,chainy,b=0,angle,r1,r2,i,j,k,i1,j1,k1;
	var v,q,q1,v1,vp,chainxx,chainyy,cva,cvb,pl=0;

    in1 = PlayBuf.ar(1, ~c7.bufnum, BufRateScale.kr(~c7), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c8.bufnum, BufRateScale.kr(~c8), loop: 0, doneAction:2);

	v=Quaternion(0,~pos2.[3],~pos3.[3],~pos4.[3]);
	v1=Quaternion(0,~pos6.[3],~pos7.[3],~pos8.[3]);

	angle=((360-(360/1.6180339887499)));

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{

		r1=[~rot2.[pl],~rot3.[pl],~rot4.[pl]];
	r2=[~rot6.[pl],~rot7.[pl],~rot8.[pl]];

	i = Quaternion(0, r1.[0], 0, 0);
	j = Quaternion(0, 0,r1.[1], 0);
	k = Quaternion(0, 0, 0, r1.[2]);
	i1 = Quaternion(0, r2.[0], 0, 0);
	j1 = Quaternion(0, 0,r2.[1], 0);
	k1 = Quaternion(0, 0, 0, r2.[2]);

	q=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i+j+k)));
	q1=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i1+j1+k1)));
	v=q*v*q.conjugate;
	v1=q1*v1*q1.conjugate;

	cva=Cartesian(v.b,v.c,v.d);
	cvb=Cartesian(v1.b,v1.c,v1.d);

		pl=pl+1;

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,cva.theta.raddeg,cva.phi.raddeg));
		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,cvb.theta.raddeg,cvb.phi.raddeg));


	}
}).add;
);
(
SynthDef.new(\o5, {
    var in1,in2, chainx,chainy,b=0,angle,r1,r2,i,j,k,i1,j1,k1;
	var v,q,q1,v1,vp,chainxx,chainyy,cva,cvb,pl=0;

    in1 = PlayBuf.ar(1, ~c9.bufnum, BufRateScale.kr(~c9), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c10.bufnum, BufRateScale.kr(~c10), loop: 0, doneAction:2);

	v=Quaternion(0,~pos2.[4],~pos3.[4],~pos4.[4]);
	v1=Quaternion(0,~pos6.[4],~pos7.[4],~pos8.[4]);

	angle=((360-(360/1.6180339887499)));

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{

		r1=[~rot2.[pl],~rot3.[pl],~rot4.[pl]];
	r2=[~rot6.[pl],~rot7.[pl],~rot8.[pl]];

	i = Quaternion(0, r1.[0], 0, 0);
	j = Quaternion(0, 0,r1.[1], 0);
	k = Quaternion(0, 0, 0, r1.[2]);
	i1 = Quaternion(0, r2.[0], 0, 0);
	j1 = Quaternion(0, 0,r2.[1], 0);
	k1 = Quaternion(0, 0, 0, r2.[2]);

	q=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i+j+k)));
	q1=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i1+j1+k1)));
	v=q*v*q.conjugate;
	v1=q1*v1*q1.conjugate;

	cva=Cartesian(v.b,v.c,v.d);
	cvb=Cartesian(v1.b,v1.c,v1.d);

		pl=pl+1;

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,cva.theta.raddeg,cva.phi.raddeg));
		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,cvb.theta.raddeg,cvb.phi.raddeg));


	}
}).add;
);
(
SynthDef.new(\o6, {
    var in1,in2, chainx,chainy,b=0,angle,r1,r2,i,j,k,i1,j1,k1;
	var v,q,q1,v1,vp,chainxx,chainyy,cva,cvb,pl=0;

    in1 = PlayBuf.ar(1, ~c11.bufnum, BufRateScale.kr(~c11), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c12.bufnum, BufRateScale.kr(~c12), loop: 0, doneAction:2);

	v=Quaternion(0,~pos2.[5],~pos3.[5],~pos4.[5]);
	v1=Quaternion(0,~pos6.[5],~pos7.[5],~pos8.[5]);

	angle=((360-(360/1.6180339887499)));

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{

		r1=[~rot2.[pl],~rot3.[pl],~rot4.[pl]];
	r2=[~rot6.[pl],~rot7.[pl],~rot8.[pl]];

	i = Quaternion(0, r1.[0], 0, 0);
	j = Quaternion(0, 0,r1.[1], 0);
	k = Quaternion(0, 0, 0, r1.[2]);
	i1 = Quaternion(0, r2.[0], 0, 0);
	j1 = Quaternion(0, 0,r2.[1], 0);
	k1 = Quaternion(0, 0, 0, r2.[2]);

	q=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i+j+k)));
	q1=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i1+j1+k1)));
	v=q*v*q.conjugate;
	v1=q1*v1*q1.conjugate;

	cva=Cartesian(v.b,v.c,v.d);
	cvb=Cartesian(v1.b,v1.c,v1.d);

		pl=pl+1;

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,cva.theta.raddeg,cva.phi.raddeg));
		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,cvb.theta.raddeg,cvb.phi.raddeg));


	}
}).add;
);
(
SynthDef.new(\o7, {
    var in1,in2, chainx,chainy,b=0,angle,r1,r2,i,j,k,i1,j1,k1;
	var v,q,q1,v1,vp,chainxx,chainyy,cva,cvb,pl=0;

    in1 = PlayBuf.ar(1, ~c13.bufnum, BufRateScale.kr(~c13), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c14.bufnum, BufRateScale.kr(~c14), loop: 0, doneAction:2);

	v=Quaternion(0,~pos2.[6],~pos3.[6],~pos4.[6]);
	v1=Quaternion(0,~pos6.[6],~pos7.[6],~pos8.[6]);

	angle=((360-(360/1.6180339887499)));

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{

		r1=[~rot2.[pl],~rot3.[pl],~rot4.[pl]];
	r2=[~rot6.[pl],~rot7.[pl],~rot8.[pl]];

	i = Quaternion(0, r1.[0], 0, 0);
	j = Quaternion(0, 0,r1.[1], 0);
	k = Quaternion(0, 0, 0, r1.[2]);
	i1 = Quaternion(0, r2.[0], 0, 0);
	j1 = Quaternion(0, 0,r2.[1], 0);
	k1 = Quaternion(0, 0, 0, r2.[2]);

	q=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i+j+k)));
	q1=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i1+j1+k1)));
	v=q*v*q.conjugate;
	v1=q1*v1*q1.conjugate;

	cva=Cartesian(v.b,v.c,v.d);
	cvb=Cartesian(v1.b,v1.c,v1.d);

		pl=pl+1;

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,cva.theta.raddeg,cva.phi.raddeg));
		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,cvb.theta.raddeg,cvb.phi.raddeg));


	}
}).add;
);
(
SynthDef.new(\o8, {
    var in1,in2, chainx,chainy,b=0,angle,r1,r2,i,j,k,i1,j1,k1;
	var v,q,q1,v1,vp,chainxx,chainyy,cva,cvb,pl=0;

    in1 = PlayBuf.ar(1, ~c15.bufnum, BufRateScale.kr(~c15), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c16.bufnum, BufRateScale.kr(~c16), loop: 0, doneAction:2);

	v=Quaternion(0,~pos2.[7],~pos3.[7],~pos4.[7]);
	v1=Quaternion(0,~pos6.[7],~pos7.[7],~pos8.[7]);

	angle=((360-(360/1.6180339887499)));

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{

		r1=[~rot2.[pl],~rot3.[pl],~rot4.[pl]];
	r2=[~rot6.[pl],~rot7.[pl],~rot8.[pl]];

	i = Quaternion(0, r1.[0], 0, 0);
	j = Quaternion(0, 0,r1.[1], 0);
	k = Quaternion(0, 0, 0, r1.[2]);
	i1 = Quaternion(0, r2.[0], 0, 0);
	j1 = Quaternion(0, 0,r2.[1], 0);
	k1 = Quaternion(0, 0, 0, r2.[2]);

	q=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i+j+k)));
	q1=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i1+j1+k1)));
	v=q*v*q.conjugate;
	v1=q1*v1*q1.conjugate;

	cva=Cartesian(v.b,v.c,v.d);
	cvb=Cartesian(v1.b,v1.c,v1.d);

		pl=pl+1;

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,cva.theta.raddeg,cva.phi.raddeg));
		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,cvb.theta.raddeg,cvb.phi.raddeg));


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