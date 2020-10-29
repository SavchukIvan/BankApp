/*
This script must be added after scripts registrationFormValidation.js and regionsDistrictsCities.js
because it uses constant variables 
- from first one:
	form, passportType, passportSeries, passportID, region, district and city.
	Also it uses unsetValidStatus function
- from second one:
	regions and districts
*/

var lastPassportType = '';

function onSelectPassportType(event){
	var value = passportType.value;

	if (value === lastPassportType) return;
	lastPassportType = value;

	unsetValidStatus(passportSeries);
	unsetValidStatus(passportID);
	passportID.value = '';
	passportSeries.value = '';
	
	if (value === 'book'){
		passportID.setAttribute('maxlength', '6')
		if (passportSeries.hasAttribute('disabled')) passportSeries.removeAttribute('disabled');
		if (passportID.hasAttribute('disabled')) passportID.removeAttribute('disabled');
	}
	else if (value === 'card'){
		passportID.setAttribute('maxlength', '9')
		if (!passportSeries.hasAttribute('disabled')) passportSeries.setAttribute('disabled', '');
		if (passportID.hasAttribute('disabled')) passportID.removeAttribute('disabled');
	}
}

passportType.addEventListener('blur', onSelectPassportType);


function createOptions(options, defaultOptionText="Обрати..."){
	var selectInner = "<option selected disabled value=\"\">"+defaultOptionText+"</option>";
	var option;

	for (var i = 0; i < options.length; i++){
		option = options[i];
		selectInner = selectInner+"\n"+"<option value=\""+option+"\">"+option+"</option>";
	}
	return selectInner;
}


region.innerHTML = createOptions(Array.from(regions.keys()));