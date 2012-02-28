var countdownTimer = function(secondsRemaining, callback) {
  var timer;
  var timeLeft = secondsRemaining;

  init();

  function init() {
    tick();
    timer = setInterval(tick, 1000); // 1000 ms to tick every second.
  }

  function tick() {
    decrementTime();
    callback(renderTimeString());
  }

  function decrementTime() { timeLeft -= 1; }

  function updateTime(seconds) {
    timeLeft = seconds;
    tick();
  }

  function renderTimeString() {
    var time = timeLeft;
    return formatNumber(time / 86400)+ ":" + formatNumber(time / 3600) + ":"
          + formatNumber((time / 60) % 60) + ":" + formatNumber(time % 60);
  }

  function formatNumber(number) {
    result = parseInt(number).toString();
    if (result.length == 1) { result = "0" + result; }
    return result;
  }

  return {
    updateSecondsRemaining: function(newSecondsRemaining) { 
      updateTime(newSecondsRemaining);
    }
  }
}

var timers = {};

$('.auction_thumbnail').each(function(){
  var id = $(this).parent().attr('id')
  var time_elem = $('#' + id + " .auction_thumbnail_time");
  timers[id + "_timer"] = countdownTimer(time_elem.attr('data-time-remaining'), function(result){
    time_elem.text(result);
  });
});