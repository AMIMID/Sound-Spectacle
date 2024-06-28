(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(80/120);
s.options.memSize = 8192*64;
//s.options.blockSize = 64/4;
s.options.maxNodes = 1024 * 64;
s.waitForBoot
)

(
{Out.kr(0,SinOsc.kr(0.1,phase:0.degrad,mul:2pi))}.play;
{Out.kr(1,SinOsc.kr(0.1,phase:90.degrad,mul:2pi))}.play;
{Out.kr(2,SinOsc.kr(0.1,phase:90.degrad,mul:2pi))}.play;
)

(
SynthDef.new(\player,{
	arg tempo;
	var env;
	var sig1, sig2, sig3, sig4;

	sig1=SinOsc.ar(0.1,phase:0.degrad,mul:2pi);
	sig2=SinOsc.ar(0.1,phase:90.degrad,mul:2pi);
	sig3=SinOsc.ar(0.1,phase:90.degrad,mul:2pi);

	~a = Amplitude.ar(sig1, 0.01, 0.25).poll;SendReply.ar(Impulse.ar(1000), '/a', ~a);
	~b = Amplitude.ar(sig2, 0.01, 0.25);SendReply.ar(Impulse.ar(1000), '/b', ~b);
	~c = Amplitude.ar(sig3, 0.01, 0.25);SendReply.ar(Impulse.ar(1000), '/c', ~c);

Out.ar(0,sig1*1);
Out.ar(1,sig2*1);
Out.ar(2,sig3*1);
}).add;
);
Synth.new(\player);


(
var data,i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt,0),k = Quaternion(0, 0, 0, (1/3).sqrt);
var q,v,angle=0,x,y,z,r,d,m=0,pp=1,rot;

OSCdef(\amp1, { |msg|
	~a = msg[3];
	defer { w.refresh };
}, '/a', s.addr);

OSCdef(\amp2, { |msg|
	~b = msg[3];
	defer { w.refresh };
}, '/b', s.addr);

OSCdef(\amp3, { |msg|
	~c = msg[3];
	defer { w.refresh };
}, '/c', s.addr);


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
a = ScatterView3d(w, Rect(0,0, 800,800), data, [-2000, 2000].asSpec,[-2000, 2000].asSpec,[-2000, 2000].asSpec);
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