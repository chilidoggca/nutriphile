var userIdCalendar = $('#calendar').data('userid');
$('#calendar').fullCalendar({
  events: `/users/${userIdCalendar}/diaries.json`,
});
