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
(
SynthDef.new(\ob, {
arg  n1=1, cutt=440,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1,ry=1,rz=1,dist=0.1;
	var q,q1,i,j,k,i1,j1,k1,va,vb,or=0,freq, env1,m=1,bank, pitch, fund, angle=0,r1,p;
	var osc1_x,cva,phx,ang=(360-(360/1.6180339887499));
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	r1=[rx,ry,rz];

	i = Quaternion(0, r1.[0], 0, 0);
	j = Quaternion(0, 0,r1.[1], 0);
	k = Quaternion(0, 0, 0, r1.[2]);


	p=[x,y,z];

	va=Quaternion(0,p.[0],p.[1],p.[2]);

	bank=16;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*12)*pitch;

	bank.do{
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);

	q=(cos(ang.degrad/2)+(sin(ang.degrad/2)*(i+j+k)));

	va=q*va*q.conjugate;

	cva=Cartesian(va.b,va.c,va.d);

    phx=exp(Complex(0,1)*(angle.degrad)).phase;

env1=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:dist);


osc1_x=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,phx,2pi)),~b.bufnum,cva.theta.raddeg,cva.phi.raddeg);

m=m+1;

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env1),cutt));

	//Out.ar(0,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));


	};
}).add;
);
(
SynthDef.new(\oc, {
arg  n1=1, cutt=440,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1,ry=1,rz=1,dist=0.1;
	var q,q1,i,j,k,i1,j1,k1,va,vb,or=0,freq, env1,m=1,bank, pitch, fund, angle=0,r1,p;
	var osc1_x,cva,phx,ang=(360-(360/1.6180339887499));
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!


	r1=[rx,ry,rz];

	i = Quaternion(0, r1.[0], 0, 0);
	j = Quaternion(0, 0,r1.[1], 0);
	k = Quaternion(0, 0, 0, r1.[2]);


	p=[x,y,z];

	va=Quaternion(0,p.[0],p.[1],p.[2]);

	bank=16;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*12)*pitch;

	bank.do{
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);

	q=(cos(ang.degrad/2)+(sin(ang.degrad/2)*(i+j+k)));

	va=q*va*q.conjugate;

	cva=Cartesian(va.b,va.c,va.d);

    phx=exp(Complex(0,1)*(angle.degrad)).phase;

env1=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:dist);


osc1_x=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,phx,2pi)),~b.bufnum,cva.theta.raddeg,cva.phi.raddeg);

m=m+1;

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env1),cutt));

	//Out.ar(0,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));


	};
}).add;
);
(
SynthDef.new(\od, {
arg  n1=1, cutt=440,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1,ry=1,rz=1,dist=0.1;
	var q,q1,i,j,k,i1,j1,k1,va,vb,or=0,freq, env1,m=1,bank, pitch, fund, angle=0,r1,p;
	var osc1_x,cva,phx,ang=(360-(360/1.6180339887499));
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!


	r1=[rx,ry,rz];

	i = Quaternion(0, r1.[0], 0, 0);
	j = Quaternion(0, 0,r1.[1], 0);
	k = Quaternion(0, 0, 0, r1.[2]);


	p=[x,y,z];

	va=Quaternion(0,p.[0],p.[1],p.[2]);

	bank=16;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*12)*pitch;

	bank.do{
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);

	q=(cos(ang.degrad/2)+(sin(ang.degrad/2)*(i+j+k)));

	va=q*va*q.conjugate;

	cva=Cartesian(va.b,va.c,va.d);

    phx=exp(Complex(0,1)*(angle.degrad)).phase;

env1=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:dist);


osc1_x=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,phx,2pi)),~b.bufnum,cva.theta.raddeg,cva.phi.raddeg);

m=m+1;

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env1),cutt));

	//Out.ar(0,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));


	};
}).add;
);
)


