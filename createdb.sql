-- functions
CREATE FUNCTION dbo.vaValidEmail(@EMAIL varchar(100))

RETURNS bit as
BEGIN     
  DECLARE @bitRetVal as Bit
  IF (@EMAIL <> '' AND @EMAIL NOT LIKE '_%@__%.__%')
     SET @bitRetVal = 0  -- Invalid
  ELSE 
    SET @bitRetVal = 1   -- Valid
  RETURN @bitRetVal
END 

-- table schemas


create table IMDBUser(
    IMDBID number PRIMARY KEY,
    Email varchar2(100) NOT NULL UNIQUE,
    Name varchar(20) NOT NULL,
    Gender varchar(8),
    Birthdate date, 
    Birthplace varchar(50)
);/
create table Person(
    ID number PRIMARY KEY,
    Email varchar2(100) NOT NULL UNIQUE,
    FirstName varchar(20) NOT NULL,
    LastName varchar(20) NOT NULL,
    Gender varchar(8),
    Birthdate date, 
    Nation varchar(50),
    State varchar(50),
    Province varchar(50),
    Town varchar(50),
);/
create table Movie(
    SerialNumber number PRIMARY KEY,
    Title varchar(50) NOT NULL,
    ProductionCost number,
    ReleasedYear date NOT NULL
);/
create table TVSeries(
    Name varchar(50) PRIMARY KEY,
    TVNetworks varchar(50) NOT NULL,
    ProductionCost number,
    ReleasedYear date NOT NULL
);/
create table Episode(
    SerialNumber number PRIMARY KEY,
    Title varchar(50) NOT NULL,
    TVNetworks varchar(50) NOT NULL,
    TVSeriesName varchar(50) NOT NULL,
    Length number,
    number number,
    CONSTRAINT fk_TVSeries
        FOREIGN KEY(TVSeriesName)
        REFERENCES TVSeries(Name)
);/
create table ProductionCompany(
    Name varchar(50) PRIMARY KEY
);/
create table ProduceMoive(
    ConstractNumber number PRIMARY KEY,
    MovieID number NOT NULL,
    ProductionCompanyName varchar(50) NOT NULL,
    CONSTRAINT fk_Moive
        FOREIGN KEY(MovieID)
        REFERENCES Movie(SerialNumber)
    ,
    CONSTRAINT fk_ProductionCompany
        FOREIGN KEY(ProductionCompanyName)
        REFERENCES ProductionCompany(Name)
);/
create table ProduceTVSeries(
    ConstractNumber number PRIMARY KEY,
    TVSeriesName varchar(50) NOT NULL,
    ProductionCompanyName varchar(50) NOT NULL,
    CONSTRAINT fk_TVSeries
        FOREIGN KEY(TVSeriesName)
        REFERENCES TVSeries(Name)
    ,
    CONSTRAINT fk_ProductionCompany
        FOREIGN KEY(ProductionCompanyName)
        REFERENCES ProductionCompany(Name)
);/
create table Picture(
    AuthorId number NOT NULL,
    Name varchar(50) NOT NULL,
    Description varchar(200) NOT NULL,
    Personal NUMBER(1) DEFAULT 0 NOT NULL,
    Profile NUMBER(1) DEFAULT 0 NOT NULL,
    PersonID NUMBER,
    CONSTRAINT fk_IMDBUser
        FOREIGN KEY(AuthorId)
        REFERENCES IMDBUser(IMDBID)
    ,
    CONSTRAINT fk_Person
        FOREIGN KEY(PersonID)
        REFERENCES Person(ID)
);/
create table MovieRate(
    UserID number NOT NUll,
    MovieID number NOT NUll,
    rate number number NOT NUll,
    CONSTRAINT chk_rate_range CHECK (rate>=1 AND rate<=10 )
    CONSTRAINT fk_IMDBUser
        FOREIGN KEY(UserID)
        REFERENCES IMDBUser(IMDBID)
    ,
    CONSTRAINT fk_Moive
        FOREIGN KEY(MovieID)
        REFERENCES Movie(SerialNumber)
);/
create table TVSerieRate(
    UserID number NOT NUll,
    TVSeriesName varchar(50) NOT NULL,
    rate number number NOT NUll,
    CONSTRAINT chk_rate_range CHECK (rate>=1 AND rate<=10 )
    CONSTRAINT fk_IMDBUser
        FOREIGN KEY(UserID)
        REFERENCES IMDBUser(IMDBID)
    ,
    CONSTRAINT fk_TVSeries
        FOREIGN KEY(TVSeriesName)
        REFERENCES Movie(SerialNumber)
);/

create table Reviews(
    ID number PRIMARY KEY,
    PublishDate date default sysdate NOT NULL,
    stars number NOT NULL,
    TVSeriesName varchar(50) NOT NULL,
    rate number number NOT NUll,
    CONSTRAINT chk_rate_range CHECK (rate>=1 AND rate<=10 )
    CONSTRAINT fk_IMDBUser
        FOREIGN KEY(UserID)
        REFERENCES IMDBUser(IMDBID)
    ,
    CONSTRAINT fk_TVSeries
        FOREIGN KEY(TVSeriesName)
        REFERENCES Movie(SerialNumber)
);