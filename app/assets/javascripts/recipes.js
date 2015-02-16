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

  $("button.add-grain").show();

  $("button.add-grain").on("click", function(event) {
    event.preventDefault(); 
    $(this).parent(".grain-list").find(".grain").not(":visible").first().show();
  });
});