(
(
var  angle1=0,angle2=0,angle3=0,angle4=0,q1,q2,q3,q4,v1,v2,v3,v4,ph1,ph2,ph3,ph4,r,m=2;
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt, 0),k = Quaternion(0, 0, 0, (1/3).sqrt);
var i1=0,i2=0,i3=0,i4=0;

r=[1/2,2/3,3/4].normalizeSum;

v1=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);
v2=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);

~axis1=10000.collect{[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;};

	~phase1 = 10000.collect{
		angle1=((360-(360/1.6180339887499)));
		q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));
	i=Quaternion(0,~axis1.[i1].[0].sqrt,0,0);
	j=Quaternion(0,0,~axis1.[i1].[1].sqrt,0);
	k=Quaternion(0,0,0,~axis1.[i1].[2].sqrt);
	i1=i1+1;
	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(1/16);
	};

~phase2 = 10000.collect{
		angle2=((360-(360/1.6180339887499)));
		q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
	i=Quaternion(0,~axis1.[i2].[0].sqrt,0,0);
	j=Quaternion(0,0,~axis1.[i2].[1].sqrt,0);
	k=Quaternion(0,0,0,~axis1.[i2].[2].sqrt);
	i2=i2+1;
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(1/16);
	};

~phase3 = 10000.collect{
		angle3=((360-(360/1.6180339887499)));
		q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
	i=Quaternion(0,~axis1.[i3].[0].sqrt,0,0);
	j=Quaternion(0,0,~axis1.[i3].[1].sqrt,0);
	k=Quaternion(0,0,0,~axis1.[i3].[2].sqrt);
	i3=i3+1;
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(1/16);

	};

~phase4 = 10000.collect{
		angle4=((360-(360/1.6180339887499)));
		q4=(cos(angle4.degrad/2)+(sin(angle4.degrad/2)*(i+j+k)));
	i=Quaternion(0,~axis1.[i4].[0].sqrt,0,0);
	j=Quaternion(0,0,~axis1.[i4].[1].sqrt,0);
	k=Quaternion(0,0,0,~axis1.[i4].[2].sqrt);
	i4=i4+1;
	v4=q4*v4*q4.conjugate;
	ph4=(v4.d*m).round(1/16);
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

~axis2=10000.collect{[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;};

	~n1 = 10000.collect{
		angle1=((360-(360/1.6180339887499)));
		q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));
		i=Quaternion(0,~axis2.[i1].[0].sqrt,0,0);
	j=Quaternion(0,0,~axis2.[i1].[1].sqrt,0);
	k=Quaternion(0,0,0,~axis2.[i1].[2].sqrt);
	i1=i1+1;
	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(1);
	};
~n2 = 10000.collect{
		angle2=((360-(360/1.6180339887499)));
		q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
		i=Quaternion(0,~axis2.[i2].[0].sqrt,0,0);
	j=Quaternion(0,0,~axis2.[i2].[1].sqrt,0);
	k=Quaternion(0,0,0,~axis2.[i2].[2].sqrt);
	i2=i2+1;
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(1);
	};

~n3 = 10000.collect{
		angle3=((360-(360/1.6180339887499)));
		q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
		i=Quaternion(0,~axis2.[i3].[0].sqrt,0,0);
	j=Quaternion(0,0,~axis2.[i3].[1].sqrt,0);
	k=Quaternion(0,0,0,~axis2.[i3].[2].sqrt);
	i3=i3+1;
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(1);
	};

~n4 = 10000.collect{
		angle4=((360-(360/1.6180339887499)));
		q4=(cos(angle4.degrad/2)+(sin(angle4.degrad/2)*(i+j+k)));
		i=Quaternion(0,~axis2.[i4].[0].sqrt,0,0);
	j=Quaternion(0,0,~axis2.[i4].[1].sqrt,0);
	k=Quaternion(0,0,0,~axis2.[i4].[2].sqrt);
	i4=i4+1;
	v4=q4*v4*q4.conjugate;
	ph4=(v4.d*m).round(1);

	};
)

