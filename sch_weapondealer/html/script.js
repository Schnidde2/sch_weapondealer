$ (function() {
    window.addEventListener("message", function (event) {
        if (event.data.action == "showLogo") {
            $("#logo").show();
        };
        if (event.data.action == "hideLogo") {
            $("#logo").hide();
        };
        if (event.data.action == "SetPreis1") {
            setAnzahl(event.data.preis)
            $("#Price1").show();
        };
        if (event.data.action == "SetPreis2") {
            setAnzahl2(event.data.preis)
            $("#Price2").show();
        };
        if (event.data.action == "SetPreis3") {
            setAnzahl3(event.data.preis)
            $("#Price3").show();
        };
    });
});

function display(bool) {
    if (bool) {
        $("#UI").show();
    } else {
        $("#UI").hide();
    }
    $.post('http://sch_weapondealer/exit', JSON.stringify({}));
            return
}

function BuyWeapon1() {
    $.post('https://sch_weapondealer/BuyWeapon1', JSON.stringify({}));
}

function BuyWeapon2() {
    $.post('https://sch_weapondealer/BuyWeapon2', JSON.stringify({}));
}

function BuyWeapon3() {
    $.post('https://sch_weapondealer/BuyWeapon3', JSON.stringify({}));
}

$(function () {
    function display(bool) {
        if (bool) {
            $("#UI").show();
        } else {
            $("#UI").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://sch_weapondealer/exit', JSON.stringify({}));
            return
        }
    };
});

function setAnzahl(anzahl) {
    document.getElementById("Price1").innerHTML = new Intl.NumberFormat('de-DE').format(anzahl) + "$";
}

function setAnzahl2(anzahl) {
    document.getElementById("Price2").innerHTML = new Intl.NumberFormat('de-DE').format(anzahl) + "$";
}

function setAnzahl3(anzahl) {
    document.getElementById("Price3").innerHTML = new Intl.NumberFormat('de-DE').format(anzahl) + "$";
}