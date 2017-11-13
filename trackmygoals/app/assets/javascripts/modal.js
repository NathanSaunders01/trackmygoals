$(document).on('shown.bs.modal', '.modal', function() {
  $(this).find('[autofocus]').focus();
});