(
var  angle1=0,angle2=0,angle3=0,angle4=0,q1,q2,q3,q4,v1,v2,v3,v4,ph1,ph2,ph3,ph4,r,m=1;
var i = Quaternion(0, 1, 0, 0),j = Quaternion(0, 0, 0, 0),k = Quaternion(0, 0, 0, 0),n1,n2,n3,n4;
var i1=0,i2=0,i3=0,i4=0;

r=[0,0,1].normalizeSum;

v1=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);

~axis7=10000.collect{[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;};

	~rotb1 = 10000.collect{
		angle1=((360-(360/1.6180339887499)));
			i=Quaternion(0,~axis7.[i1].[0].sqrt,0,0);
		j=Quaternion(0,0,~axis7.[i1].[1].sqrt,0);
		k=Quaternion(0,0,0,~axis7.[i1].[2].sqrt);
	q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));
	i1=i1+1;
	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(0.0001);
	};
~rotb2 = 10000.collect{
		angle2=((360-(360/1.6180339887499)));
			i=Quaternion(0,~axis7.[i2].[0].sqrt,0,0);
		j=Quaternion(0,0,~axis7.[i2].[1].sqrt,0);
		k=Quaternion(0,0,0,~axis7.[i2].[2].sqrt);
	q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
	i2=i2+1;
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(0.0001);
	};

~rotb3 = 10000.collect{
		angle3=((360-(360/1.6180339887499)));
			i=Quaternion(0,~axis7.[i3].[0].sqrt,0,0);
		j=Quaternion(0,0,~axis7.[i3].[1].sqrt,0);
		k=Quaternion(0,0,0,~axis7.[i3].[2].sqrt);
	q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
	i3=i3+1;
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(0.0001);
	};

~rotb4 = 10000.collect{
		angle4=((360-(360/1.6180339887499)));
			i=Quaternion(0,~axis7.[i4].[0].sqrt,0,0);
		j=Quaternion(0,0,~axis7.[i4].[1].sqrt,0);
		k=Quaternion(0,0,0,~axis7.[i4].[2].sqrt);
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

~axis8=10000.collect{[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;};

	~rotc1 = 10000.collect{
		angle1=((360-(360/1.6180339887499)));
			i=Quaternion(0,~axis8.[i1].[0].sqrt,0,0);
		j=Quaternion(0,0,~axis8.[i1].[1].sqrt,0);
		k=Quaternion(0,0,0,~axis8.[i1].[2].sqrt);
	q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));
	i1=i1+1;
	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(0.0001);
	};
~rotc2 = 10000.collect{
		angle2=((360-(360/1.6180339887499)));
			i=Quaternion(0,~axis8.[i2].[0].sqrt,0,0);
	j=Quaternion(0,0,~axis8.[i2].[1].sqrt,0);
		k=Quaternion(0,0,0,~axis8.[i2].[2].sqrt);
	q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
	i2=i2+1;
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(0.0001);
	};

~rotc3 = 10000.collect{
		angle3=((360-(360/1.6180339887499)));
			i=Quaternion(0,~axis8.[i3].[0].sqrt,0,0);
	j=Quaternion(0,0,~axis8.[i3].[1].sqrt,0);
		k=Quaternion(0,0,0,~axis8.[i3].[2].sqrt);
	q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
	i3=i3+1;
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(0.0001);
	};

~rotc4 = 10000.collect{
		angle4=((360-(360/1.6180339887499)));
			i=Quaternion(0,~axis8.[i4].[0].sqrt,0,0);
		j=Quaternion(0,0,~axis8.[i4].[1].sqrt,0);
		k=Quaternion(0,0,0,~axis8.[i4].[2].sqrt);
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

~axis9=10000.collect{[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;};

	~rotd1 = 10000.collect{
		angle1=((360-(360/1.6180339887499)));
		i=Quaternion(0,~axis9.[i1].[0].sqrt,0,0);
		j=Quaternion(0,0,~axis9.[i1].[1].sqrt,0);
		k=Quaternion(0,0,0,~axis9.[i1].[2].sqrt);
	q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));
	i1=i1+1;
	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(0.0001);
	};
