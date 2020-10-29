-- обережно! при активації цього фалйлу очищуються всі таблиці
-- RESTART IDENTITY починає серійні ID спочатку
TRUNCATE Card,
		 CardInfo,
		 UserLogins,
		 Client,
		 ClientAccLog,
		 Transaction,
		 TransInfo RESTART IDENTITY;