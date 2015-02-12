$(document).ready(function(){

  $("button.add-grain").show();
  
  // hide additional non-blank input fields
  $(".grain").each( function(index, grainElement){
    var grainInputs = $(grainElement).find("input");
    var inputsAreBlank = true;
    $(grainInputs).each( function(i, grainInput){
      if ( $(grainInput).val() ){ inputsAreBlank = false; }
    });
    if(index > 0 && inputsAreBlank){
      $(grainElement).hide();
    } else if (index > 0) {
      $(grainElement).prev(".grain").find("button.add-grain").hide();
      // Only show button for last non-blank input
    }
   });

  $("button.add-grain").on("click", function(event) {
    event.preventDefault();
    $(this).parent(".grain").next(".grain").show();
    $(this).hide();
  });
});