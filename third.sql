-- Создание базы данных
CREATE DATABASE IF NOT EXISTS Tourism;
USE Tourism;

-- Таблица-справочник Типы туров
CREATE TABLE TourTypes (
    TourTypeID INT PRIMARY KEY AUTO_INCREMENT,
    TourTypeName VARCHAR(50) NOT NULL,
    Description TEXT
);

-- Таблица-справочник Страны
CREATE TABLE Countries (
    CountryID INT PRIMARY KEY AUTO_INCREMENT,
    CountryName VARCHAR(50) NOT NULL,
    Currency VARCHAR(3) -- (USD, EUR, RUB)
);

-- Таблица-справочник Услуги
CREATE TABLE Services (
    ServiceID INT PRIMARY KEY AUTO_INCREMENT,
    ServiceName VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2) NOT NULL  -- Цена за единицу услуги
);

-- Таблица-справочник Менеджеры
CREATE TABLE Managers (
    ManagerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    PhoneNumber VARCHAR(20)
);

-- Таблица переменной информации Туры
CREATE TABLE Tours (
    TourID INT PRIMARY KEY AUTO_INCREMENT,
    TourTypeID INT NOT NULL,
    CountryID INT NOT NULL,
    TourName VARCHAR(100) NOT NULL,
    Description TEXT,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    ManagerID INT NOT NULL,
    FOREIGN KEY (TourTypeID) REFERENCES TourTypes(TourTypeID),
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID),
    FOREIGN KEY (ManagerID) REFERENCES Managers(ManagerID)
);

-- Таблица переменной информации Заказы (как пример расширенной таблицы)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    TourID INT NOT NULL,
    CustomerID INT NOT NULL,
    OrderDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    NumberOfPersons INT NOT NULL,
    TotalPrice DECIMAL(10, 2) NOT NULL,  -- Рассчитывается на основе кол-ва персон и цены тура
    ManagerID INT NOT NULL,
    FOREIGN KEY (TourID) REFERENCES Tours(TourID),
    FOREIGN KEY (ManagerID) REFERENCES Managers(ManagerID)
);

-- Промежуточная таблица: Услуги в туре (связь многие ко многим между Tours и Services)
CREATE TABLE TourServices (
    TourID INT NOT NULL,
    ServiceID INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 1, -- Количество данной услуги в туре. Например, 2 экскурсии.
    PRIMARY KEY (TourID, ServiceID),
    FOREIGN KEY (TourID) REFERENCES Tours(TourID),
    FOREIGN KEY (ServiceID) REFERENCES Services(ServiceID)
);

-- Заполнение справочников примерами данных
INSERT INTO TourTypes (TourTypeName, Description) VALUES
('Пляжный отдых', 'Отдых на море или океане'),
('Экскурсионный тур', 'Поездки по городам и достопримечательностям'),
('Горнолыжный тур', 'Катание на лыжах и сноуборде'),
('Круиз', 'Путешествие на корабле');

INSERT INTO Countries (CountryName, Currency) VALUES
('Турция', 'TRY'),
('Египет', 'EGP'),
('Италия', 'EUR'),
('Франция', 'EUR'),
('Россия', 'RUB');

INSERT INTO Services (ServiceName, Description, Price) VALUES
('Трансфер из аэропорта', 'Встреча в аэропорту и доставка в отель', 50.00),
('Экскурсия по городу', 'Обзорная экскурсия по основным достопримечательностям', 80.00),
('Аренда автомобиля', 'Аренда автомобиля на сутки', 100.00),
('Медицинская страховка', 'Страховка на время поездки', 30.00);

INSERT INTO Managers (FirstName, LastName, Email, PhoneNumber) VALUES
('Иван', 'Иванов', 'ivan.ivanov@mail.ru', '+79123456789'),
('Петр', 'Петров', 'petr.petrov@mail.ru', '+79123456788');

-- Заполнение таблицы туров примерами данных
INSERT INTO Tours (TourTypeID, CountryID, TourName, Description, StartDate, EndDate, Price, ManagerID) VALUES
(1, 1, 'Пляжный отдых в Анталии', 'Неделя на пляже в Анталии', '2024-07-01', '2024-07-08', 800.00, 1),
(2, 3, 'Экскурсионный тур по Риму', 'Посещение Колизея, Ватикана и других достопримечательностей', '2024-08-15', '2024-08-22', 1200.00, 2);

-- Заполнение таблицы заказов примерами данных (предполагаем, что CustomerID=1 и 2 существуют)
INSERT INTO Orders (TourID, CustomerID, NumberOfPersons, TotalPrice, ManagerID) VALUES
(1, 1, 2, 1600.00, 1), -- 2 человека на пляжный тур (800 * 2)
(2, 2, 1, 1200.00, 2); -- 1 человек на экскурсионный тур

-- Заполнение таблицы TourServices примерами данных
INSERT INTO TourServices (TourID, ServiceID, Quantity) VALUES
(1, 1, 1),  -- Пляжный тур включает трансфер (1 раз)
(1, 4, 2),  -- Пляжный тур включает медицинскую страховку на 2 человека
(2, 2, 3),  -- Экскурсионный тур включает 3 экскурсии по городу
(2, 4, 1);  -- Экскурсионный тур включает медицинскую страховку на 1 человека