$(document).ready(function(){
  $('#affiliation_selector').change(function(e,v) {
    var selectedValue = $("select option:selected").first().val();
  
    if ( selectedValue == 'Other' ) {
      $('#affiliation').show();
    } else {
      $('#registrant_affiliation').val(selectedValue);
    }
  });
});