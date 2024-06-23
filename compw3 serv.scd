(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=8;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/240);
s.options.memSize = 8192*64;
//s.options.blockSize = 64/4;
s.options.maxNodes = 1024 * 64;
s.waitForBoot
)
Server.freeAll
(
~s1=Server.new(\server1,NetAddr("localhost", 57101),Server.local.options);
~s2=Server.new(\server2,NetAddr("localhost", 57102),Server.local.options);
~s3=Server.new(\server3,NetAddr("localhost", 57103),Server.local.options);
)
(~s1.boot;~s2.boot;~s3.boot;)
(
~s1.makeGui(w);
~s2.makeGui(w);
~s3.makeGui(w);
)

Buffer.freeAll
(
// 3D
~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
//~b = Buffer.loadCollection(~s1, ~a.getSetsAndMatrices);
//~c = Buffer.loadCollection(~s2, ~a.getSetsAndMatrices);
//~d = Buffer.loadCollection(~s3, ~a.getSetsAndMatrices);
)
(
(
SynthDef.new(\ob, {
	arg  n1=1, cutt=440,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1,ng1=1,ng2=1,ng3=1;
	var q,q1,i,j,k,va,vb,v1,v2,v3,v4,v5,v6,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z,ph_va_x,ph_va_y,ph_va_z,ph_vb_x,ph_vb_y,ph_vb_z;
	var osc1,osc2,osc3,freq, env1,env2,m=1,bank, pitch, fund, angle=0,angle1=90,r,p;
	var osc1_x,osc1_y,osc1_z,osc2_x,osc2_y,osc2_z,cvax,cvay,cvaz,cvbx,cvby,cvbz,cva,cvb,phx,phy;
	var spacex,timex,spacey,timey,spacez,timez,ang=(360-(360/1.6180339887499));
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut3 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
		var wrappedOut4 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut5 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut6 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};


	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	r=[rx,ry,rz].normalizeSum;

	i = Quaternion(0, r.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r.[2].sqrt);

	p=[x,y,z].normalizeSum;


	v1=Quaternion(0,p.[0].sqrt*ng1,0,0);
	v2=Quaternion(0,0,p.[1].sqrt*ng2,0);
	v3=Quaternion(0,0,0,p.[2].sqrt*ng3);
	v4=Quaternion(0,p.[0].sqrt*ng1,0,0);
	v5=Quaternion(0,0,p.[1].sqrt*ng2,0);
	v6=Quaternion(0,0,0,p.[2].sqrt*ng3);
	va=Quaternion(0,p.[0].sqrt*ng1,p.[1].sqrt*ng2,p.[2].sqrt*ng3);
	vb=Quaternion(0,p.[0].sqrt*ng1,p.[1].sqrt*ng2,p.[2].sqrt*ng3);

	bank=32;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*6)*pitch;

	q1=(cos(90.degrad/2)+(sin(90.degrad/2)*(i+j+k)));
	vb=q1*vb*q1.conjugate;
	v4=q1*v4*q1.conjugate;
	v5=q1*v5*q1.conjugate;
	v6=q1*v6*q1.conjugate;

	bank.do{
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);

	q=(cos(ang.degrad/2)+(sin(ang.degrad/2)*(i+j+k)));
	q1=(cos(ang.degrad/2)+(sin(ang.degrad/2)*(i+j+k)));


	va=q*va*q.conjugate;
	v1=q*v1*q.conjugate;
	v2=q*v2*q.conjugate;
	v3=q*v3*q.conjugate;

	vb=q1*vb*q1.conjugate;
	v4=q1*v4*q1.conjugate;
	v5=q1*v5*q1.conjugate;
	v6=q1*v6*q1.conjugate;

	cva=Cartesian(va.b,va.c,va.d);
	cvb=Cartesian(vb.b,vb.c,vb.d);

	cvax=Cartesian(v1.b,v1.c,v1.d);
	cvay=Cartesian(v2.b,v2.c,v2.d);
	cvaz=Cartesian(v3.b,v3.c,v3.d);

	cvbx=Cartesian(v4.b,v4.c,v4.d);
	cvby=Cartesian(v5.b,v5.c,v5.d);
	cvbz=Cartesian(v6.b,v6.c,v6.d);

    phx=exp(Complex(0,1)*(angle.degrad)).phase;
	phy=exp(Complex(0,1)*(angle1.degrad)).phase;

	ph_va_x=Complex(va.a.round(0.0001),va.b.round(0.0001)).phase;
	ph_va_y=Complex(va.a.round(0.0001),va.c.round(0.0001)).phase;
	ph_va_z=Complex(va.a.round(0.0001),va.d.round(0.0001)).phase;

	ph_vb_x=Complex(vb.a.round(0.0001),vb.b.round(0.0001)).phase;
	ph_vb_y=Complex(vb.a.round(0.0001),vb.c.round(0.0001)).phase;
	ph_vb_z=Complex(vb.a.round(0.0001),vb.d.round(0.0001)).phase;

env1=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:phx.real.round(0.0001));
env2=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:phx.imag.round(0.0001));


