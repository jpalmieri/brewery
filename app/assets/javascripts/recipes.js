$(document).ready(function(){
  
  // hide additional non-blank input fields
  $(".grain").each( function(index, grainElement){
    var grainInputs = $(grainElement).find("input");
    var inputsAreBlank = true;
    $(grainInputs).each( function(i, grainInput){
      if ( $(grainInput).val() ){ inputsAreBlank = false; }
    });
    if(index > 0 && inputsAreBlank){
      $(grainElement).hide();
    }
  });

  var show_last_add_grain_button = function(){
    $('.grain').filter( function(){ 
      if($(this).css('display') == "block") {
        return $(this);
      }
    }).last().find('button.add-grain').show();
  };
  show_last_add_grain_button();

  $("button.add-grain").on("click", function(event) {
    event.preventDefault();
    $(this).parent(".grain").nextAll(".grain").first().show();
    $(this).hide();
    show_last_add_grain_button();
  });
});