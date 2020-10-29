-- файл присвячений написанню тригерів на мові plpgsql

-- цей тригер присвячений валідації мобільного номеру користувача

-- для створення тригеру спочатку потрібно створити функцію
-- валідації яка прив'язана до тригера
CREATE OR REPLACE FUNCTION check_client_data()
  RETURNS TRIGGER
  AS
$$
BEGIN
	IF NEW.Phone !~'^\+?3?8?(0[5-9][0-9]\d{7})$'
	THEN
		RAISE EXCEPTION 'Wrong phone number format: %', NEW.Phone
        	USING HINT = 'Please check your phone number format. It must be ukranian.(ex: +380951809212)';
	END IF;
	
	IF NEW.IPN !~'^\d{10}$|^\d{12}?$'
	THEN
		RAISE EXCEPTION 'This IPN is not valid: %', NEW.IPN
        	USING HINT = 'Check IPN formating. It must contain only 10 or 12 digits.';
	END IF;
	
	IF NEW.PassportType NOT IN ('book', 'card')
	THEN
		RAISE EXCEPTION 'Passport type cannot be: %', NEW.PassportType
        	USING HINT = 'It can be only "book" or "card"';
	END IF;
	
	IF ((NEW.PassportType = 'book' AND NEW.PassportID !~'^[АБВГҐДЕЄЖЗИІЇЙКЛМНОПРСТУФХЦЧШЩЬЮЯ]{2}\d{6}$')
		 OR (NEW.PassportType = 'card' AND NEW.PassportID !~'^\d{9}$'))
	THEN
		RAISE EXCEPTION 'Passport ID and PassportID dont match, or PassportID is not valid: %', NEW.PassportID
        	USING HINT = 'Please check your passport formating.';
	END IF;
	
	RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';

-- після створення функції валідації створюється сам тригер
-- в його тілі йде виклик функції
CREATE TRIGGER check_client
	BEFORE INSERT ON Client
    FOR EACH ROW
    EXECUTE FUNCTION check_client_data();


CREATE OR REPLACE FUNCTION check_card_data()
  RETURNS TRIGGER
  AS
$$
BEGIN
	IF NEW.CardID !~'^\d{16}$'
	THEN
		RAISE EXCEPTION 'Wrong card number format: %', NEW.CardID
        	USING HINT = 'Please check your card number format. It must contain 16 digits';
	END IF;
	
	IF NEW.Pin !~'^\d{4}$'
	THEN
		RAISE EXCEPTION 'This Pin is not valid: %', NEW.Pin
        	USING HINT = 'Check Pin formating. It must contain only 4 digits.';
	END IF;
	
	IF NEW.CVV !~'^\d{3}$'
	THEN
		RAISE EXCEPTION 'This CVV is not valid: %', NEW.CVV
        	USING HINT = 'Check CVV formating. It must contain only 3 digits.';
	END IF;
	
	IF NEW.ReleaseDate >= NEW.ValidityDate
	THEN
		RAISE EXCEPTION 'Release date is later than validity date: %', NEW.ReleaseDate
        	USING HINT = 'Validity date must be bigger than release date';
	END IF;
	
	IF NEW.CreditLimit < 0
	THEN
		RAISE EXCEPTION 'Credit limit is not valid: %', NEW.CreditLimit
        	USING HINT = 'Credit limit cannot be less than zero.';
	END IF;
	
	IF NEW.Bonuses < 0
	THEN
		RAISE EXCEPTION 'Bonuses is not valid: %', NEW.Bonuses
        	USING HINT = 'Bonuses cannot be less than zero.';
	END IF;
	
	RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER check_card
	BEFORE INSERT ON Card
    FOR EACH ROW
    EXECUTE FUNCTION check_card_data();


-- тут створюється функція для перевірки емейлу
CREATE OR REPLACE FUNCTION check_email()
  RETURNS TRIGGER
  AS
$$
BEGIN
	IF NEW.UserLogin !~'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'
	THEN
		RAISE EXCEPTION 'Wrong phone email format: %', NEW.UserLogin
        	USING HINT = 'Please check your email format.';
	END IF;
	
	RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';

-- тригер для перевірки емейлу
CREATE TRIGGER email_check
	BEFORE INSERT ON UserLogins
    FOR EACH ROW
    EXECUTE FUNCTION check_email();

-- тут створюється функція для перевірки IBAN формату
CREATE OR REPLACE FUNCTION check_iban()
  RETURNS TRIGGER
  AS
$$
BEGIN
	IF NEW.AccountID !~'^([A-Z]{2}[ \-]?[0-9]{2})(?=(?:[ \-]?[A-Z0-9]){9,30}$)((?:[ \-]?[A-Z0-9]{3,5}){2,7})([ \-]?[A-Z0-9]{1,3})?$'
	THEN
		RAISE EXCEPTION 'AccountID dont match IBAN standart: %', NEW.AccountID
        	USING HINT = 'Please check your IBAN formating.';
	END IF;
	
	RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';

-- тригер для перевірки IBAN
CREATE TRIGGER iban_check
	BEFORE INSERT ON ClientAccLog
    FOR EACH ROW
    EXECUTE FUNCTION check_iban();
