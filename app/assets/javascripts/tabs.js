$(document).on('shown.bs.tab', function() {
  window.dispatchEvent(new Event('resize'));
});