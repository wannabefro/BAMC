const SOUNDS = ['kick', 'snare', 'hihat_open', 'hihat_closed'];

var context, path;

function beatMaker(location){
  path = location;
  window.AudioContext = window.AudioContext || window.webkitAudioContext;
  context = new AudioContext;
  master = context.createGainNode();
  master.connect(context.destination);

  fetchSounds();
}

function fetchSounds(){
  for (var i = 0, len = SOUNDS.length; i < len; i++){
    loadSample(SOUNDS[i]);
  }
}

function loadSample(sound){
    bufferLoader = new BufferLoader(
    context,
    [
      path + sound + '.wav'
    ],
    bufferSample
    );
    bufferLoader.load();
  }

function bufferSample(bufferList){
  sound = context.createBufferSource();
  sound.buffer = bufferList[0];
  sound.connect(master);

}
