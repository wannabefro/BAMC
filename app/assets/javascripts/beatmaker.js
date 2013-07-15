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
  loadInitialSample(SOUNDS[i]);
  }
}

function loadInitialSample(sound){
    currentSound = sound;
    bufferLoader = new BufferLoader(
    context,
    [
      path + sound + '.wav'
    ],
    bufferInitSample
    );
    bufferLoader.load();
  }

function bufferInitSample(bufferList){
  currentSound = context.createBufferSource();
  currentSound.buffer = bufferList[0];
  currentSound.connect(master);
}


function loadSample(sound){
    currentSound = sound;
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
  currentSound = context.createBufferSource();
  currentSound.buffer = bufferList[0];
  currentSound.connect(master);
  currentSound.start(0);
}

function playSound(button){
  loadSample(button.id);
}

function mpc_keyUp(e) {


    if (e.keyCode == 90) {
        document.getElementById("kick").click();
    } else if (e.keyCode == 88) {
        document.getElementById("snare").click();
    } else if (e.keyCode == 67 ){
        document.getElementById("hihat_closed").click();
    } else if (e.keyCode == 86) {
        document.getElementById("hihat_open").click();
    }
    return true;
}

document.addEventListener('keyup', mpc_keyUp, false);
