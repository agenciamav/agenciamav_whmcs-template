// Password Strength Meter
function passwordStrength(pw) {
	var pwlength = pw.length;
	if(pwlength>5)pwlength=5;
	var numnumeric=pw.replace(/[0-9]/g,"");
	var numeric=(pw.length-numnumeric.length);
	if(numeric>3)numeric=3;
	var symbols=pw.replace(/\W/g,"");
	var numsymbols=(pw.length-symbols.length);
	if(numsymbols>3)numsymbols=3;
	var numupper=pw.replace(/[A-Z]/g,"");
	var upper=(pw.length-numupper.length);
	if(upper>3)upper=3;
	var pwstrength=((pwlength*10)-20)+(numeric*10)+(numsymbols*15)+(upper*10);
	if(pwstrength<0){pwstrength=0}
	if(pwstrength>100){pwstrength=100}
	return pwstrength;
}

// READY
$(function(){
	// tooltips
	$('a[rel=tooltip]').tooltip();

	// toggle checkboxes
	$('.toggle-checkboxes').change( function() {
		var target = $(this).data().target;
		$(target).attr('checked', this.checked).change();
	});

	// Language Selector Styling fix
	$('#languagefrm').addClass('form-inline');

	
	// STYLE TITLES	
	// $.each( $('h1, h2, h3, h4, h5, h6'), function(index, val){		
	//     var node = $(this).contents().filter(function () { return this.nodeType == 3 }),
	//         text = node.text(),
	//         first = text.slice(0, text.indexOf(" "));   
	//     if (!node.length)
	//         return;
	//     node[0].nodeValue = text.slice(first.length);
	//     node.before('<span>' + first + '</span>');
	// });
	
});

