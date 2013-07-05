var context, recorder, input, master, bufferLoader, track1, track, myAudioAnalyser, mySpectrum,
            tuna, reverb, color, user_beat, beatId, beatName;


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
      // sendAjax(blob, url, beatId);
      sendS3(blob);



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

  function sendS3(blob){
    var s3upload = s3upload != null ? s3upload : new S3Upload({
    s3_sign_put_url: '/signS3put',
    s3_object_name: makeid(),
    onProgress: function(percent, message) { // Use this for live upload progress bars
      console.log('Upload progress: ', percent, message);
    },
    onFinishS3Put: function(public_url) { // Get the URL of the uploaded file
      console.log('Upload finished: ', public_url);
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
      data: JSON.stringify({trackurl:url, beat_id:beatId}),
      contentType: "application/json; charset=utf-8",
      dataType: 'json'
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
    mySpectrum = setInterval(drawSpectrum, 30);

  }

  function stopTrack(){
    track1.stop(0);
    track1.disconnect();
    clearInterval(mySpectrum);
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
    canvas.width = $(window).width();
    canvas.height = 200;
    var width = canvas.width;
    var height = canvas.height;
    var bar_width = 10;

    ctx.clearRect(0, 0, width, height);

    var freqByteData = new Uint8Array(myAudioAnalyser.frequencyBinCount);
    myAudioAnalyser.getByteFrequencyData(freqByteData);

    var barCount = Math.round(width / bar_width);
    for (var i = 0; i < barCount; i++) {
        var magnitude = freqByteData[i];
        ctx.fillStyle = "hsl(" + color + ", 100%, 50%)";
        ctx.fillRect(bar_width * i, height, bar_width - 2, -magnitude);
    }
  }

  function wrongWay(){
    var canvas = document.querySelector('#wrongway');
    var ctx = canvas.getContext('2d');
    canvas.width = $(window).width();
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

      for( var i=0; i < 5; i++ )
          text += possible.charAt(Math.floor(Math.random() * possible.length));

      return beatName + '_' + text;
  }

  function drawSpectrum() {
    getMouse();
    rightWay();
    wrongWay();
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
  }

  function inputForm(blob){
    $('#track_track').value = blob;
  }