osc1_x=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,phx,2pi)),Buffer.loadCollection(~s1, ~a.getSetsAndMatrices);,cva.theta.degrad,cva.phi.degrad);
osc1_y=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,phy,2pi)),Buffer.loadCollection(~s1, ~a.getSetsAndMatrices);,cvb.theta.degrad,cvb.phi.degrad);

//osc1_x=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_va_x,2pi)),~b.bufnum,cvax.theta,cvax.phi);
//osc1_y=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_va_y,2pi)),~b.bufnum,cvay.theta,cvay.phi);
//osc1_z=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_va_z,2pi)),~b.bufnum,cvaz.theta,cvaz.phi);

//osc2_x=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_vb_x,2pi)),~b.bufnum,cvbx.theta,cvbx.phi);
//osc2_y=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_vb_y,2pi)),~b.bufnum,cvby.theta,cvby.phi);
//osc2_z=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_vb_z,2pi)),~b.bufnum,cvbz.theta,cvbz.phi);

m=m+1;

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env1),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc1_y)*env2),cutt));
//	wrappedOut3.value(out, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));

	//wrappedOut4.value(out,LPF.ar(LeakDC.ar((osc2_x)*env),cutt));
	//wrappedOut5.value(out, LPF.ar(LeakDC.ar((osc2_y)*env),cutt));
	//wrappedOut6.value(out, LPF.ar(LeakDC.ar((osc2_z)*env),cutt));


	//Out.ar(0,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));
	//Out.ar(0,LPF.ar(LeakDC.ar((osc2_x)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc2_y)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc2_z)*env),cutt));


	};
}).add;
);
(
SynthDef.new(\oc, {
	arg  n1=1, cutt=440,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1,ng1=1,ng2=1,ng3=1;
	var q,q1,i,j,k,va,vb,v1,v2,v3,v4,v5,v6,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z,ph_va_x,ph_va_y,ph_va_z,ph_vb_x,ph_vb_y,ph_vb_z;
	var osc1,osc2,osc3,freq, env1,env2,m=1,bank, pitch, fund, angle=0,angle1=90,r,p;
	var osc1_x,osc1_y,osc1_z,osc2_x,osc2_y,osc2_z,cvax,cvay,cvaz,cvbx,cvby,cvbz,cva,cvb,phx,phy;
	var spacex,timex,spacey,timey,spacez,timez,ang=(360-(360/1.6180339887499));
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut3 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
		var wrappedOut4 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut5 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut6 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};


	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	r=[rx,ry,rz].normalizeSum;

	i = Quaternion(0, r.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r.[2].sqrt);

	p=[x,y,z].normalizeSum;


	v1=Quaternion(0,p.[0].sqrt*ng1,0,0);
	v2=Quaternion(0,0,p.[1].sqrt*ng2,0);
	v3=Quaternion(0,0,0,p.[2].sqrt*ng3);
	v4=Quaternion(0,p.[0].sqrt*ng1,0,0);
	v5=Quaternion(0,0,p.[1].sqrt*ng2,0);
	v6=Quaternion(0,0,0,p.[2].sqrt*ng3);
	va=Quaternion(0,p.[0].sqrt*ng1,p.[1].sqrt*ng2,p.[2].sqrt*ng3);
	vb=Quaternion(0,p.[0].sqrt*ng1,p.[1].sqrt*ng2,p.[2].sqrt*ng3);

	bank=32;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*6)*pitch;

	q1=(cos(90.degrad/2)+(sin(90.degrad/2)*(i+j+k)));
	vb=q1*vb*q1.conjugate;
	v4=q1*v4*q1.conjugate;
	v5=q1*v5*q1.conjugate;
	v6=q1*v6*q1.conjugate;

	bank.do{
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);

	q=(cos(ang.degrad/2)+(sin(ang.degrad/2)*(i+j+k)));
	q1=(cos(ang.degrad/2)+(sin(ang.degrad/2)*(i+j+k)));


	va=q*va*q.conjugate;
	v1=q*v1*q.conjugate;
	v2=q*v2*q.conjugate;
	v3=q*v3*q.conjugate;

	vb=q1*vb*q1.conjugate;
	v4=q1*v4*q1.conjugate;
	v5=q1*v5*q1.conjugate;
	v6=q1*v6*q1.conjugate;

	cva=Cartesian(va.b,va.c,va.d);
	cvb=Cartesian(vb.b,vb.c,vb.d);

	cvax=Cartesian(v1.b,v1.c,v1.d);
	cvay=Cartesian(v2.b,v2.c,v2.d);
	cvaz=Cartesian(v3.b,v3.c,v3.d);

	cvbx=Cartesian(v4.b,v4.c,v4.d);
	cvby=Cartesian(v5.b,v5.c,v5.d);
	cvbz=Cartesian(v6.b,v6.c,v6.d);

	phx=exp(Complex(0,1)*(angle.degrad)).phase;
	phy=exp(Complex(0,1)*(angle1.degrad)).phase;

	ph_va_x=Complex(va.a.round(0.0001),va.b.round(0.0001)).phase;
	ph_va_y=Complex(va.a.round(0.0001),va.c.round(0.0001)).phase;
	ph_va_z=Complex(va.a.round(0.0001),va.d.round(0.0001)).phase;

	ph_vb_x=Complex(vb.a.round(0.0001),vb.b.round(0.0001)).phase;
	ph_vb_y=Complex(vb.a.round(0.0001),vb.c.round(0.0001)).phase;
	ph_vb_z=Complex(vb.a.round(0.0001),vb.d.round(0.0001)).phase;

env1=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:phx.real.round(0.0001));
env2=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:phx.imag.round(0.0001));


