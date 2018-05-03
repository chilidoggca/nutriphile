var userIdCalendar = $('#calendar').data('userid');
$('#calendar').fullCalendar({
  events: `/users/${userIdCalendar}/diaries.json`,
  dayClick: function(date, jsEvent, view) {
    window.location.href =
      `http://localhost:3000/date?utf8=&calendar_date=${date.format()}`
  }
});
