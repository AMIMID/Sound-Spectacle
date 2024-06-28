(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*64;
//s.options.blockSize = 64/4;
s.waitForBoot
)
Server.killAll


(
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt, 0),k = Quaternion(0, 0, 0, (1/3).sqrt),q1,q2,v1,v2,v3,angle=0,ph1x,ph1y,ph1z,ph2x,ph2y,ph2z,ph3x,ph3y,ph3z;


1.do{
	angle=(angle+(60)).wrap(0,360);
 	q1=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
 	q2=q1.conjugate;
	v1=Quaternion(0,1,2,3);
	//v2=Quaternion(0,0,1,0);
	//v3=Quaternion(0,0,0,1);
	v1=q1*v1;
	//v2=q1*v2;
	//v3=q1*v3;
	//v=v*q2 opposite direction rotation
	//v=v*q2;
 	v1.coordinates.round(0.0001).postln;
	//v2.coordinates.round(0.0001).postln;
	//v3.coordinates.round(0.0001).postln;
	ph1x=Complex(v1.a.round(0.0001),v1.b.round(0.0001)).phase;
	ph1y=Complex(v1.a.round(0.0001),v1.c.round(0.0001)).phase;
	ph1z=Complex(v1.a.round(0.0001),v1.d.round(0.0001)).phase;
	//ph2x=Complex(v2.a.round(0.0001),v2.b.round(0.0001)).phase;
	//ph2y=Complex(v2.a.round(0.0001),v2.c.round(0.0001)).phase;
	//ph2z=Complex(v2.a.round(0.0001),v2.d.round(0.0001)).phase;
	//ph3x=Complex(v3.a.round(0.0001),v3.b.round(0.0001)).phase;
	//ph3y=Complex(v3.a.round(0.0001),v3.c.round(0.0001)).phase;
	//ph3z=Complex(v3.a.round(0.0001),v3.d.round(0.0001)).phase;
	ph1x.postln;

 }

)

(
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt, 0),k = Quaternion(0, 0, 0, (1/3).sqrt),q1,q2,v1,v2,v3,angle=0,ph1x,ph1y,ph1z,ph2x,ph2y,ph2z,ph3x,ph3y,ph3z;


1.do{
	angle=(angle+(0)).wrap(0,360);
 	q1=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
 	q2=q1.conjugate;
	v1=Quaternion(0,1,0,0);
	//v2=Quaternion(0,0,1,0);
	//v3=Quaternion(0,0,0,1);
	v1=q1*v1;
	//v2=q1*v2;
	//v3=q1*v3;
	//v=v*q2 opposite direction rotation
	//v=v*q2;
 	v1.coordinates.round(0.0001).postln;
	//v2.coordinates.round(0.0001).postln;
	//v3.coordinates.round(0.0001).postln;
	ph1x=Complex(v1.a.round(0.0001),v1.b.round(0.0001)).phase;
	ph1y=Complex(v1.a.round(0.0001),v1.c.round(0.0001)).phase;
	ph1z=Complex(v1.a.round(0.0001),v1.d.round(0.0001)).phase;
	//ph2x=Complex(v2.a.round(0.0001),v2.b.round(0.0001)).phase;
	//ph2y=Complex(v2.a.round(0.0001),v2.c.round(0.0001)).phase;
	//ph2z=Complex(v2.a.round(0.0001),v2.d.round(0.0001)).phase;
	//ph3x=Complex(v3.a.round(0.0001),v3.b.round(0.0001)).phase;
	//ph3y=Complex(v3.a.round(0.0001),v3.c.round(0.0001)).phase;
	//ph3z=Complex(v3.a.round(0.0001),v3.d.round(0.0001)).phase;
	ph1x.postln;

 }

)

(
{
var m=1,fund=110,freq,osc,q,v,x,y,z,angle=0,i = Quaternion(0, (1/3).sqrt, 0, 0);
var j = Quaternion(0, 0, (1/3).sqrt, 0),k = Quaternion(0, 0, 0, (1/3).sqrt);

	v=Quaternion(0,1,0,0);

	3.do{

         q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));

		v=q*v;

		v=v*m;

		v.b.abs.postln;

		osc=SinOsc.ar(fund*v.b.abs,mul:v.b.abs.reciprocal);

		Out.ar(0,osc!2);

		m=m+1;

		angle=(angle+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);


	};

}.play;
)


(

var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt, 0),k = Quaternion(0, 0, 0, (1/3).sqrt),q1,q2,v1,v2,v3,angle=0,ph1x,ph1y,ph1z,ph2x,ph2y,ph2z,ph3x,ph3y,ph3z;



