function openNav() {
    document.getElementById("mySidenav").style.width = "15%";
    document.getElementById("full-sidebar").style.width = "15%";
    document.getElementById("main").style.marginLeft = "15%";
    document.getElementById("openNav").style.marginLeft = "115%";
    document.getElementById("openNav").style.display = "none";
    document.getElementById("closeNav").style.display = "inline-block";
}

/* Set the width of the side navigation to 0 and the left margin of the page content to 0, and the background color of body to white */
function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
    document.getElementById("full-sidebar").style.width = "0";
    document.getElementById("main").style.marginLeft = "0";
    document.getElementById("openNav").style.display = "inline-block";
    document.getElementById("closeNav").style.display = "none";
}