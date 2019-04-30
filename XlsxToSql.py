import pandas as pd
import datetime
import random

MOVIE = pd.read_excel("HW2 data.xlsx",[0])[0]
PERSON = pd.read_excel("HW2 data.xlsx",[1])[1]
RATING = pd.read_excel("HW2 data.xlsx",[2])[2]
ROLES = pd.read_excel("HW2 data.xlsx",[3])[3]
IMDB_USER = pd.read_excel("HW2 data.xlsx",[4])[4]

# print(MOVIE)
# print(PERSON)
# print(PERSON.count(axis='rows')['PID'])

# print(RATING)
# print(ROLES)
# print(IMDB_USER.count(axis='rows')['IMDB ID'])
# print(IMDB_USER.iloc[0])
CompanyDefaultName = 'company'

f = open("insertdb.sql", "w")

# PERSON
rows = PERSON.count(axis='rows')['PID']
f.write('--PERSON rows:{}'.format(rows)+'\n')
for i in range(0,rows):
    ID = PERSON.iloc[i]['PID'].replace('P','')
    FIRSTNAME = PERSON.iloc[i]['First Name']
    LASTNAME = PERSON.iloc[i]['Last Name']
    Gender = PERSON.iloc[i]['Gender']
    BIRTHDATE = PERSON.iloc[i]['birthdate'].strftime("%m/%d/%Y")
    if 2019 - PERSON.iloc[i]['birthdate'].year>=18:
        ISMATURE = 1
    else:
        ISMATURE = 0
    ATTRIBUTE = PERSON.iloc[i]['Attribute']    
    row = '''INSERT INTO IMDBPerson (ID, FIRSTNAME, LASTNAME,GENDER, BIRTHDATE,ISMATURE,ATTRIBUTE,AGE) VALUES ({},'{}','{}','{}',TO_DATE( '{}', 'MM-DD-YYYY' ),{},'{}', GET_AGE(TO_DATE( '{}', 'MM-DD-YYYY')));'''.format(ID,FIRSTNAME,LASTNAME,Gender,BIRTHDATE,ISMATURE,ATTRIBUTE,BIRTHDATE )
    f.write(row+'\n')
    print(row)
# IMDB_USER
rows = IMDB_USER.count(axis='rows')['IMDB ID']
f.write('--IMDB_USER rows:{}'.format(rows)+'\n')
for i in range(0,rows):
    ID = IMDB_USER.iloc[i]['IMDB ID'].replace('ID','')
    EMAIL = IMDB_USER.iloc[i]['Email']
    FIRSTNAME = IMDB_USER.iloc[i]['First Name']
    LASTNAME = IMDB_USER.iloc[i]['Last Name']
    Gender = IMDB_USER.iloc[i]['Gender']
    BIRTHDATE = IMDB_USER.iloc[i]['DOB'].strftime("%m/%d/%Y")
    BIRTHPLACE = IMDB_USER.iloc[i]['BirthPlace']
    row = '''INSERT INTO IMDBUser (IMDBID, EMAIL, FIRSTNAME, LASTNAME,GENDER, BIRTHDATE,BIRTHPLACE,AGE) VALUES ({},'{}','{}','{}','{}',TO_DATE( '{}', 'MM-DD-YYYY' ),'{}', GET_AGE(TO_DATE( '{}', 'MM-DD-YYYY')));'''.format(ID,EMAIL,FIRSTNAME,LASTNAME,Gender,BIRTHDATE,BIRTHPLACE,BIRTHDATE )
    f.write(row+'\n')
    print(row)

# ProductionCompany
CompanyAmount = 10
f.write('--ProductionCompany rows:{}'.format(CompanyAmount)+'\n')
for i in range(0,CompanyAmount):
    NAME = CompanyDefaultName+str(i)
    row = '''INSERT INTO PRODUCTIONCOMPANY (NAME) VALUES ('{}');'''.format(NAME)
    f.write(row+'\n')
    print(row)