angle=MouseX.kr(2pi.neg,2pi);
 	q1=(angle+(angle*(i+j+k)));
 	q2=q1.conjugate;
	v1=Quaternion(0,1,0,0);

	v1=q1*v1;

 	v1.coordinates.round(0.0001).poll;

	ph1x=Complex(v1.a.round(0.0001),v1.b.round(0.0001)).phase;
	ph1y=Complex(v1.a.round(0.0001),v1.c.round(0.0001)).phase;
	ph1z=Complex(v1.a.round(0.0001),v1.d.round(0.0001)).phase;

	ph1x.poll;

)

(
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt, 0),k = Quaternion(0, 0, 0, (1/3).sqrt);
var q,v,angle=0,x,y,z,phx,phy,phz;
var scale=300,m=0,n=0,s,u;

///////0//////////////////////////////////////////////////////////////////////////////////////////////////
    Window.closeAll;
    w = Window("S",Rect(400,100,800,800),scroll:false).front.alwaysOnTop_(true);
    w.alpha = 1;  w.view.background = Color.white;

//~v = UserView.new(w,Rect(0,0,800,800)).background_(Color.white);
//~v.animate;
w.drawFunc={
//Pen.translate(400,400);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////points
v=Quaternion(0,1,2,3);

800.do{
800.do{

angle=(angle+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
		v=q*v;
		s=v.a;
		x=v.b;
		y=v.c;
		z=v.d;
		//phx=Complex(v.a.round(0.0001),v.b.round(0.0001)).phase.linlin(2pi.neg,2pi,0,255);
		//phy=Complex(v.a.round(0.0001),v.c.round(0.0001)).phase.linlin(2pi.neg,2pi,0,255);
		//phz=Complex(v.a.round(0.0001),v.d.round(0.0001)).phase.linlin(2pi.neg,2pi,0,255);
		u=[x,y,z].normalize.abs;

Pen.width=0.1;


			//Color(red:u.[0],green:u.[1],blue:u.[2],alpha:1).set;
			Color(red:u.[0],green:u.[1],blue:u.[2],alpha:1).set;



		Pen.fillRect(Rect.new(m,n,1,1));


		Pen.stroke;
m=m+1;

	};
		m=0;
		n=n+1;
	}


};
)

(
SynthDef.new(\oa, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.05;
	var x=0.999.rand,y=0.999.rand,z=0.999.rand;
	var q,i,j,k,v1,v2,v3,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z,ph_v3_x,ph_v3_y,ph_v3_z;
	var osc1,osc2,osc3,freq, env,m=1,bank, pitch, fund, angle=0;
	var osc1_x,osc1_y,osc1_z,osc2_x,osc2_y,osc2_z,osc3_x,osc3_y,osc3_z;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut3 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!

	i = Quaternion(0, (1/3).sqrt, 0, 0);
	j = Quaternion(0, 0, (1/3).sqrt, 0);
	k = Quaternion(0, 0, 0, (1/3).sqrt);
	v1=Quaternion(0,x,y,z);
	v2=Quaternion(0,0,1,0);
	v3=Quaternion(0,0,0,1);
	bank=100;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*6)*pitch;

	x.postln;
		y.postln;
		z.postln;

	bank.do{

	q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	v1=q*v1;
	v2=q*v2;
	v3=q*v3;
	ph_v1_x=Complex(v1.a.round(0.0001),v1.b.round(0.0001)).phase;
	ph_v1_y=Complex(v1.a.round(0.0001),v1.c.round(0.0001)).phase;
	ph_v1_z=Complex(v1.a.round(0.0001),v1.d.round(0.0001)).phase;
	ph_v2_x=Complex(v2.a.round(0.0001),v2.b.round(0.0001)).phase;
	ph_v2_y=Complex(v2.a.round(0.0001),v2.c.round(0.0001)).phase;
	ph_v2_z=Complex(v2.a.round(0.0001),v2.d.round(0.0001)).phase;
	ph_v3_x=Complex(v3.a.round(0.0001),v3.b.round(0.0001)).phase;
	ph_v3_y=Complex(v3.a.round(0.0001),v3.c.round(0.0001)).phase;
	ph_v3_z=Complex(v3.a.round(0.0001),v3.d.round(0.0001)).phase;

osc1_x=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:ph_v1_x),v1.b);

osc1_y=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:ph_v1_y),v1.c);

osc1_z=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:ph_v1_z),v1.d);

/*osc2_x=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v2_x,2pi)), LFSaw.ar(1,ph_v2_x.linlin(2pi.neg,2pi,1.neg,1)));

osc2_y=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v2_y,2pi)), LFSaw.ar(1,ph_v2_y.linlin(2pi.neg,2pi,1.neg,1)));

osc2_z=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v2_z,2pi)), LFSaw.ar(1,ph_v2_z.linlin(2pi.neg,2pi,1.neg,1)));

osc3_x=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v3_x,2pi)), LFSaw.ar(1,ph_v3_x.linlin(2pi.neg,2pi,1.neg,1)));

osc3_y=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v3_y,2pi)), LFSaw.ar(1,ph_v3_y.linlin(2pi.neg,2pi,1.neg,1)));

osc3_z=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v3_z,2pi)), LFSaw.ar(1,ph_v3_z.linlin(2pi.neg,2pi,1.neg,1)));*/

