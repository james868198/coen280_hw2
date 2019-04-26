-- functions

-- CREATE FUNCTION dbo.vaValidEmail(@EMAIL varchar(100))
-- RETURNS bit as
-- BEGIN     
--   DECLARE @bitRetVal as Bit
--   IF (@EMAIL <> '' AND @EMAIL NOT LIKE '_%@__%.__%')
--      SET @bitRetVal = 0  -- Invalid
--   ELSE 
--     SET @bitRetVal = 1   -- Valid
--   RETURN @bitRetVal
-- END 

-- Assumptions:
--     TVSeries has ID
--     There is no ProductionCompany having the same name.
--     Pictures are all belong to Personal if IsProfile is 0
-- table schemas


create table IMDBUser(
    IMDBID number PRIMARY KEY,
    Email varchar(100) NOT NULL UNIQUE,
    FirstName varchar(20) NOT NULL,
    LastName varchar(20) NOT NULL,
    Gender char(1) NOT NULL,
    Birthdate date NOT NULL,
    Birthplace varchar(50)
);/
create table Person(
    ID number PRIMARY KEY,
    Email varchar(100) NOT NULL UNIQUE,
    FirstName varchar(20) NOT NULL,
    LastName varchar(20) NOT NULL,
    Gender char(1) NOT NULL,,
    Birthdate date NOT NULL,
    Nation varchar(50),
    State varchar(50),
    Province varchar(50),
    Town varchar(50),
    IsMature number(1) DEFAULT 1 NOT NULL
);/

create table Guardian(
    MinorID number NOT NULL,
    AdultID number NOT NULL,
    CONSTRAINT fk_Person
        FOREIGN KEY(MinorID, AdultID)
        REFERENCES Person(ID, ID)
    ,
    CONSTRAINT pk_Guardian
        PRIMARY KEY (MinorID, AdultID)
);/

create table Marry(
    Person1 number NOT NULL,
    Person2 number NOT NULL,
    Year date NOT NULL,
    CONSTRAINT fk_Person
        FOREIGN KEY(Person1, Person2)
        REFERENCES Person(ID, ID)
    ,
    CONSTRAINT pk_Marry
        PRIMARY KEY (Person1, Person2)
);/

-- problem
create table Actor(
    ID number PRIMARY KEY,
    CONSTRAINT fk_Person
        FOREIGN KEY(ID)
        REFERENCES Person(ID)
);/

-- problem
create table Director(
    ID number PRIMARY KEY,
    CONSTRAINT fk_Person
        FOREIGN KEY(ID)
        REFERENCES Person(ID)
);/

create table ProductionCompany(
    Name varchar(50) PRIMARY KEY
);/
create table Movie(
    SerialNumber number PRIMARY KEY,
    Title varchar(50) NOT NULL,
    ProductionCost number,
    ReleasedYear date NOT NULL,
    DirectorID number NOT NULL,
    ConstractNumber number NOT NULL,
    ProductionCompanyName varchar(50) NOT NULL,
    CONSTRAINT fk_Director
        FOREIGN KEY(DirectorID)
        REFERENCES Director(ID)
    ,
    CONSTRAINT fk_ProductionCompany
        FOREIGN KEY(ProductionCompanyName)
        REFERENCES ProductionCompany(Name)
);/
create table ActionMovie(
    MovieID number PRIMARY KEY,
    CONSTRAINT fk_Moive
        FOREIGN KEY(MovieID)
        REFERENCES Movie(SerialNumber)
);/  
create table ComedyMovie(
    MovieID number PRIMARY KEY,
    CONSTRAINT fk_Moive
        FOREIGN KEY(MovieID)
        REFERENCES Movie(SerialNumber)
);/ 
create table DramaMovie(
    MovieID number PRIMARY KEY,
    CONSTRAINT fk_Moive
        FOREIGN KEY(MovieID)
        REFERENCES Movie(SerialNumber)
);/ 
create table Scenes(
    MovieID number NOT NULL,
    Number number NOT NULL,
    CONSTRAINT fk_Moive
        FOREIGN KEY(MovieID)
        REFERENCES Movie(SerialNumber)
);/
create table TVSeries(
    ID number PRIMARY KEY,
    Name varchar(50) NOT NULL,
    TVNetworks varchar(50) NOT NULL,
    ProductionCost number,
    ReleasedYear date NOT NULL,
    ConstractNumber number NOT NULL,
    ProductionCompanyName varchar(50) NOT NULL,
    CONSTRAINT fk_ProductionCompany
        FOREIGN KEY(ProductionCompanyName)
        REFERENCES ProductionCompany(Name)
);/
create table Episode(
    Title varchar(50) NOT NULL,
    TVNetworks varchar(50) NOT NULL,
    TVSeriesID number NOT NULL,
    Length timestamp,
    NumberOfEp number NOT NULL,
    CONSTRAINT fk_TVSeries
        FOREIGN KEY(TVSeriesID)
        REFERENCES TVSeries(ID)
    ,
    CONSTRAINT pk_Episode
        PRIMARY KEY (TVSeriesID, NumberOfEp)
);/

create table GuestActor(
    Role varchar(50) NOT NULL,
    Charactor varchar(50) NOT NULL,
    EpisodID number NOT NULL,
    ActorID number NOT NULL,
    CONSTRAINT fk_Actor
        FOREIGN KEY(ActorID)
        REFERENCES Actor(ID)
    ,
    CONSTRAINT fk_Episode
        FOREIGN KEY(EpisodID)
        REFERENCES Episode(pk_Episode)
    ,
    CONSTRAINT pk_GuestActor
        PRIMARY KEY (ActorID, TVSeriesID, NumberOfEp, Charactor)
);/

