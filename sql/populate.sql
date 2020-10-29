-- вставка рядків в ClientAccLog
-- Valid
-- INSERT INTO ClientAccLog(AccountID, AccountStatus)
-- VALUES ('UA234567289123567819236784567', 'active');

-- INSERT INTO ClientAccLog(AccountID, AccountStatus)
-- VALUES (83737848348989, 'active');

-- INSERT INTO ClientAccLog(AccountID, AccountStatus)
-- VALUES (97483738297282, 'active');

-- INSERT INTO ClientAccLog(AccountID, AccountStatus)
-- VALUES (37428433889924, 'active');

-- INSERT INTO ClientAccLog(AccountID, AccountStatus)
-- VALUES (34345453223236, 'active');

-- вставка рядків в UserLogins
-- INSERT INTO UserLogins(UserLogin, UserPassword, UserSecurityAnswer, UserSecurityQuestion, AccountId)
-- VALUES ('mario@gmail.com', 'jehfie2', 'Reid', 'Mothers Surname', 12312312433423);

-- INSERT INTO UserLogins(UserLogin, UserPassword, UserSecurityAnswer, UserSecurityQuestion, AccountId)
-- VALUES ('nicola@gmail.com', 'rifie3456', 'Grey', 'Mothers Surname', 83737848348989);

-- INSERT INTO UserLogins(UserLogin, UserPassword, UserSecurityAnswer, UserSecurityQuestion, AccountId)
-- VALUES ('luka@gmail.com', '34387bvbsdf', 'Griffith', 'Mothers Surname', 97483738297282);

-- INSERT INTO UserLogins(UserLogin, UserPassword, UserSecurityAnswer, UserSecurityQuestion, AccountId)
-- VALUES ('boban@gmail.com', 'enfiwn333', 'Perri', 'Mothers Surname', 37428433889924);

-- INSERT INTO UserLogins(UserLogin, UserPassword, UserSecurityAnswer, UserSecurityQuestion, AccountId)
-- VALUES ('goran@gmail.com', 'efnkemf233', 'Labeau', 'Mothers Surname', 34345453223236);

-- вставка рядків в Client
-- Valid
-- INSERT INTO Client(ClientID, AccountID, FirstName, LastName, City, Region, PassportType, PassportID, IPN, Phone)
-- VALUES (DEFAULT, 'UA234567289123567819236784567', 'Mario', 'Manjukic', 'Kyiv', NULL, 'book', 'ТТ655678', '1234567890', '+380501601805');

-- INSERT INTO Client(ClientID, AccountID, FirstName, LastName, City, PassportID, IPN, Phone)
-- VALUES (DEFAULT, 83737848348989, 'Nicola', 'Jokic', 'Lviv', 32424343432, 4567898765678223, '+3805046764564');

-- INSERT INTO Client(ClientID, AccountID, FirstName, LastName, City, PassportID, IPN, Phone)
-- VALUES (DEFAULT, 97483738297282, 'Luka', 'Doncic', 'Kharkiv', 48343848343, 98765434567897654, '+380509972822');

-- INSERT INTO Client(ClientID, AccountID, FirstName, LastName, City, PassportID, IPN, Phone)
-- VALUES (DEFAULT, 37428433889924, 'Boban', 'Marjanovic', 'Odessa', 43424334324, 2345654344534344, '+38050344355');

-- INSERT INTO Client(ClientID, AccountID, FirstName, LastName, City, PassportID, IPN, Phone)
-- VALUES (DEFAULT, 34345453223236, 'Goran', 'Dragic', 'Dnipro', 987654567765, 6543345632434, '+3805098432113');

-- вставка рядків в СardsInfo
-- INSERT INTO CardInfo (CardType, BonusCoef, CreditLimit)
-- VALUES ('Debit', 0.001, 1000);

-- INSERT INTO CardInfo (CardType, BonusCoef, CreditLimit)
-- VALUES ('Credit', 0.001, 1000);