osc1_x=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,phx,2pi)),Buffer.loadCollection(~s2, ~a.getSetsAndMatrices);,cva.theta.degrad,cva.phi.degrad);
osc1_y=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,phy,2pi)),Buffer.loadCollection(~s2, ~a.getSetsAndMatrices);,cvb.theta.degrad,cvb.phi.degrad);

//osc1_x=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_va_x,2pi)),~b.bufnum,cvax.theta,cvax.phi);
//osc1_y=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_va_y,2pi)),~b.bufnum,cvay.theta,cvay.phi);
//osc1_z=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_va_z,2pi)),~b.bufnum,cvaz.theta,cvaz.phi);

//osc2_x=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_vb_x,2pi)),~b.bufnum,cvbx.theta,cvbx.phi);
//osc2_y=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_vb_y,2pi)),~b.bufnum,cvby.theta,cvby.phi);
//osc2_z=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_vb_z,2pi)),~b.bufnum,cvbz.theta,cvbz.phi);

m=m+1;

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env1),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc1_y)*env2),cutt));
//	wrappedOut3.value(out, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));

	//wrappedOut4.value(out,LPF.ar(LeakDC.ar((osc2_x)*env),cutt));
	//wrappedOut5.value(out, LPF.ar(LeakDC.ar((osc2_y)*env),cutt));
	//wrappedOut6.value(out, LPF.ar(LeakDC.ar((osc2_z)*env),cutt));


	//Out.ar(0,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));
	//Out.ar(0,LPF.ar(LeakDC.ar((osc2_x)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc2_y)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc2_z)*env),cutt));


	};
}).add;
);
(
SynthDef.new(\od, {
	arg  n1=1, cutt=440,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1,ng1=1,ng2=1,ng3=1;
	var q,q1,i,j,k,va,vb,v1,v2,v3,v4,v5,v6,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z,ph_va_x,ph_va_y,ph_va_z,ph_vb_x,ph_vb_y,ph_vb_z;
	var osc1,osc2,osc3,freq, env1,env2,m=1,bank, pitch, fund, angle=0,angle1=90,r,p;
	var osc1_x,osc1_y,osc1_z,osc2_x,osc2_y,osc2_z,cvax,cvay,cvaz,cvbx,cvby,cvbz,cva,cvb,phx,phy;
	var spacex,timex,spacey,timey,spacez,timez,ang=(360-(360/1.6180339887499));
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut3 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
		var wrappedOut4 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut5 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut6 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};


	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	r=[rx,ry,rz].normalizeSum;

	i = Quaternion(0, r.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r.[2].sqrt);

	p=[x,y,z].normalizeSum;


	v1=Quaternion(0,p.[0].sqrt*ng1,0,0);
	v2=Quaternion(0,0,p.[1].sqrt*ng2,0);
	v3=Quaternion(0,0,0,p.[2].sqrt*ng3);
	v4=Quaternion(0,p.[0].sqrt*ng1,0,0);
	v5=Quaternion(0,0,p.[1].sqrt*ng2,0);
	v6=Quaternion(0,0,0,p.[2].sqrt*ng3);
	va=Quaternion(0,p.[0].sqrt*ng1,p.[1].sqrt*ng2,p.[2].sqrt*ng3);
	vb=Quaternion(0,p.[0].sqrt*ng1,p.[1].sqrt*ng2,p.[2].sqrt*ng3);

	bank=32;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*6)*pitch;

	q1=(cos(90.degrad/2)+(sin(90.degrad/2)*(i+j+k)));
	vb=q1*vb*q1.conjugate;
	v4=q1*v4*q1.conjugate;
	v5=q1*v5*q1.conjugate;
	v6=q1*v6*q1.conjugate;

	bank.do{
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);

	q=(cos(ang.degrad/2)+(sin(ang.degrad/2)*(i+j+k)));
	q1=(cos(ang.degrad/2)+(sin(ang.degrad/2)*(i+j+k)));


	va=q*va*q.conjugate;
	v1=q*v1*q.conjugate;
	v2=q*v2*q.conjugate;
	v3=q*v3*q.conjugate;

	vb=q1*vb*q1.conjugate;
	v4=q1*v4*q1.conjugate;
	v5=q1*v5*q1.conjugate;
	v6=q1*v6*q1.conjugate;

	cva=Cartesian(va.b,va.c,va.d);
	cvb=Cartesian(vb.b,vb.c,vb.d);

	cvax=Cartesian(v1.b,v1.c,v1.d);
	cvay=Cartesian(v2.b,v2.c,v2.d);
	cvaz=Cartesian(v3.b,v3.c,v3.d);

	cvbx=Cartesian(v4.b,v4.c,v4.d);
	cvby=Cartesian(v5.b,v5.c,v5.d);
	cvbz=Cartesian(v6.b,v6.c,v6.d);

	phx=exp(Complex(0,1)*(angle.degrad)).phase;
	phy=exp(Complex(0,1)*(angle1.degrad)).phase;

	ph_va_x=Complex(va.a.round(0.0001),va.b.round(0.0001)).phase;
	ph_va_y=Complex(va.a.round(0.0001),va.c.round(0.0001)).phase;
	ph_va_z=Complex(va.a.round(0.0001),va.d.round(0.0001)).phase;

	ph_vb_x=Complex(vb.a.round(0.0001),vb.b.round(0.0001)).phase;
	ph_vb_y=Complex(vb.a.round(0.0001),vb.c.round(0.0001)).phase;
	ph_vb_z=Complex(vb.a.round(0.0001),vb.d.round(0.0001)).phase;

env1=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:phx.real.round(0.0001));
env2=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:phx.imag.round(0.0001));


