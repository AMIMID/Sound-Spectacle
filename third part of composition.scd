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
~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/SC_240623_154124.wav",channels:0 );
~c2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/SC_240623_154124.wav",channels:1 );
);

(
SynthDef.new(\o1, {
	arg n,decay,ng1=1,ng2=1,ng3=1,ng4=1,ng5=1,ng6=1,x=1,y=1,z=1;
    var in1,in2, chainx,chainy,b=0,angle,r1,r2,i,j,k,i1,j1,k1;
	var v,q,q1,v1,vp,chainxx,chainyy,cva,cvb,pitch,env;

	pitch=2.pow(n/12);

	env=EnvGen.ar(Env.perc(0.01,decay,pitch.reciprocal),doneAction:2);

	in1 = PitchShift.ar(PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0, doneAction:2),pitchRatio:pitch,mul:env);
	in2 = PitchShift.ar(PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2), loop: 0, doneAction:2),pitchRatio:pitch,mul:env);

	vp=[x,y,z].normalizeSum;
	v=Quaternion(0,vp.[0].sqrt*ng1,vp.[1].sqrt*ng2,vp.[2].sqrt*ng3);
	v1=Quaternion(0,vp.[0].sqrt*ng4,vp.[1].sqrt*ng5,vp.[2].sqrt*ng6);

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
	Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,cva.theta.degrad,cva.phi.degrad)*env);
Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,cvb.theta.degrad,cvb.phi.degrad)*env);


	}

}).add;
);

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
);

(
b=Pdef(\2, Pbind(\instrument, \o1,
	\dur,Pseq(~phase2.abs,inf),
\n,PdegreeToKey(Pseq(~n2,1),Scale.phrygian),
	\x,Pbrown(0,1,0.1,inf),
	\y,Pbrown(0,1,0.1,inf),
	\z,Pbrown(0,1,0.1,inf),
		\ng1,Prand([1.neg,1,1.neg,1],inf),
	\ng2,Prand([1.neg,1,1.neg,1],inf),
	\ng3,Prand([1.neg,1,1.neg,1],inf),
			\ng4,Prand([1.neg,1,1.neg,1],inf),
	\ng5,Prand([1.neg,1,1.neg,1],inf),
	\ng6,Prand([1.neg,1,1.neg,1],inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \o2,
	\dur,Pseq(~phase2.abs,inf),
\n,PdegreeToKey(Pseq(~n2,1),Scale.phrygian),
	\x,Pbrown(0,1,0.1,inf),
	\y,Pbrown(0,1,0.1,inf),
	\z,Pbrown(0,1,0.1,inf),
		\ng1,Prand([1.neg,1,1.neg,1],inf),
	\ng2,Prand([1.neg,1,1.neg,1],inf),
	\ng3,Prand([1.neg,1,1.neg,1],inf),
			\ng4,Prand([1.neg,1,1.neg,1],inf),

	\ng5,Prand([1.neg,1,1.neg,1],inf),

\ng6,Prand([1.neg,1,1.neg,1],inf),
	\decay,Pbrown(2,8,1,inf);
));

d=Pdef(\4, Pbind(\instrument, \o3,

	\dur,Pseq(~phase2.abs,inf),
\n,PdegreeToKey(Pseq(~n2,1),Scale.phrygian),
	\x,Pbrown(0,1,0.1,inf),
	\y,Pbrown(0,1,0.1,inf),
	\z,Pbrown(0,1,0.1,inf),
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