create table RegularActor(
    Role varchar(50) NOT NULL,
    Charactor varchar(50) NOT NULL,
    TVSeriesID number NOT NULL,
    ActorID number NOT NULL,
    CONSTRAINT fk_Actor
        FOREIGN KEY(ActorID)
        REFERENCES Actor(ID)
    ,
    CONSTRAINT fk_TVSeries
        FOREIGN KEY(TVSeriesID)
        REFERENCES TVSeries(ID)
    ,
    CONSTRAINT pk_RegularActor 
        PRIMARY KEY (ActorID, TVSeriesID, Charactor)
);/

create table MovieActor(
    Role  varchar(50) NOT NULL,
    Charactor varchar(50) NOT NULL,
    MovieID number NOT NULL,
    ActorID number NOT NULL,
    CONSTRAINT fk_Actor
        FOREIGN KEY(ActorID)
        REFERENCES Actor(ID)
    ,
    CONSTRAINT fk_Movie
        FOREIGN KEY(MovieID)
        REFERENCES Movie(SerialNumber)
    ,
    CONSTRAINT pk_MovieActor 
        PRIMARY KEY (ActorID, MovieID, Charactor)
);/


create table Picture(
    PictureUrl number PRIMARY KEY,
    AuthorId number NOT NULL,
    Name varchar(50) NOT NULL,
    Description varchar(200) NOT NULL,
    IsProfile NUMBER(1) DEFAULT 0 NOT NULL,
    CONSTRAINT fk_IMDBUser
        FOREIGN KEY(AuthorId)
        REFERENCES IMDBUser(IMDBID)
);/

create table ProfilePicture(
    PictureID number NOT NULL,
    ProfileID number NOT NULL,
    CONSTRAINT fk_IMDBUser
        FOREIGN KEY(ProfileID)
        REFERENCES IMDBUser(IMDBID)
    ,
    CONSTRAINT fk_Picture
        FOREIGN KEY(PictureID)
        REFERENCES Picture(PictureUrl)
);/
create table PersonPicture(
    PictureID number NOT NULL,
    PersonID number NOT NULL,
    CONSTRAINT fk_Person
        FOREIGN KEY(PersonID)
        REFERENCES Person(ID)
    ,
    CONSTRAINT fk_Picture
        FOREIGN KEY(PictureID)
        REFERENCES Picture(PictureUrl)
);/
create table MovieRate(
    UserID number NOT NUll,
    MovieID number NOT NUll,
    Rate number NOT NUll,
    CONSTRAINT chk_rate_range CHECK (Rate>=1 AND Rate<=10 )
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
    TVSeriesID  number NOT NUll,
    Rate number NOT NUll,
    CONSTRAINT chk_rate_range CHECK (Rate>=1 AND Rate<=10 )
    CONSTRAINT fk_IMDBUser
        FOREIGN KEY(UserID)
        REFERENCES IMDBUser(IMDBID)
    ,
    CONSTRAINT fk_TVSeries
        FOREIGN KEY(TVSeriesID)
        REFERENCES TVSeries(ID)
);/

create table Reviews(
    ID number PRIMARY KEY,
    PublishDate date DEFAULT sysdate NOT NULL,
    Stars number NOT NULL,
    AuthorID number NOT NULL,
    TotalVotes number NOT NULL DEFAULT 0,
    Text varchar(2000),
    PhotoUrl varchar(100),
    VideoUrl varchar(100),
    CONSTRAINT fk_IMDBUser
        FOREIGN KEY(AuthorID)
        REFERENCES IMDBUser(IMDBID)
);/

create table VoteHelpful(
    ReviewID number NOT NUll,
    AuthorID number NOT NULL,
    CONSTRAINT fk_Reviews
        FOREIGN KEY(ReviewID)
        REFERENCES Reviews(ID)
    ,
    CONSTRAINT fk_IMDBUser
        FOREIGN KEY(AuthorID)
        REFERENCES IMDBUser(IMDBID)
);/

create table VoteNonHelpful(
    ReviewID number NOT NUll,
    AuthorID number NOT NULL,
    CONSTRAINT fk_Reviews
        FOREIGN KEY(ReviewID)
        REFERENCES Reviews(ID)
    ,
    CONSTRAINT fk_IMDBUser
        FOREIGN KEY(AuthorID)
        REFERENCES IMDBUser(IMDBID)
);/

create table Comments(
    ReviewID number NOT NUll,
    AuthorID number NOT NULL,
    content varchar(2000),
    Date date DEFAULT sysdate NOT NULL,
    CONSTRAINT fk_Reviews
        FOREIGN KEY(ReviewID)
        REFERENCES Reviews(ID)
    ,
    CONSTRAINT fk_IMDBUser
        FOREIGN KEY(AuthorID)
        REFERENCES IMDBUser(IMDBID)
);/

create table Awards(
    Year number NOT NUll,
    Event varchar(50) NOT NUll,
    CONSTRAINT pk_Awards PRIMARY KEY (Year, Event)
);/

create table Nominations(
    MovieID number NOT NULL,
    Category varchar(50),
    Win NUMBER(1) DEFAULT 0 NOT NULL,
    ActorID number, 
    DirectorID number,
    Award varchar(100) NOT NULL,
    CONSTRAINT fk_Moive NOT NULL,
        FOREIGN KEY(MovieID)
        REFERENCES Movie(SerialNumber)
    ,
    CONSTRAINT fk_Actor
        FOREIGN KEY(ActorID)
        REFERENCES Actor(ID)
    ,
    CONSTRAINT fk_Director
        FOREIGN KEY(DirectorID)
        REFERENCES Director(ID)
    ,
    CONSTRAINT fk_Awards
        FOREIGN KEY(Award)
        REFERENCES Awards(pk_Awards)
);/