~rotd2 = 10000.collect{
		angle2=((360-(360/1.6180339887499)));
		i=Quaternion(0,~axis9.[i2].[0].sqrt,0,0);
		j=Quaternion(0,0,~axis9.[i2].[1].sqrt,0);
	k=Quaternion(0,0,0,~axis9.[i2].[2].sqrt);
	q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
	i2=i2+1;
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(0.0001);
	};

~rotd3 = 10000.collect{
		angle3=((360-(360/1.6180339887499)));
		i=Quaternion(0,~axis9.[i3].[0].sqrt,0,0);
		j=Quaternion(0,0,~axis9.[i3].[1].sqrt,0);
		k=Quaternion(0,0,0,~axis9.[i3].[2].sqrt);

	q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
	i3=i3+1;
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(0.0001);
	};

~rotd4 = 10000.collect{
		angle4=((360-(360/1.6180339887499)));
		i=Quaternion(0,~axis9.[i4].[0].sqrt,0,0);
	j=Quaternion(0,0,~axis9.[i4].[1].sqrt,0);
	k=Quaternion(0,0,0,~axis9.[i4].[2].sqrt);
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

r=[1,0,0].normalizeSum;

v1=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);

~axis4=10000.collect{[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;};

	~posb1 = 10000.collect{
		angle1=((360-(360/1.6180339887499)));
			i=Quaternion(0,~axis4.[i1].[0].sqrt,0,0);
		j=Quaternion(0,0,~axis4.[i1].[1].sqrt,0);
		k=Quaternion(0,0,0,~axis4.[i1].[2].sqrt);
	q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));
	i1=i1+1;
	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(0.0001);
	};
~posb2 = 10000.collect{
		angle2=((360-(360/1.6180339887499)));
			i=Quaternion(0,~axis4.[i2].[0].sqrt,0,0);
		j=Quaternion(0,0,~axis4.[i2].[1].sqrt,0);
		k=Quaternion(0,0,0,~axis4.[i2].[2].sqrt);
	q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
	i2=i2+1;
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(0.0001);
	};

~posb3 = 10000.collect{
		angle3=((360-(360/1.6180339887499)));
			i=Quaternion(0,~axis4.[i3].[0].sqrt,0,0);
		j=Quaternion(0,0,~axis4.[i3].[1].sqrt,0);
		k=Quaternion(0,0,0,~axis4.[i3].[2].sqrt);
	q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
	i3=i3+1;
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(0.0001);
	};

~posb4 = 10000.collect{
		angle4=((360-(360/1.6180339887499)));
			i=Quaternion(0,~axis4.[i4].[0].sqrt,0,0);
	j=Quaternion(0,0,~axis4.[i4].[1].sqrt,0);
		k=Quaternion(0,0,0,~axis4.[i4].[2].sqrt);
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

r=[1,0,0].normalizeSum;

v1=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);

~axis5=10000.collect{[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;};

	~posc1 = 10000.collect{
		angle1=((360-(360/1.6180339887499)));
			i=Quaternion(0,~axis5.[i1].[0].sqrt,0,0);
		j=Quaternion(0,0,~axis5.[i1].[1].sqrt,0);
		k=Quaternion(0,0,0,~axis5.[i1].[2].sqrt);
	q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));
	i1=i1+1;
	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(0.0001);
	};
~posc2 = 10000.collect{
		angle2=((360-(360/1.6180339887499)));
			i=Quaternion(0,~axis5.[i2].[0].sqrt,0,0);
		j=Quaternion(0,0,~axis5.[i2].[1].sqrt,0);
		k=Quaternion(0,0,0,~axis5.[i2].[2].sqrt);
	q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
	i2=i2+1;
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(0.0001);
	};

