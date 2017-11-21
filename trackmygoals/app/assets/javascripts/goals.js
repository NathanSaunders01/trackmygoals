function openTab(evt, tabName) {
    // Declare all variables
    var i, tabcontent, tablinks;

    // Get all elements with class="tabcontent" and hide them
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }

    // Get all elements with class="tablinks" and remove the class "active"
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }

    // Show the current tab, and add an "active" class to the button that opened the tab
    document.getElementById(tabName).style.display = "block";
    evt.currentTarget.className += " active";
}

function openSecTab(evt, tabName) {
    // Declare all variables
    var i, tabcontentsec, tablinkssec;

    // Get all elements with class="tabcontent" and hide them
    tabcontentsec = document.getElementsByClassName("tabcontentsec");
    for (i = 0; i < tabcontentsec.length; i++) {
        tabcontentsec[i].style.display = "none";
    }

    // Get all elements with class="tablinks" and remove the class "active"
    tablinkssec = document.getElementsByClassName("tablinkssec");
    for (i = 0; i < tablinkssec.length; i++) {
        tablinkssec[i].className = tablinkssec[i].className.replace(" active", "");
    }

    // Show the current tab, and add an "active" class to the button that opened the tab
    document.getElementById(tabName).style.display = "block";
    evt.currentTarget.className += " active";
}

// function openChartTab(evt, tabName) {
// // Declare all variables
// var i, tabcontentchart, tablinkschart;

// // Get all elements with class="tabcontent" and hide them
// tabcontentchart = document.getElementsByClassName("tabcontent-chart");
// for (i = 0; i < tabcontentchart.length; i++) {
//     tabcontentchart[i].style.display = "none";
// }

// // Get all elements with class="tablinks" and remove the class "active"
// tablinkschart = document.getElementsByClassName("tablinks-chart");
// for (i = 0; i < tablinkschart.length; i++) {
//     tablinkschart[i].className = tablinkschart[i].className.replace(" active", "");
// }

// // Show the current tab, and add an "active" class to the button that opened the tab
// document.getElementById(tabName).style.display = "block";
// evt.currentTarget.className += " active";
// }