-- functions
-- Assumptions:
--     TVSeries has ID
--     There is no ProductionCompany having the same name.
--     Pictures are all belong to IMDBPersonal if IsProfile is 0
--     Actors won't play different role in the same movie, episodle or TV Series

-- table schemas

create table IMDBUser(
    IMDBID number PRIMARY KEY,
    Email varchar(100) NOT NULL UNIQUE,
    FirstName varchar(20) NOT NULL,
    LastName varchar(20) NOT NULL,
    Gender char(1) NOT NULL,
    Birthdate date NOT NULL,
    Birthplace varchar(500),
    Age number NOT NULL CHECK(Age>=0 AND Age <130)
);
create table IMDBPerson(
    ID number PRIMARY KEY,
    FirstName varchar(20) NOT NULL,
    LastName varchar(20) NOT NULL,
    Gender char(1) NOT NULL,
    Birthdate date NOT NULL,
    Nation varchar(500),
    State varchar(500),
    Town varchar(500),
    IsMature number(1) DEFAULT 1 NOT NULL,
    Attribute varchar(500) NOT NULL CHECK(Attribute ='Director' OR Attribute ='Actor'),
    Age number NOT NULL CHECK(Age>=0 AND Age <130)
);
create table Guardian(
    MinorID number NOT NULL,
    AdultID number NOT NULL,
    CONSTRAINT fk_IMDBPerson_MinorID
        FOREIGN KEY(MinorID)
        REFERENCES IMDBPerson(ID)
    ,
    CONSTRAINT fk_IMDBPerson_AdultID
        FOREIGN KEY(AdultID)
        REFERENCES IMDBPerson(ID)
    ,
    CONSTRAINT pk_Guardian
        PRIMARY KEY (MinorID, AdultID)
);
create table Marry(
    IMDBPerson1 number NOT NULL,
    IMDBPerson2 number NOT NULL,
    Year number NOT NULL CHECK(Year<2020),
    CONSTRAINT fk_IMDBPerson1
        FOREIGN KEY(IMDBPerson1)
        REFERENCES IMDBPerson(ID)
    ,
    CONSTRAINT fk_IMDBPerson2
        FOREIGN KEY(IMDBPerson2)
        REFERENCES IMDBPerson(ID)
    ,
    CONSTRAINT pk_Marry
        PRIMARY KEY (IMDBPerson1, IMDBPerson2)
);
create table ProductionCompany(
    Name varchar(500) PRIMARY KEY
);
create table Movie(
    SerialNumber number PRIMARY KEY,
    Title varchar(500) NOT NULL,
    ProductionCost number,
    ReleasedYear number NOT NULL CHECK(ReleasedYear>1800 AND ReleasedYear<2020),
    DirectorID number NOT NULL,
    ConstractNumber number NOT NULL,
    ProductionCompanyName varchar(500) NOT NULL,
    CONSTRAINT fk_IMDBPerson_Movie
        FOREIGN KEY(DirectorID)
        REFERENCES IMDBPerson(ID)
    ,
    CONSTRAINT fk_ProductionCompany_Movie
        FOREIGN KEY(ProductionCompanyName)
        REFERENCES ProductionCompany(Name)
);
create table Genre(
    MovieID number NOT NULL,
    Genre varchar(500) NOT NULL CHECK(Genre = 'ACTION' OR Genre = 'DRAMA' OR Genre = 'COMEDY'),
    CONSTRAINT fk_Moive_Genre
        FOREIGN KEY(MovieID)
        REFERENCES Movie(SerialNumber)
    ,
    CONSTRAINT pk_Genre
        PRIMARY KEY (MovieID, Genre)
);
create table Scenes(
    MovieID number NOT NULL,
    SceneNumber number NOT NULL,
    CONSTRAINT fk_Moive_Scene
        FOREIGN KEY(MovieID)
        REFERENCES Movie(SerialNumber)
);
create table TVSeries(
    ID number PRIMARY KEY,
    Name varchar(500) NOT NULL,
    TVNetworks varchar(500) NOT NULL,
    ProductionCost number,
    ReleasedYear number NOT NULL CHECK(ReleasedYear>1800 AND ReleasedYear<2020),
    ConstractNumber number NOT NULL,
    ProductionCompanyName varchar(500) NOT NULL,
    CONSTRAINT fk_ProductionCompany_TVSeries
        FOREIGN KEY(ProductionCompanyName)
        REFERENCES ProductionCompany(Name)
);
create table Episode(
    Title varchar(500) NOT NULL,
    TVNetworks varchar(500) NOT NULL,
    TVSeriesID number NOT NULL,
    Length timestamp,
    NumberOfEp number NOT NULL,
    CONSTRAINT fk_TVSeries_Episode
        FOREIGN KEY(TVSeriesID)
        REFERENCES TVSeries(ID)
    ,
    CONSTRAINT pk_Episode
        PRIMARY KEY (TVSeriesID, NumberOfEp)
);
create table GuestActor(
    Role varchar(500),
    TVSeriesID number NOT NULL,
    NumberOfEp number NOT NULL,
    ActorID number NOT NULL,
    CONSTRAINT fk_IMDBPerson_GuestActor
        FOREIGN KEY(ActorID)
        REFERENCES IMDBPerson(ID)
    ,
    CONSTRAINT fk_Episode_GuestActor
        FOREIGN KEY(TVSeriesID,NumberOfEp)
        REFERENCES Episode(TVSeriesID, NumberOfEp)
    ,
    CONSTRAINT pk_GuestActor
        PRIMARY KEY (ActorID, TVSeriesID, NumberOfEp)
);
create table RegularActor(
    Role varchar(500),
    TVSeriesID number NOT NULL,
    ActorID number NOT NULL,
    CONSTRAINT fk_IMDBPerson_RegularActor
        FOREIGN KEY(ActorID)
        REFERENCES IMDBPerson(ID)
    ,
    CONSTRAINT fk_TVSeries_RegularActor
        FOREIGN KEY(TVSeriesID)
        REFERENCES TVSeries(ID)
    ,
    CONSTRAINT pk_RegularActor
        PRIMARY KEY (ActorID, TVSeriesID)
);
create table MovieActor(
    Role  varchar(500),
    MovieID number NOT NULL,
    ActorID number NOT NULL,
    CONSTRAINT fk_IMDBPerson_MovieActor
        FOREIGN KEY(ActorID)
        REFERENCES IMDBPerson(ID)
    ,
    CONSTRAINT fk_Movie_MovieActor
        FOREIGN KEY(MovieID)
        REFERENCES Movie(SerialNumber)
    ,
    CONSTRAINT pk_MovieActor 
        PRIMARY KEY (ActorID, MovieID)
);
create table Picture(
    PictureUrl number PRIMARY KEY,
    AuthorId number NOT NULL,
    Name varchar(500) NOT NULL,
    Description varchar(200) NOT NULL,
    IsProfile NUMBER(1) DEFAULT 0 NOT NULL,
    CONSTRAINT fk_IMDBUser
        FOREIGN KEY(AuthorId)
        REFERENCES IMDBUser(IMDBID)
);
create table ProfilePicture(
    PictureID number NOT NULL,
    ProfileID number NOT NULL,
    CONSTRAINT fk_IMDBUser_ProfilePicture
        FOREIGN KEY(ProfileID)
        REFERENCES IMDBUser(IMDBID)
    ,
    CONSTRAINT fk_Picture_ProfilePicture
        FOREIGN KEY(PictureID)
        REFERENCES Picture(PictureUrl)
);
create table PersonPicture(
    PictureID number NOT NULL,
    IMDBPersonID number NOT NULL,
    CONSTRAINT fk_IMDBPerson_PersonPicture
        FOREIGN KEY(IMDBPersonID)
        REFERENCES IMDBPerson(ID)
    ,
    CONSTRAINT fk_Picture_PersonPicture
        FOREIGN KEY(PictureID)
        REFERENCES Picture(PictureUrl)
);
create table MovieRate(
    UserID number NOT NUll,
    MovieID number NOT NUll,
    Rate number NOT NUll,
    CONSTRAINT chk_MovieRate_range CHECK (Rate>=0 AND Rate<=10 ),
    CONSTRAINT fk_IMDBUser_MovieRate
        FOREIGN KEY(UserID)
        REFERENCES IMDBUser(IMDBID)
    ,
    CONSTRAINT fk_Moive_MovieRate
        FOREIGN KEY(MovieID)
        REFERENCES Movie(SerialNumber)
);
create table TVSerieRate(
    UserID number NOT NUll,
    TVSeriesID  number NOT NUll,
    Rate number NOT NUll,
    CONSTRAINT chk_TVSerieRate_range CHECK (Rate>=1 AND Rate<=10 ),
    CONSTRAINT fk_IMDBUser_TVSerieRate
        FOREIGN KEY(UserID)
        REFERENCES IMDBUser(IMDBID)
    ,
    CONSTRAINT fk_TVSeries_TVSerieRate
        FOREIGN KEY(TVSeriesID)
        REFERENCES TVSeries(ID)
);
create table Reviews(
    ID number PRIMARY KEY,
    PublishDate date DEFAULT sysdate NOT NULL,
    Stars number NOT NULL,
    AuthorID number NOT NULL,
    TotalVotes number DEFAULT 0 NOT NULL,
    Text varchar(2000),
    PhotoUrl varchar(100),
    VideoUrl varchar(100),
    CONSTRAINT fk_IMDBUser_Reviews
        FOREIGN KEY(AuthorID)
        REFERENCES IMDBUser(IMDBID)
);
create table VoteHelpful(
    ReviewID number NOT NUll,
    AuthorID number NOT NULL,
    CONSTRAINT fk_Reviews_VoteHelpful
        FOREIGN KEY(ReviewID)
        REFERENCES Reviews(ID)
    ,
    CONSTRAINT fk_IMDBUser_VoteHelpful
        FOREIGN KEY(AuthorID)
        REFERENCES IMDBUser(IMDBID)
);
create table VoteNonHelpful(
    ReviewID number NOT NUll,
    AuthorID number NOT NULL,
    CONSTRAINT fk_Reviews_VoteNonHelpful
        FOREIGN KEY(ReviewID)
        REFERENCES Reviews(ID)
    ,
    CONSTRAINT fk_IMDBUser_VoteNonHelpful
        FOREIGN KEY(AuthorID)
        REFERENCES IMDBUser(IMDBID)
);
create table Comments(
    ReviewID number NOT NUll,
    AuthorID number NOT NULL,
    content varchar(2000),
    PublishDate date DEFAULT sysdate NOT NULL,
    CONSTRAINT fk_Reviews_Comments
        FOREIGN KEY(ReviewID)
        REFERENCES Reviews(ID)
    ,
    CONSTRAINT fk_IMDBUser_Comments
        FOREIGN KEY(AuthorID)
        REFERENCES IMDBUser(IMDBID)
);
create table Awards(
    Year number NOT NUll CHECK(Year>1800 AND Year<2020),
    Event varchar(500) NOT NUll,
    CONSTRAINT pk_Awards PRIMARY KEY (Year, Event)
);
create table Nominations(
    MovieID number NOT NULL,
    Category varchar(500),
    Win NUMBER(1) DEFAULT 0 NOT NULL,
    PersonID number, 
    AwardYear number NOT NUll,
    AwardEvent varchar(500) NOT NUll,
    CONSTRAINT fk_Moive_Nominations
        FOREIGN KEY(MovieID)
        REFERENCES Movie(SerialNumber)
    ,
    CONSTRAINT fk_MDBPerson_Nominations
        FOREIGN KEY(PersonID)
        REFERENCES IMDBPerson(ID)
    ,
    CONSTRAINT fk_Awards_Nominations
        FOREIGN KEY(AwardYear, AwardEvent)
        REFERENCES Awards(Year, Event)
);
