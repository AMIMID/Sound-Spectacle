(
~c1 = Buffer.read(s,);
~c2 = Buffer.read(s,);
~c3 = Buffer.read(s,);
)

(
{

	Out.ar(0,PlayBuf.ar(4, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0, doneAction:2));
	Out.ar(0,PlayBuf.ar(4, ~c2.bufnum, BufRateScale.kr(~c2), loop: 0, doneAction:2));
	Out.ar(0,PlayBuf.ar(4, ~c3.bufnum, BufRateScale.kr(~c3), loop: 0, doneAction:2));
	Out.ar(4,PlayBuf.ar(4, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0, doneAction:2));
	Out.ar(4,PlayBuf.ar(4, ~c2.bufnum, BufRateScale.kr(~c2), loop: 0, doneAction:2));
	Out.ar(4,PlayBuf.ar(4, ~c3.bufnum, BufRateScale.kr(~c3), loop: 0, doneAction:2));

}.play;
s.record(numChannels:8)
)


(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=8;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*64;
//s.options.blockSize = 64/4;
s.options.maxNodes = 1024 * 64;
s.waitForBoot
)

////normal and reverse. beg,end
(
~c1 = Buffer.read(s,);
~c2 = Buffer.read(s,);
)

(
Tdef.new(\h,{loop({

	Out.ar(0,PlayBuf.ar(4, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0, doneAction:2));(1).wait;
	Out.ar(0,PlayBuf.ar(4, ~c2.bufnum, BufRateScale.kr(~c2), loop: 0, doneAction:2));

	}
)})
)


Tdef(\h).stop;
Tdef(\h).play;
Tdef(\h).clear;