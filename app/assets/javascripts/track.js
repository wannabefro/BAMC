var context, recorder, input, master, bufferLoader, track1, track, myAudioAnalyser, mySpectrum,
            tuna, color, user_beat, beatId, beatName, trackName, speakertude;


  function startUserMedia(stream) {
    effects();
    master = context.createGainNode();
    master.connect(limiter.input);
    limiter.connect(context.destination);
    input = context.createMediaStreamSource(stream);
    input.connect(eq.input);
    eq.connect(eq2.input);
    eq2.connect(eq3.input);
    eq3.connect(compressor.input);
    compressor.connect(distort.input);
    distort.connect(crazydistort.input);
    crazydistort.connect(reverb.input);
    reverb.connect(delay.input);
    delay.connect(master);
    loadTrack();
    recorder = new Recorder(limiter.input);
    input.connect(myAudioAnalyser);
    master.connect(mySpeakerAnalyser);
  }

  function endOfTrack(){
    if (track1.playbackState === 3){
      document.getElementById("stop").click();
    }
  }

  function startPlaying(button){
    reloadTrack();
    button.disabled = true;
    button.nextElementSibling.disabled = false;
    startTrack();
    trackOver = setInterval(endOfTrack, 500);
  }

  function stopPlaying(button){
    button.disabled = true;
    button.previousElementSibling.disabled = false;
    stopTrack();
    clearInterval(trackOver);
  }


  function startRecording(button) {
    if (master.gain.value === 0){
      master.gain.value = 1;
    }
    if (track === false){
      reloadTrack();
    }
    recorder && recorder.record();
    button.disabled = true;
    button.nextElementSibling.disabled = false;
    startTrack();
    trackOver = setInterval(endOfTrack, 500);
  }

  function stopRecording(button) {
    recorder && recorder.stop();
    button.disabled = true;
    button.previousElementSibling.disabled = false;

    master.gain.value = 0;
    createPlaybackLink();
    stopTrack();
    clearInterval(trackOver);
    recorder.clear();
  }

  function distortMe(button) {
    crazydistort.bypass = 0;
    eq.frequency = 500;
    delay.feedback = 0.5;
    delay.time = 250;
    delay.wet = 0.5;
    crazy = document.getElementById("crazy");
    crazy.innerHTML = 'Stop Distort';
    document.getElementById("crazy").setAttribute("onClick", "noDistortMe(this)");
  }

  function noDistortMe(button) {
    crazy.innerHTML = 'Distort';
    document.getElementById("crazy").setAttribute("onClick", "distortMe(this)");
    crazydistort.bypass = 1;
    eq.frequency = 120;
    delay.feedback = 0.25;
    delay.time = 150;
    delay.wet = 0.25;
  }

  function createPlaybackLink() {
    recorder && recorder.exportWAV(function(blob){
      var url = URL.createObjectURL(blob);
      // var input = document.createElement('input');
      var li = document.createElement('li');
      var au = document.createElement('audio');
      var button = document.createElement('button');
      button.className = 'link';
      button.innerHTML = 'Upload track';
      button.onclick = function(){
        sendS3(blob);
      };
      // sendS3(blob);



      // var hf = document.createElement('a');

      au.controls = true;
      // input.type = "text";
      // input.placeholder = "Name your track";
      au.src = url;
      // hf.href = url;
      // hf.download = new Date().toISOString() + '.wav';
      // hf.innerHTML = hf.download;
      li.appendChild(au);
      li.appendChild(button);
      // li.appendChild(hf);
      recordslist.appendChild(li);
    });
  }

  function sendS3(blob){
    var s3upload = s3upload != null ? s3upload : new S3Upload({
    s3_sign_put_url: '/signS3put',
    s3_object_name: makeid(),
    onProgress: function(percent, message) { // Use this for live upload progress bars
      console.log('Upload progress: ', percent, message);
    },
    onFinishS3Put: function(public_url) { // Get the URL of the uploaded file
      console.log('Upload finished: ', public_url);
      trackName = prompt("Enter your track name:");
      sendAjax(public_url);
    },
    onError: function(status) {
      console.log('Upload error: ', status);
    }
  }, blob);
  }

  function sendAjax(url){
    $.ajax({
      type: "POST",
      url: "upload",
      data: JSON.stringify({trackurl:url, beat_id:beatId, track_name: trackName}),
      contentType: "application/json; charset=utf-8",
      dataType: 'json',
      success: function(data){
        window.location.href = data.location;
      }

    });
  }


  function loadTrack(){
      bufferLoader = new BufferLoader(
      context,
      [
        beat
      ],
      bufferTrack
      );
      bufferLoader.load();
    }

  function bufferTrack(bufferList){
    track1 = context.createBufferSource();
    track1.buffer = bufferList[0];
    track1.connect(master);
    track = true;
  }

  function reloadTrack(){
    // bufferLoader.load();
    track1.connect(master);
  }

  function startTrack(){
    track1.start(0, 0);
    myAudio = setInterval(draw, 30);
  }

  function stopTrack(){
    track1.stop(0);
    track1.disconnect();
    clearInterval(myAudio);
    track = false;
    loadTrack();
  }

  function inputAudio(){
    context = new AudioContext || new webkitAudioContext;
    tuna = new Tuna(context);
    navigator.getUserMedia({audio: true}, startUserMedia, function(e) {
      });
  }

  function speakerWay(){
    var freqByteData = new Uint8Array(mySpeakerAnalyser.frequencyBinCount);
    mySpeakerAnalyser.getByteFrequencyData(freqByteData);
    speakertude = freqByteData[1];
  }

  function rightWay(){
    var canvas = document.querySelector('#rightway');
    var ctx = canvas.getContext('2d');
    canvas.width = $('.wrap').width() - 300;
    canvas.height = 300;
    var width = canvas.width;
    var height = canvas.height;
    var bar_width = 10;

    ctx.clearRect(0, 0, width, height);

    var freqByteData = new Uint8Array(myAudioAnalyser.frequencyBinCount);
    myAudioAnalyser.getByteFrequencyData(freqByteData);

    var barCount = Math.round(width / bar_width);
    for (var i = 0; i < barCount; i++) {
        magnitude = freqByteData[i];
        ctx.fillStyle = "hsl(" + color + ", 100%, 50%)";
        ctx.fillRect(bar_width * i, height, bar_width - 2, -magnitude);
    }
  }

  function wrongWay(){
    var canvas = document.querySelector('#wrongway');
    var ctx = canvas.getContext('2d');
    canvas.width = $('.wrap').width() - 300;
    canvas.height = 100;
    var width = canvas.width;
    var height = canvas.height;
    var bar_width = 10;

    ctx.clearRect(0, 0, width, height);

    var freqByteData = new Uint8Array(myAudioAnalyser.frequencyBinCount);
    myAudioAnalyser.getByteFrequencyData(freqByteData);

    var barCount = Math.round(width / bar_width);
    for (var i = 0; i < barCount; i++) {
        var magnitude = freqByteData[i];
        ctx.fillStyle = "hsla(" + color + ", 100%, 50%, 0.4)";
        ctx.fillRect(bar_width * i, 0, bar_width - 2, magnitude / 2);
    }

  }

