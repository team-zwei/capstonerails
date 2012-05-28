var countdownTimer = function(secondsRemaining, callback) {
  var timeLeft = secondsRemaining;
  var timer;

  var cb = [];

  if (Array.isArray(callback)) {
    cb.concat(callback);
  }
  else {
    cb.push(callback);
  }

  tick();
  timer = setInterval(tick, 1000); // 1000 ms to tick every second.

  function tick() {
    timeLeft -= 1;

    cb(renderTimeString());
  }

  function updateTime(seconds) {
    timeLeft = seconds;
    console.log("time reset to " + seconds + " seconds");
  }

  function renderTimeString() {
    var time = timeLeft;
    var result = "";

    if (time > 0) {
      result += formatNumber(time / 86400)     + ":";
      result += formatNumber(time / 3600)      + ":";
      result += formatNumber((time / 60) % 60) + ":";
      result += formatNumber(time % 60);
    }
    else {
      result = "Ended";
    }
    
    return result;
  }

  function formatNumber(number) {
    result = parseInt(number, 10).toString();
    if (result.length == 1) {
      result = "0" + result;
    }
    return result;
  }

  function pushCallback(callback) {
    cb.push(callback);
  }

  return {
    updateSecondsRemaining: function(newSecondsRemaining) {
      updateTime(newSecondsRemaining);
    },

    addCallback: function(callback) {
      pushCallback(callback);
    }
  };

};


timer['auction1'].addCallback(function(result){
  //do something with result
})