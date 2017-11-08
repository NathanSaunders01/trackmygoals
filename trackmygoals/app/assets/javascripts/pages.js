$(document).ready(function(){
  $('.alert').delay(1000).fadeOut(4000);
  document.getElementById("defaultOpen").click();
});

window.onload = function(){ 
  var acc = document.getElementById("profile");
  var list = document.getElementById("profile-links")

  acc.onclick = function(){
    if (list.style.maxHeight) {
        list.style.maxHeight = null;
    } else {
        list.style.maxHeight = list.scrollHeight + "px";
    }
  }
}