# MOVIE
rows = MOVIE.count(axis='rows')['MID']
f.write('--MOVIE rows:{}'.format(rows)+'\n')
GenreList_temp = []
ActorList_temp = []
for i in range(0,rows):
    SERIALNUMBER = MOVIE.iloc[i]['MID'].replace('M','')
    TITLE = MOVIE.iloc[i]['NAME'].replace("'",'`')
    RELEASEDYEAR = int(MOVIE.iloc[i]['Release Year'])
    DIRECTORID = MOVIE.iloc[i]['Director'].replace('P','')
    PRODUCTIONCOST = int(random.uniform(10000000, 10000000000))
    PRODUCTIONCOMPANYNAME = CompanyDefaultName + str(int(random.random()*CompanyAmount))
    CONSTRACTNUMBER = int(random.uniform(1000000000, 10000000000))
    row = '''INSERT INTO Movie (SERIALNUMBER, TITLE, RELEASEDYEAR, DIRECTORID, PRODUCTIONCOST,PRODUCTIONCOMPANYNAME,CONSTRACTNUMBER) VALUES ({},'{}',{},{},{},'{}',{});'''.format(SERIALNUMBER,TITLE,RELEASEDYEAR,DIRECTORID, PRODUCTIONCOST,PRODUCTIONCOMPANYNAME,CONSTRACTNUMBER)
    f.write(row+'\n')

    Genres = MOVIE.iloc[i]['Genre'].split(",")
    for Genre in Genres:
        insertGenre = '''INSERT INTO Genre (MOVIEID, Genre) VALUES ({},'{}');'''.format(SERIALNUMBER, Genre.replace(' ','').upper())
        GenreList_temp.append(insertGenre)

    ActorList = MOVIE.iloc[i]['Actor List'].split(",")
    for actor in ActorList:
        MovieActor = '''INSERT INTO MovieActor (MOVIEID, ActorID) VALUES ({},{});'''.format(SERIALNUMBER, actor.replace('P',''))
        ActorList_temp.append(MovieActor)

# Genre
f.write('--Genre rows:{}'.format(len(GenreList_temp))+'\n')

for row in GenreList_temp:
    f.write(row+'\n')
    print(row)

# ActorList
# f.write('--ActorList rows:{}'.format(len(ActorList_temp))+'\n')
# for row in ActorList_temp:
#     f.write(row+'\n')
#     print(row)

# RATING
rows = RATING.count(axis='rows')['rating']
f.write('--RATING rows:{}'.format(rows)+'\n')

for i in range(0,rows):
    IMDBID = RATING.iloc[i]['IMDB ID'].replace('ID','')
    MID = RATING.iloc[i]['MID'].replace('M','')
    Rate = float(RATING.iloc[i]['rating'])
    # datetime = str(RATING.iloc[i]['date_year'])+str(RATING.iloc[i]['date_month'])+str(RATING.iloc[i]['date_day'])str(RATING.iloc[i]['date_hour'])+str(RATING.iloc[i]['date_minute'])+str(RATING.iloc[i]['date_second'])
    Year = RATING.iloc[i]['date_year']
    row = '''INSERT INTO MovieRate (UserID, MovieID, Rate,Year) VALUES ({},{},{},{});'''.format(IMDBID,MID,Rate,Year)
    f.write(row+'\n')
    print(row)

# ROLES&ActorList
rows = ROLES.count(axis='rows')['Role']
f.write('--ROLE rows:{}'.format(rows)+'\n')
for i in range(0,rows):
    Person = ROLES.iloc[i]['Person'].replace('P','')
    MID = ROLES.iloc[i]['Movie'].replace('M','')
    Role = ROLES.iloc[i]['Role']
    row = '''INSERT INTO MovieActor (MOVIEID, ActorID, Role) VALUES ({},{},'{}');'''.format(MID, Person ,Role)
    # row = '''UPDATE MovieActor SET Role = '{}' WHERE ActorID = {} AND MovieID = {};'''.format(Role,Person,MID)
    f.write(row+'\n')
    print(row)
f.close()