osc1_x=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,phx,2pi)),Buffer.loadCollection(~s3, ~a.getSetsAndMatrices);,cva.theta.degrad,cva.phi.degrad);
osc1_y=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,phy,2pi)),Buffer.loadCollection(~s3, ~a.getSetsAndMatrices);,cvb.theta.degrad,cvb.phi.degrad);

//osc1_x=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_va_x,2pi)),~b.bufnum,cvax.theta,cvax.phi);
//osc1_y=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_va_y,2pi)),~b.bufnum,cvay.theta,cvay.phi);
//osc1_z=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_va_z,2pi)),~b.bufnum,cvaz.theta,cvaz.phi);

//osc2_x=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_vb_x,2pi)),~b.bufnum,cvbx.theta,cvbx.phi);
//osc2_y=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_vb_y,2pi)),~b.bufnum,cvby.theta,cvby.phi);
//osc2_z=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_vb_z,2pi)),~b.bufnum,cvbz.theta,cvbz.phi);

m=m+1;

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env1),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc1_y)*env2),cutt));
//	wrappedOut3.value(out, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));

	//wrappedOut4.value(out,LPF.ar(LeakDC.ar((osc2_x)*env),cutt));
	//wrappedOut5.value(out, LPF.ar(LeakDC.ar((osc2_y)*env),cutt));
	//wrappedOut6.value(out, LPF.ar(LeakDC.ar((osc2_z)*env),cutt));


	//Out.ar(0,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));
	//Out.ar(0,LPF.ar(LeakDC.ar((osc2_x)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc2_y)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc2_z)*env),cutt));


	};
}).add;
);
)