~posc3 = 10000.collect{
		angle3=((360-(360/1.6180339887499)));
			i=Quaternion(0,~axis5.[i3].[0].sqrt,0,0);
		j=Quaternion(0,0,~axis5.[i3].[1].sqrt,0);
		k=Quaternion(0,0,0,~axis5.[i3].[2].sqrt);

	q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
	i3=i3+1;
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(0.0001);
	};

~posc4 = 10000.collect{
		angle4=((360-(360/1.6180339887499)));
	i=Quaternion(0,~axis5.[i4].[0].sqrt,0,0);
	j=Quaternion(0,0,~axis5.[i4].[1].sqrt,0);
		k=Quaternion(0,0,0,~axis5.[i4].[2].sqrt);

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

r=[1,0,0].normalizeSum;

v1=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);

~axis6=10000.collect{[0.999999.rand,0.999999.rand,0.999999.rand].normalizeSum;};

	~posd1 = 10000.collect{
		angle1=((360-(360/1.6180339887499)));
			i=Quaternion(0,~axis6.[i1].[0].sqrt,0,0);
		j=Quaternion(0,0,~axis6.[i1].[1].sqrt,0);
		k=Quaternion(0,0,0,~axis6.[i1].[2].sqrt);

	q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));
	i1=i1+1;
	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(0.0001);
	};
~posd2 = 10000.collect{
		angle2=((360-(360/1.6180339887499)));
			i=Quaternion(0,~axis6.[i2].[0].sqrt,0,0);
		j=Quaternion(0,0,~axis6.[i2].[1].sqrt,0);
		k=Quaternion(0,0,0,~axis6.[i2].[2].sqrt);

	q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
	i2=i2+1;
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(0.0001);
	};

~posd3 = 10000.collect{
		angle3=((360-(360/1.6180339887499)));
/		i=Quaternion(0,~axis6.[i3].[0].sqrt,0,0);
		j=Quaternion(0,0,~axis6.[i3].[1].sqrt,0);
		k=Quaternion(0,0,0,~axis6.[i3].[2].sqrt);

	q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
	i3=i3+1;
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(0.0001);
	};

~posd4 = 10000.collect{
		angle4=((360-(360/1.6180339887499)));
			i=Quaternion(0,~axis6.[i4].[0].sqrt,0,0);
		j=Quaternion(0,0,~axis6.[i4].[1].sqrt,0);
		k=Quaternion(0,0,0,~axis6.[i4].[2].sqrt);
	q4=(cos(angle4.degrad/2)+(sin(angle4.degrad/2)*(i+j+k)));
	i4=i4+1;
	v4=q4*v4*q4.conjugate;
	ph4=(v4.d*m).round(0.0001);

	};

);
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
\n1,PdegreeToKey(Pseq(~n2,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\x,Pseq(~posb2,inf),
	\y,Pseq(~posb3,inf),
	\z,Pseq(~posb4,inf),
	\rx,Pseq(~rotb2,inf),
	\ry,Pseq(~rotb3,inf),
	\rz,Pseq(~rotb4,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	//\dur,1/2,
	\dur,Pseq(~phase3.abs,inf),
\n1,PdegreeToKey(Pseq(~n3,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\x,Pseq(~posc2,inf),
	\y,Pseq(~posc3,inf),
	\z,Pseq(~posc4,inf),
	\rx,Pseq(~rotc2,inf),
	\ry,Pseq(~rotc3,inf),
	\rz,Pseq(~rotc4,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	//\dur,1/2,
	\dur,Pseq(~phase4.abs,inf),
\n1,PdegreeToKey(Pseq(~n4,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\x,Pseq(~posd2,inf),
	\y,Pseq(~posd3,inf),
	\z,Pseq(~posd4,inf),
	\rx,Pseq(~rotd2,inf),
	\ry,Pseq(~rotd3,inf),
	\rz,Pseq(~rotd4,inf),
	\dist,Pgauss(0.2,0.1,inf),
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

