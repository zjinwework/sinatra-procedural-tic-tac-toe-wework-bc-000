// We setup a variable to keep track of the lastMove they make.
// We'll use this below to erase their last move if they make a new move
// without submitting.
var lastMove;

$(function(){ // When the document is ready, we add the following behavior.
  $("input:text").on("change", function(e){  // Whenever an input is changed.
    // If they have already made a move during this turn
    if (lastMove){
      $("input[name='"+lastMove+"']").val("") // We erase their last move.
    }
    lastMove = $(this).attr("name")  // Keep track of this move as the lastMove

    // Use the currentToken variable to set the correct token for the player.
    $(this).val(currentToken)

    // Don't allow the input to change it's value otherwise.
    e.preventDefault()
  })
  // $("input:text").hover(function(){
  //   $(this).focus()
  // }, function(){
  //   $(this).blur()
  // })
})