//osc1=osc1_x+osc1_y+osc1_z;
//osc2=osc2_x+osc2_y+osc2_z;
//osc3=osc3_x+osc3_y+osc3_z;

m=m+1;
angle=(angle+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc1_y)),cutt));
	wrappedOut3.value(out, LPF.ar(LeakDC.ar((osc1_z)),cutt));

	};
}).add;
)

Synth.new(\oa,[\out,[0,1]]);












(
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt, 0),k = Quaternion(0, 0, 0, (1/3).sqrt);
var q,v,angle=0,x,y,z,phx,phy,phz;
var scale=300,m=0,n=0,f,u,ra;

///////0//////////////////////////////////////////////////////////////////////////////////////////////////
    Window.closeAll;
    w = Window("S",Rect(400,100,800,800),scroll:false).front.alwaysOnTop_(true);
    w.alpha = 1;  w.view.background = Color.white;

//~v = UserView.new(w,Rect(0,0,800,800)).background_(Color.white);
//~v.animate;
angle=(360-(360/1.6180339887499));
w.drawFunc={
//Pen.translate(400,400);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////points
	ra=[1,2,3].normalizeSum;
	v=Quaternion(0,ra.[0].sqrt,ra.[1].sqrt,ra.[2].sqrt);

800.do{
800.do{

	q=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i+j+k)));
		v=q*v*q.conjugate;

		//phx=Complex(v.a.round(0.0001),v.b.round(0.0001)).phase.linlin(2pi.neg,2pi,0,255);
		//phy=Complex(v.a.round(0.0001),v.c.round(0.0001)).phase.linlin(2pi.neg,2pi,0,255);
		//phz=Complex(v.a.round(0.0001),v.d.round(0.0001)).phase.linlin(2pi.neg,2pi,0,255);

Pen.width=0.1;


			//Color(red:u.[0],green:u.[1],blue:u.[2],alpha:1).set;
			Color(red:v.b.abs,green:v.c.abs,blue:v.d.abs,alpha:1).set;



		Pen.fillRect(Rect.new(m,n,5,5));


		Pen.stroke;
m=m+5;

	};
		m=0;
		n=n+5;
	}


};
)


(
~e1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/SC_240414_142504.wav",channels:0);
~e2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/SC_240414_142504.wav",channels:1);
)

(
SynthDef.new(\player,{
	arg tempo;
	var env;
	var sig1, sig2, sig3, sig4;

	//env=EnvGen.ar(Env.new([0,tempo.reciprocal,tempo.reciprocal,0],[1,50,1]), doneAction: 2);

	sig1=PlayBuf.ar(1,~e1.bufnum,BufRateScale.kr(~e1.bufnum),loop:0);
	sig2=PlayBuf.ar(1,~e2.bufnum,BufRateScale.kr(~e2.bufnum),loop:0);
	//sig1=PlayBuf.ar(1,0,BufRateScale.kr(0),startPos:0,loop:inf,rate:1);//*env;
	//sig2=PlayBuf.ar(1,1,BufRateScale.kr(1),startPos:0,loop:inf,rate:1);//*env;
	//sig3=PlayBuf.ar(1,2,BufRateScale.kr(2),startPos:0,loop:inf,rate:1);//*env;
	//sig4=PlayBuf.ar(1,3,BufRateScale.kr(3),startPos:0,loop:inf,rate:1);//*env;

	~a = Amplitude.ar(sig1, 0.01, 0.25,100).poll;SendReply.ar(Impulse.ar(1000), '/a', ~a);
	~b = Amplitude.ar(sig2, 0.01, 0.25,100);SendReply.ar(Impulse.ar(1000), '/b', ~b);
	//~c = Amplitude.ar(sig3, 0.01, 0.25);SendReply.ar(Impulse.ar(100), '/c', ~c);
	//~d = Amplitude.ar(sig4, 0.01, 0.25);SendReply.ar(Impulse.ar(100), '/d', ~d);

Out.ar(0,sig1);
Out.ar(1,sig2);
//Out.ar(2,sig3);
//Out.ar(3,sig4);
}).add;
);
Synth.new(\player);






(
var run = true;
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt, 0),k = Quaternion(0, 0, 0, (1/3).sqrt);
var q,v,angle=0,x,y,z,phx,phy,phz;
var m=0,n=0,r,u,h1,h2;


OSCdef(\amp1, { |msg|
	~a = msg[3];
	defer { ~v.refresh };
}, '/a', s.addr);

OSCdef(\amp2, { |msg|
	~b = msg[3];
	defer { ~v.refresh };
}, '/b', s.addr);


