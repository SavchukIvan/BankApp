/*
This script must be added after script registrationFormValidation.js
because it uses constant variables:
form, passportType, passportSeries, passportID, region, district and city
from specified script. Also it uses unsetValidStatus function
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