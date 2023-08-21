// document.addEventListener('DOMContentLoaded', function() {
//   var calendarEl = document.getElementById('calendar');
//   var calendar = new FullCalendar.Calendar(calendarEl, {

//       headerToolbar: {
//           left: 'today',
//           center: 'prev title next',
//           right: 'dayGridMonth,timeGridWeek,timeGridDay'
//       },
//       selectable: true,
//       droppable: true,
//       selectHelper: true,
//       editable: true,
//       eventLimit:true,
//       events: '/assigned_tasks.json',
//       select: function (start, end){
//           $.getScript('/assigned_tasks/news',function(){
//               $('#event_date_range').val(moment(start).format("MM/DD/YYYY HH:mm") + ' - ' + moment(end).format("MM/DD/YYYY HH:mm"))
//               date_picker();
//               $('.start_hidden').val(moment(start).format('YYYY-MM-DD HH:mm'));
//               $('.end_hidden').val(moment(end).format('YYYY-MM-DD HH:mm'));
//           });
//           calendar.fullCalendar('unselect');
//       },
//       eventDrop: function (assigned_task, delta, revertFunc) {
//            assigned_task_data = {
//               assigned_task: {
//                   id: assigned_task.id,
//                   start_time: assigned_task.start_time.format(),
//                   end_time: assigned_task.end_time.format()
//               }

//           };
//           $.ajax({
//               url: assigned_task.update_url,
//               data: assigned_task_data,
//               type: 'PATCH'
//           });
//       },
//       eventClick: function (assigned_task, jsEvent, view){
//           alert();


//       },
//       initialView: 'dayGridMonth'
//   });
//   calendar.render();
// });