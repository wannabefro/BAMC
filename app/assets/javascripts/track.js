var context, recorder, input, master, bufferLoader, track1, track, myAudioAnalyser, my,
            tuna, reverb, color, user_beat, magnitude;


  function startUserMedia(stream) {
    effects();
    master = context.createGainNode();
    master.connect(context.destination);
    input = context.createMediaStreamSource(stream);
    input.connect(reverb.input);
    reverb.connect(master);
    loadTrack();
    recorder = new Recorder(master);
    input.connect(myAudioAnalyser);
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
  }

  function stopRecording(button) {
    recorder && recorder.stop();
    button.disabled = true;
    button.previousElementSibling.disabled = false;

    master.gain.value = 0;
    createPlaybackLink();
    stopTrack();
    recorder.clear();
  }

  function createPlaybackLink() {
    recorder && recorder.exportWAV(function(blob){
      var url = URL.createObjectURL(blob);
      var li = document.createElement('li');
      var au = document.createElement('audio');
      inputForm(blob);
      // var hf = document.createElement('a');

      au.controls = true;
      au.src = url;
      // hf.href = url;
      // hf.download = new Date().toISOString() + '.wav';
      // hf.innerHTML = hf.download;
      li.appendChild(au);
      // li.appendChild(hf);
      recordslist.appendChild(li);
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
    my = setInterval(draw, 30);
  }

  function stopTrack(){
    track1.stop(0);
    track1.disconnect();
    clearInterval(my);
    track = false;
    loadTrack();
  }

  function inputAudio(){
    context = new AudioContext;
    tuna = new Tuna(context);
    navigator.getUserMedia({audio: true}, startUserMedia, function(e) {
      });
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

  function draw() {
    getMouse();
    rightWay();
    wrongWay();
    drawSpeakers();
  }

  function getMouse(){
    $(document).mousemove(function(e){
      color = (e.pageX / $(window).width()) * 360;
    });
  }

  function effects() {
    reverb = new tuna.Convolver({
                    highCut: 22050,                         //20 to 22050
                    lowCut: 20,                             //20 to 22050
                    dryLevel: 1,                            //0 to 1+
                    wetLevel: 0.2,                            //0 to 1+
                    level: 1,                               //0 to 1+, adjusts total output of both wet and dry
                    impulse: "../assets/vocal_plate.wav",    //the path to your impulse response
                    bypass: 0
                });
  }



  function recordTrack(user_beat){
    window.AudioContext = window.AudioContext || window.webkitAudioContext;
    navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia;
    window.URL = window.URL || window.webkitURL;
    beat = user_beat;
    inputAudio();
    myAudioAnalyser = context.createAnalyser();
    myAudioAnalyser.smoothingTimeConstant = 0.85;
  }

  function inputForm(blob){
    console.log(blob);
  }


  function speakerL(){
    var canvas = document.querySelector('#speakerl');
    var ctx = canvas.getContext('2d');
    canvas.width = 150;
    canvas.height = 300;

    ctx.beginPath();
    ctx.arc(70, 150, 35, 0, Math.PI*2, true);
    ctx.closePath();

    ctx.lineWidth = magnitude / 3;
    ctx.strokeStyle = '#8146d9';
    ctx.stroke();
  }

  function speakerR(){
    var canvas = document.querySelector('#speakerr');
    var ctx = canvas.getContext('2d');
    canvas.width = 150;
    canvas.height = 300;

    ctx.beginPath();
    ctx.arc(80, 150, 35, 0, Math.PI*2, true);
    ctx.closePath();

    ctx.lineWidth = magnitude / 3;
    ctx.strokeStyle = '#8146d9';
    ctx.stroke();
  }

  function drawSpeakers() {
    speakerL();
    speakerR();
  }
