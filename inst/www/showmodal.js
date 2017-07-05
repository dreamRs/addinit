$(function() {
  Shiny.addCustomMessageHandler('ShowModal',
                                function(value) {
                                  console.log($("#"+value.eltID).modal('show'));
                                  $("#"+value.eltID).modal('show');
                                  $('.modal-backdrop').remove();
                                });
});

