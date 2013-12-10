/*
 * Copyright 2013 Boris Smus. All Rights Reserved.

 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


function MicrophoneSample() {
  this.WIDTH = 640;
  this.HEIGHT = 480;
  this.getMicrophoneInput();
  this.canvas = document.querySelector('canvas');



}


MicrophoneSample.prototype.getMicrophoneInput = function() {
  navigator.webkitGetUserMedia({audio: true},
                               this.onStream.bind(this),
                               this.onStreamError.bind(this));
};

MicrophoneSample.prototype.onStream = function(stream) {
  var input = context.createMediaStreamSource(stream);
  var filter = context.createBiquadFilter();
  filter.frequency.value = 60.0;
  filter.type = filter.NOTCH;
  filter.Q = 10.0;

  var analyser = context.createAnalyser();

  // Connect graph.
  input.connect(filter);
  filter.connect(analyser);

  this.analyser = analyser;
  // Setup a timer to visualize some stuff.
  requestAnimFrame(this.visualize.bind(this));
};

MicrophoneSample.prototype.onStreamError = function(e) {
  console.error('Error getting microphone', e);
};

MicrophoneSample.prototype.visualize = function() {
  this.canvas.width = this.WIDTH;
  this.canvas.height = this.HEIGHT;
  var drawContext = this.canvas.getContext('2d');

  this.analyser.fftSize = 32;
  console.log(this.analyser.frequencyBinCount);
  var freqDomain = new Uint8Array(this.analyser.frequencyBinCount);
  //this.analyser.getByteFrequencyData(freqDomain);
  this.analyser.getByteFrequencyData(freqDomain);
  // console.log(freqDomain);
  console.log(freqDomain);

  var nyquist = context.sampleRate/2;

  var f = freqDomain[1];
  var valuerealf= Math.round(nyquist*f);
    //console.log(freqDomain[1023]);
    console.log(freqDomain[1]);
    console.log( valuerealf);
   

    //var fv = times[i];
    //console.log(i);
    var text = valuerealf + ' Hz';
    document.getElementById('frequency').innerHTML = text ;



  var times = new Uint8Array(this.analyser.frequencyBinCount);
  this.analyser.getByteTimeDomainData(times);
  //onsole.log(freqDomain.length);
  //console.log(freqDomain);



  for (var i = 0; i < times[i]; i++) {
    var value = times[i];
    var percent = value;
    var height = this.HEIGHT * percent;
    var offset = this.HEIGHT - height - 1;
    var barWidth = this.WIDTH/times.length;
    drawContext.fillStyle = 'black';
    drawContext.fillRect(i * barWidth, offset, 1, 1);
  }
  requestAnimFrame(this.visualize.bind(this));

};