-- вставка рядків в Card
-- Valid
-- INSERT INTO Card (CardID, Pin, CVV, CardType, Tariff, Status, ReleaseDate, ValidityDate, MoneyAmount, CreditLimit, Bonuses, AccountID)
-- VALUES ('1234567890123456', '3215', '241', 'Debit', 'basic', 'active', '23.10.2020', '23.10.2025', 0, 1000, 0, 'UA234567289123567819236784567');

-- INSERT INTO Card (CardID, Pin, CVV, CardType, Tariff, Status, ReleaseDate, ValidityDate, CreditLimit, Bonuses, AccountID)
-- VALUES (98765434567876, 9876, 044, 'Credit', 'prime', 'active', '23.10.2020', '23.10.2025', 1000, 0, 83737848348989);

-- INSERT INTO Card (CardID, Pin, CVV, CardType, Tariff, Status, ReleaseDate, ValidityDate, CreditLimit, Bonuses, AccountID)
-- VALUES (32435443443434, 3034, 356, 'Debit', 'prime', 'active', '23.10.2020', '23.10.2025', 1000, 0, 97483738297282);

-- INSERT INTO Card (CardID, Pin, CVV, CardType, Tariff, Status, ReleaseDate, ValidityDate, CreditLimit, Bonuses, AccountID)
-- VALUES (96545678987656, 2823, 452, 'Debit', 'prime', 'active', '23.10.2020', '23.10.2025', 1000, 0, 37428433889924);

-- INSERT INTO Card (CardID, Pin, CVV, CardType, Tariff, Status, ReleaseDate, ValidityDate, CreditLimit, Bonuses, AccountID)
-- VALUES (53445344243324, 4822, 101, 'Debit', 'prime', 'active', '23.10.2020', '23.10.2025', 1000, 0, 34345453223236);

-- вставка рядків в TransInfo
-- INSERT INTO TransInfo (TransactionType, ComissionCoef)
-- VALUES ('transfer', 0.01);

-- вставка рядків в Transactions
-- INSERT INTO Transaction (TransactionID, CardID, CardIdReciever, InitialSum, ComissionSum, BonusesUsed, TotalSum, BonusesResieved, TransDateTime, TransactionType)
-- VALUES (DEFAULT, 9876543456789, 9876543434233, 1000, 1000*0.01, 10, 1000, 0.34, '23.10.2020', 'transfer');

-- INSERT INTO Transaction (TransactionID, CardID, CardIdReciever, InitialSum, ComissionSum, BonusesUsed, TotalSum, BonusesResieved, TransDateTime, TransactionType)
-- VALUES (DEFAULT, 98765434567876, 9876543434233, 900, 900*0.01, 10, 900, 0.34, '23.10.2020', 'transfer');

-- INSERT INTO Transaction (TransactionID, CardID, CardIdReciever, InitialSum, ComissionSum, BonusesUsed, TotalSum, BonusesResieved, TransDateTime, TransactionType)
-- VALUES (DEFAULT, 32435443443434, 9876543434233, 990, 990*0.01, 10, 990, 0.34, '23.10.2020', 'transfer');

-- INSERT INTO Transaction (TransactionID, CardID, CardIdReciever, InitialSum, ComissionSum, BonusesUsed, TotalSum, BonusesResieved, TransDateTime, TransactionType)
-- VALUES (DEFAULT, 96545678987656, 9876543434233, 980, 980*0.01, 10, 980, 0.34, '23.10.2020', 'transfer');

-- INSERT INTO Transaction (TransactionID, CardID, CardIdReciever, InitialSum, ComissionSum, BonusesUsed, TotalSum, BonusesResieved, TransDateTime, TransactionType)
-- VALUES (DEFAULT, 53445344243324, 9876543434233, 980, 980*0.01, 10, 980, 0.34, '23.10.2020', 'transfer');


