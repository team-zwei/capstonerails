var countdownTimer = function(secondsRemaining, callback) {
  var timeLeft = secondsRemaining;
  var timer;

  var cb = callback;

  function init() {
    tick();
    timer = setInterval("tick()", 1000); // 1000 ms to tick every second.
  }

  function tick(cb) {
    timeLeft -= 1;
    cb(renderTimeString());
  }

  function updateTime(seconds) {
    timeLeft = seconds;
  }

  function renderTimeString() {
    var time = timeLeft;
    var result = "";
    result += parseInt(time / 86400).toString();
    result += parseInt(time / 3600).toString();
    result += parseInt((time / 60) % 60).toString();
    result += parseInt(time % 60).toString();
    return result;
  }

  return {
    updateSecondsRemaining: function(newSecondsRemaining) {
      updateTime(newSecondsRemaining)
    }
  }

}