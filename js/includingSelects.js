/*
This script must be added after scripts registrationFormValidation.js and regionsDistrictsCities.js
because it uses constant variables 
- from first one: form, passportType, passportSeries, passportID, region, district and city;
- from second one: regions and districts.
*/

var lastPassportTypeValue = '';

var lastRegionValue = '';
var lastDistrictValue = '';


/*
unsetValidStatus drops succes or error feedback for element
*/
function unsetValidStatus(element){
	element.classList.remove("is-valid");
	element.classList.remove("is-invalid");
}


function onSelectPassportType(event){
	var value = passportType.value;

	if (value === lastPassportTypeValue) return;
	lastPassportTypeValue = value;

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


function onSelectRegion(event){
	var value = region.value;

	if (value === lastRegionValue) return;
	lastRegionValue = value;

	unsetValidStatus(district);
	unsetValidStatus(city);
	district.value = '';

	district.removeAttribute('disabled');
	city.setAttribute('disabled', "");
	district.value = '';
	city.value = '';

	district.innerHTML = createOptions(regions.get(value));
}


function onSelectDistrict(event){
	var value = district.value;

	if (value === lastDistrictValue) return;
	lastDistrictValue = value;

	unsetValidStatus(city);

	city.removeAttribute('disabled');
	city.value = '';

	city.innerHTML = createOptions(districts.get(value));
}



region.addEventListener('blur', onSelectRegion);
district.addEventListener('blur', onSelectDistrict);



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