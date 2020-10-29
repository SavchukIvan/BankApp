-- це файл присвячено створенню таблиць БД
-- ця таблиця присвячена акаунту клієнта
CREATE TABLE ClientAccLog(
	AccountID varchar(80) PRIMARY KEY,
	AccountStatus varchar(40) NOT NULL
);

-- ця таблиця потрібна для збереження інформації про користувача
CREATE TABLE UserLogins(
	UserLogin varchar(40) PRIMARY KEY,
	UserPassword varchar(40) NOT NULL,
	UserSecurityAnswer varchar(40) NOT NULL,
	UserSecurityQuestion varchar(80) NOT NULL,
	AccountID varchar(80),
	FOREIGN KEY(AccountID)
		REFERENCES ClientAccLog (AccountID)
);

-- інформація про клієнта зберігається тут
CREATE TABLE Client(
	ClientID serial PRIMARY KEY,
	AccountID varchar(40),
	FirstName varchar(40) NOT NULL,
	LastName varchar(40) NOT NULL,
	City varchar(40) NOT NULL,
	Region varchar(40),
	PassportType varchar(40) NOT NULL,
	PassportID varchar(40) UNIQUE NOT NULL,
	IPN varchar(40) UNIQUE NOT NULL,
	Phone varchar(40) UNIQUE NOT NULL,
	FOREIGN KEY(AccountID)
		REFERENCES ClientAccLog (AccountID)
);

--  банківська інформація про картки клієнтів
--  зберігається тут
CREATE TABLE CardInfo(
	CardType varchar(40) PRIMARY KEY,
	BonusCoef real NOT NULL,
	CreditLimit real NOT NULL
);

-- інформація про картки клієнтів збережена тут
CREATE TABLE Card(
	CardID varchar(40) PRIMARY KEY,
	Pin varchar(10) NOT NULL,
	CVV varchar(10) NOT NULL,
	CardType varchar(40) NOT NULL,
	Tariff varchar(40) NOT NULL,
	Status varchar(40) NOT NULL,
	ReleaseDate timestamp NOT NULL,
	ValidityDate timestamp NOT NULL,
	MoneyAmount real NOT NULL,
	CreditLimit real NOT NULL,
	Bonuses real NOT NULL,
	AccountID varchar(80),
	FOREIGN KEY (CardType)
		REFERENCES CardInfo (CardType),
	FOREIGN KEY (AccountID)
		REFERENCES ClientAccLog (AccountID)
);

-- банківська інформація про транзакції зберігається тут
CREATE TABLE TransInfo(
	TransactionType varchar(80) PRIMARY KEY,
	ComissionCoef real NOT NULL
);

-- вся інформація в системі про транзакції в системі зберігається тут
CREATE TABLE Transaction(
	TransactionID bigserial PRIMARY KEY,
	CardID varchar(40),
	CardIdReciever varchar(40) NOT NULL,
	InitialSum real NOT NULL,
	ComissionSum real NOT NULL,
	BonusesUsed real NOT NULL,
	TotalSum real NOT NULL,
	BonusesReсieved real NOT NULL,
	TransDateTime timestamp NOT NULL,
	TransactionType varchar(80),
	FOREIGN KEY (CardID)
		REFERENCES Card (CardID),
	FOREIGN KEY (TransactionType)
		REFERENCES TransInfo (TransactionType)
);











