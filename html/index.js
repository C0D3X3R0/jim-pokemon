$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }



    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        var card = item.card;

        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
                
                document.getElementById("thecard").src = 'backcard.png'
                setTimeout(() => {  document.getElementById("thecard").src = card }, 2000);
                setTimeout(() => {  $.post('http://qb-pokemonv2/main', JSON.stringify({}));return;}, 6000);

            } else {
                display(false)
            }
        } else {
                display(true)
                document.getElementById("thecard").src = card
        }









    //when the user clicks on the submit button, it will run
    $("#button").click(function () {
        
        $.post('http://qb-pokemonv2/main', JSON.stringify({
        }));
        return;
    })


    })
    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://qb-pokemonv2/exit', JSON.stringify({}));
            return
        }
    };
    document.onkeyup = function (data) {
        data = data || window.event;
        var charCode = data.keyCode || data.which;
        if (charCode == 8 || charCode == 27) { // Nui hide key backspace
          $.post(`https://qb-pokemonv2/exit`, JSON.stringify({}));
          display(false)
          return
        }};
        

})