(
SynthDescLib.global.addServer(~s1);
SynthDescLib.global.addServer(~s2);
SynthDescLib.global.addServer(~s3);
)

(
var  angle1=0,angle2=0,angle3=0,angle4=0,q1,q2,q3,q4,v1,v2,v3,v4,ph1,ph2,ph3,ph4,r,m=2;
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
var  angle1=0,angle2=0,angle3=0,angle4=0,q1,q2,q3,q4,v1,v2,v3,v4,ph1,ph2,ph3,ph4,r,m=12;
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt, 0),k = Quaternion(0, 0, 0, (1/3).sqrt),n1,n2,n3,n4;

r=[1/2,2/3,3/4].normalizeSum;

v1=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);
v2=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);


	~n1 = 10000.collect{
		angle1=((360-(360/1.6180339887499)));
		q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));

	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(1);
	};
~n2 = 10000.collect{
		angle2=((360-(360/1.6180339887499)));
		q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(1);
	};

~n3 = 10000.collect{
		angle3=((360-(360/1.6180339887499)));
		q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(1);
	};

~n4 = 10000.collect{
		angle4=((360-(360/1.6180339887499)));
		q4=(cos(angle4.degrad/2)+(sin(angle4.degrad/2)*(i+j+k)));
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
	\server,~s1,
\n1,PdegreeToKey(Pseq(~n2,1),Scale.phrygian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\x,Pbrown(0,1,0.1,inf),
	\y,Pbrown(0,1,0.1,inf),
	\z,Pbrown(0,1,0.1,inf),
	\rx,Pbrown(0,1,0.1,inf),
	\ry,Pbrown(0,1,0.1,inf),
	\rz,Pbrown(0,1,0.1,inf),
		\ng1,Prand([1.neg,1,1.neg,1],inf),
	\ng2,Prand([1.neg,1,1.neg,1],inf),
	\ng3,Prand([1.neg,1,1.neg,1],inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	//\dur,1/2,
	\dur,Pseq(~phase3.abs,inf),
	\server,~s2,
\n1,PdegreeToKey(Pseq(~n3,1),Scale.phrygian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\x,Pbrown(0,1,0.1,inf),
	\y,Pbrown(0,1,0.1,inf),
	\z,Pbrown(0,1,0.1,inf),
	\rx,Pbrown(0,1,0.1,inf),
	\ry,Pbrown(0,1,0.1,inf),
	\rz,Pbrown(0,1,0.1,inf),
		\ng1,Prand([1.neg,1,1.neg,1],inf),
	\ng2,Prand([1.neg,1,1.neg,1],inf),
	\ng3,Prand([1.neg,1,1.neg,1],inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	//\dur,1/2,
	\dur,Pseq(~phase4.abs,inf),
	\server,~s3,
\n1,PdegreeToKey(Pseq(~n4,1),Scale.phrygian),
	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\x,Pbrown(0,1,0.1,inf),
	\y,Pbrown(0,1,0.1,inf),
	\z,Pbrown(0,1,0.1,inf),
	\rx,Pbrown(0,1,0.1,inf),
	\ry,Pbrown(0,1,0.1,inf),
	\rz,Pbrown(0,1,0.1,inf),
		\ng1,Prand([1.neg,1,1.neg,1],inf),
	\ng2,Prand([1.neg,1,1.neg,1],inf),
	\ng3,Prand([1.neg,1,1.neg,1],inf),
	\decay,Pbrown(2,8,1,inf);
));
)


(
b.play;
c.play;
d.play;

)

~r1=Recorder.new(~s1);
~r2=Recorder.new(~s2);
~r3=Recorder.new(~s3);

~r1.record(numChannels:4);
~r2.record(numChannels:4);
~r3.record(numChannels:4);