///////0//////////////////////////////////////////////////////////////////////////////////////////////////
    Window.closeAll;
    w = Window("S",Rect(400,100,100,100),scroll:false).front.alwaysOnTop_(true);
    w.alpha = 1;  w.view.background = Color.green;

~v = UserView.new(w,Rect(0,0,100,100)).background_(Color.white);
~v.animate;

~v.drawFunc ={

v=Quaternion(0,1,2,3);


100.do{
		h1=~a;
	h2=~b;
100.do{
				h1=~a;
	h2=~b;

angle=(360-(360/1.6180339887499));

	q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
		v=q*v;
		r=v.a;
		x=v.b;
		y=v.c;
		z=v.d;
		//phx=Complex(v.a.round(0.0001),v.b.round(0.0001)).phase.linlin(2pi.neg,2pi,0,255);
		//phy=Complex(v.a.round(0.0001),v.c.round(0.0001)).phase.linlin(2pi.neg,2pi,0,255);
		//phz=Complex(v.a.round(0.0001),v.d.round(0.0001)).phase.linlin(2pi.neg,2pi,0,255);
		u=[x,y,z].normalize.abs;

Pen.width=0.1;


			//Color(red:u.[0],green:u.[1],blue:u.[2],alpha:1).set;
			Color(red:u.[0],green:u.[1],blue:u.[2],alpha:1).set;



		Pen.fillRect(Rect.new(m,n,h1,h2));


		Pen.stroke;
m=m+h1;

	};
		m=0;
		n=n+h2;

	};


};

{ while { run } {~v.background_(Color.white); ~v.refresh; (1/100).wait } }.fork(AppClock);
)








(
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt, 0),k = Quaternion(0, 0, 0, (1/3).sqrt);
var q,v,angle=0,x,y,z,phx,phy,phz;
var scale=300,m=0,n=0,f,u,ra,run=true;

///////0//////////////////////////////////////////////////////////////////////////////////////////////////
    Window.closeAll;
    w = Window("S",Rect(400,100,800,800),scroll:false).front.alwaysOnTop_(true);
    w.alpha = 1;  w.view.background = Color.white;

~v = UserView.new(w,Rect(0,0,800,800)).background_(Color.white);
~v.animate;

~v.drawFunc={
Pen.translate(400,400);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////points
	ra=[1,2,3].normalizeSum;
	v=Quaternion(0,ra.[0].sqrt.neg,ra.[1].sqrt,ra.[2].sqrt);

800.do{

angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);

	q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
		v=q*v*q.conjugate;

Pen.width=0.1;


			//Color(red:u.[0],green:u.[1],blue:u.[2],alpha:1).set;
			Color.black;



		Pen.line(Point(v.b*200,v.c*200),Point(v.c*200,v.d*200));

		//Pen.rotate(pi/2);
		Pen.stroke;~v.refresh;

	}


};
{ while { run } {~v.background_(Color.white); ~v.refresh; (1/100).wait } }.fork(AppClock);
)

(
var data,i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt,0),k = Quaternion(0, 0, 0, (1/3).sqrt);
var q,v,angle=0,x,y,z,r,d,m=0,pp=1,rot;

r=[1/2,2/3,3/4].normalizeSum;
v=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);
angle=(360-(360/1.6180339887499));

data = 20000.collect{
	rot=[0.99999.rand,0.99999.rand,0.99999.rand].normalizeSum;
	i=Quaternion(0, rot.[0].sqrt, 0, 0);
	j=Quaternion(0, 0, rot.[1].sqrt, 0);
	k=Quaternion(0, 0, 0, rot.[2].sqrt);

		//angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
		q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	    v=q*v*q.conjugate;
	//pp=(m+0.001)/m;
	//v=v*pp;
	m=m+0.1;
	d=Cartesian(v.b.round(0.0001)*m,v.c.round(0.0001)*m,v.d.round(0.0001)*m).asArray;
};

w = Window.new("3D Scatterplot", Rect(40,40, 1000, 800)).front;
a = ScatterView3d(w, Rect(0,0, 800,800), data, [-1000, 1000].asSpec,[-1000, 1000].asSpec,[-1000, 1000].asSpec);
a.drawMethod = \fillRect;
a.symbolSize = 1;
a.symbolColor = Color.white;
a.background = Color.black;

// Y Slider
Slider(w, Rect(820, 10, 10, 450)).action_{|me|
    a.rotY = me.value * 2pi;
    w.refresh;
};
// X Slider
Slider(w, Rect(870, 10, 10, 450)).action_{|me|
    a.rotX = me.value * 2pi;
    w.refresh;
};
// Z Slider
Slider(w, Rect(920, 10, 10, 450)).action_{|me|
    a.rotZ = me.value * 2pi;
    w.refresh;
};
)