function makeid()
  {
      var text = "";
      var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

      for( var i=0; i < 8; i++ )
          text += possible.charAt(Math.floor(Math.random() * possible.length));

      return text + '.wav';
  }

  function draw() {
    getColor();
    rightWay();
    wrongWay();
    speakerWay();
    pulse('#pulsel');
    pulse('#pulser');
  }

  function getColor(){
    color = 360 - (speakertude * 1.2);
  }

  function effects() {
    reverb = new tuna.Convolver({
                    highCut: 22050,                         //20 to 22050
                    lowCut: 20,                             //20 to 22050
                    dryLevel: 1,                            //0 to 1+
                    wetLevel: 0.3,                            //0 to 1+
                    level: 1,                               //0 to 1+, adjusts total output of both wet and dry
                    impulse: "../assets/vocal_plate.wav",    //the path to your impulse response
                    bypass: 0
                });
    delay = new tuna.Delay({
                feedback: 0.25,    //0 to 1+
                delayTime: 150,    //how many milliseconds should the wet signal be delayed?
                wetLevel: 0.25,    //0 to 1+
                dryLevel: 1,       //0 to 1+
                cutoff: 20,        //cutoff frequency of the built in highpass-filter. 20 to 22050
                bypass: 0
            });
    compressor = new tuna.Compressor({
                     threshold: -10,    //-100 to 0
                     makeupGain: 10,     //0 and up
                     attack: 1,         //0 to 1000
                     release: 50,        //0 to 3000
                     ratio: 2,          //1 to 20
                     knee: 5,           //0 to 40
                     automakeup: true,  //true/false
                     bypass: 0
                 });
    eq = new tuna.Filter({
                 frequency: 120,         //20 to 22050
                 Q: 1,                  //0.001 to 100
                 gain: -30,               //-40 to 40
                 bypass: 1,             //0 to 1+
                 filterType: 0,         //0 to 7, corresponds to the filter types in the native filter node: lowpass, highpass, bandpass, lowshelf, highshelf, peaking, notch, allpass in that order
                 bypass: 0
             });

    eq2 = new tuna.Filter({
                 frequency: 700,         //20 to 22050
                 Q: 1,                  //0.001 to 100
                 gain: 5,               //-40 to 40
                 bypass: 1,             //0 to 1+
                 filterType: 5,         //0 to 7, corresponds to the filter types in the native filter node: lowpass, highpass, bandpass, lowshelf, highshelf, peaking, notch, allpass in that order
                 bypass: 0
             });

    eq3 = new tuna.Filter({
                 frequency: 3200,         //20 to 22050
                 Q: 1,                  //0.001 to 100
                 gain: 10,               //-40 to 40
                 bypass: 1,             //0 to 1+
                 filterType: 5,         //0 to 7, corresponds to the filter types in the native filter node: lowpass, highpass, bandpass, lowshelf, highshelf, peaking, notch, allpass in that order
                 bypass: 0
             });

    limiter = new tuna.Compressor({
                     threshold: -10,    //-100 to 0
                     makeupGain: 0,     //0 and up
                     attack: 50,         //0 to 1000
                     release: 50,        //0 to 3000
                     ratio: 20,          //1 to 20
                     knee: 5,           //0 to 40
                     automakeup: true,  //true/false
                     bypass: 0
                 });

    distort = new tuna.Overdrive({
                    outputGain: 0,         //0 to 1+
                    drive: 0.1,              //0 to 1
                    curveAmount: 0.05,          //0 to 1
                    algorithmIndex: 2,       //0 to 5, selects one of our drive algorithms
                    bypass: 0
                });

    crazydistort = new tuna.Overdrive({
                    outputGain: 0,         //0 to 1+
                    drive: 0.2,              //0 to 1
                    curveAmount: 0.2,          //0 to 1
                    algorithmIndex: 2,       //0 to 5, selects one of our drive algorithms
                    bypass: 1
                });

    chorus = new tuna.Chorus({
                 rate: 1.5,         //0.01 to 8+
                 feedback: 0.2,     //0 to 1+
                 delay: 0.0045,     //0 to 1
                 bypass: 0          //the value 1 starts the effect as bypassed, 0 or 1
             });

    phaser = new tuna.Phaser({
                 rate: 1.2,                     //0.01 to 8 is a decent range, but higher values are possible
                 depth: 0.3,                    //0 to 1
                 feedback: 0.2,                 //0 to 1+
                 stereoPhase: 30,               //0 to 180
                 baseModulationFrequency: 700,  //500 to 1500
                 bypass: 0
             });

  }



  function recordTrack(user_beat, beat_id, beat_name){
    window.AudioContext = window.AudioContext || window.webkitAudioContext;
    navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia;
    window.URL = window.URL || window.webkitURL;
    beatName = beat_name;
    beatId = beat_id;
    beat = user_beat;
    inputAudio();
    myAudioAnalyser = context.createAnalyser();
    myAudioAnalyser.smoothingTimeConstant = 0.85;
    mySpeakerAnalyser = context.createAnalyser();
    mySpeakerAnalyser.smoothingTimeConstant = 0.85;
  }

  function playTrack(user_track){
    window.AudioContext = window.AudioContext || window.webkitAudioContext;
    beat = user_track;
    context = new AudioContext || new webkitAudioContext;
    master = context.createGainNode();
    master.connect(context.destination);
    loadTrack();
    myAudioAnalyser = context.createAnalyser();
    myAudioAnalyser.smoothingTimeConstant = 0.85;
    mySpeakerAnalyser = context.createAnalyser();
    mySpeakerAnalyser.smoothingTimeConstant = 0.85;
    master.connect(mySpeakerAnalyser);
    master.connect(myAudioAnalyser);

  }

  function pulse(pulse){
    var canvas = document.querySelector(pulse);
    var ctx = canvas.getContext('2d');
    canvas.width = 150;
    canvas.height = 300;

    compColor = color + 180;
    ctx.fillStyle = "hsl(" + compColor + ", 100%, 50%)";
    ctx.fillRect(12,0,120,300);

    ctx.beginPath();
    ctx.arc(75, 170, speakertude / 9, 0, Math.PI*2, true);
    ctx.closePath();

    ctx.strokeStyle = "hsl(" + color + ", 100%, 50%)";
    ctx.lineWidth = 12;
    ctx.stroke();
  }
