
Student NAME: Yu-Chan Huang
DB NAME: db11g
Tables(total 24): 
    VOTENONHELPFUL		   
    VOTEHELPFUL 		   
    TVSERIES			   
    TVSERIERATE 		   
    SCENES			       
    REVIEWS			       
    REGULARACTOR		   
    PROFILEPICTURE		   
    PRODUCTIONCOMPANY	   
    PICTURE			       
    PERSONPICTURE		   
    NOMINATIONS 		   
    MOVIERATE			   
    MOVIEACTOR			   
    MOVIE			       
    MARRY			       
    IMDBUSER			   
    IMDBPERSON			   
    GUESTACTOR			   
    GUARDIAN			   
    EPISODE			       
    GENRE			       
    COMMENTS			   
    AWARDS			       

Result of query files:

q1.
    FIRSTNAME	     LASTNAME
    -------------------- --------------------
    Ewan		     McGregor
    Natalie 	     Portman
    John		     Boyega
    Oscar		     Isaac
    Liam		     Neeson
    Hayden		     Christensen
    Daisy		     Ridley

q2.
    NAME					    COUNTING
    ----------------------------------------- ----------
    Steven Spielberg				    11
    Luc  Besson					        10
    Brian  de forma 				    9

q3.
    NAME
    -----------------------------------------
    TITLE
    --------------------------------------------------------------------------------
    RELEASEDYEAR
    ------------
    Brian  de forma
    Lights Out
        2016

    Luc  Besson
    My big fat greek wedding
        2000

    NAME
    -----------------------------------------
    TITLE
    --------------------------------------------------------------------------------
    RELEASEDYEAR
    ------------

    Barry Jenkins
    Moonlight
        2016

    Luc  Besson
    The Big Blue

    NAME
    -----------------------------------------
    TITLE
    --------------------------------------------------------------------------------
    RELEASEDYEAR
    ------------
        1988

    Steven Spielberg
    Lincoln
        2012

    Brian  de forma

    NAME
    -----------------------------------------
    TITLE
    --------------------------------------------------------------------------------
    RELEASEDYEAR
    ------------
    Get To Know Your Rabbit
        1972


    6 rows selected.

q4.
    FIRSTNAME	     LASTNAME		     ACTORID   COUNTING
    -------------------- -------------------- ---------- ----------
    Harrison	     Ford			  34	      3
    Tom		        Hanks			   9	      3

q5.
    ACTORID     FIRSTNAME		    LASTNAME
    ---------- -------------------- --------------------
	9           Tom			        Hanks

q6.
    TITLE
    ------------------------------------------------------------------------------------------------------------------------------------------------------
    RATINGSPAN
    ----------
    Angels and Daemons
        4.5

    Moonlight
        4.5

    Lincoln
        4


    TITLE
    ------------------------------------------------------------------------------------------------------------------------------------------------------
    RATINGSPAN
    ----------
    Schindler`s List
        3.5

    Mr. and Mrs Smith
        3.5

    Indiana Jones and the Kingdom of the Crystal Skull
        3


    TITLE
    ------------------------------------------------------------------------------------------------------------------------------------------------------
    RATINGSPAN
    ----------
    Scarface
        3

    Arthur and the Invisibles
        3

    Star Wars: Episode II - Attack of the Clones
        2.5


    TITLE
    ------------------------------------------------------------------------------------------------------------------------------------------------------
    RATINGSPAN
    ----------
    Star Wars: The Force Awakens
        2.5

    Mission: Impossible
        2.5

    Her
        2.5


    TITLE
    ------------------------------------------------------------------------------------------------------------------------------------------------------
    RATINGSPAN
    ----------
    Star Wars: Episode III - Revenge of the Sith
        2.5

    Arthur and the Revenge of Maltazard
        2

    Star Wars: Episode I - The Phantom Menace
        2


    TITLE
    ------------------------------------------------------------------------------------------------------------------------------------------------------
    RATINGSPAN
    ----------
    Barely Lethal
        2

    Scent of a women
        2

    The God Father part II
        2


    TITLE
    ------------------------------------------------------------------------------------------------------------------------------------------------------
    RATINGSPAN
    ----------
    Indiana Jones and the Last Crusade
        2

    Catch me if you can
        2

    The Da Vinci Code
        2


    TITLE
    ------------------------------------------------------------------------------------------------------------------------------------------------------
    RATINGSPAN
    ----------
    Saving Private Ryan
        2

    Lights Out
        1.5

    The adventures of Tintin
        1.5


    TITLE
    ------------------------------------------------------------------------------------------------------------------------------------------------------
    RATINGSPAN
    ----------
    Indiana Jones and the Temple of Doom
        1.5

    The Terminal
        1.5

    Arthur 3: The War of the Two Worlds
        1.5


    TITLE
    ------------------------------------------------------------------------------------------------------------------------------------------------------
    RATINGSPAN
    ----------
    Arthur and the Invisibles: The Making of the Year`s Greatest Adventure
        1

    The Island
        1

    Wise Guys
        1


    TITLE
    ------------------------------------------------------------------------------------------------------------------------------------------------------
    RATINGSPAN
    ----------
    Minority Report
        1

    The Man with one red shoe
        1

    Lucy
        .5


    TITLE
    ------------------------------------------------------------------------------------------------------------------------------------------------------
    RATINGSPAN
    ----------
    The Polar Express
        .5

    War Horse
        .5

    My big fat greek wedding
        .5


    TITLE
    ------------------------------------------------------------------------------------------------------------------------------------------------------
    RATINGSPAN
    ----------
    The Black Dahlia
        0

    The Big Blue
        0

    Get To Know Your Rabbit
        0


    39 rows selected.

q7.
    ACTORNAME				  ACTRESSNAME				    TOGETHERCOUNTING
    ----------------------------------------- ----------------------------------------- ----------------
    Ewan McGregor				  Natalie Portman					   3
    Freddie Highmore			  Mia Farrow						   2
    Morgan	Freeman 			  Scarlett  Johanson				   2
    Hayden Christensen			  Natalie Portman					   2
    Tom  Hanks				      Jessica  Alba 					   2

q8.
    	ID FIRSTNAME		LASTNAME
    ---------- -------------------- --------------------
        9 Tom			Hanks

q9.
    THEABSDIFFERENCE
    -------------
    .253903509

q10.
    ACTORID     FIRSTNAME		LASTNAME
    ---------- -------------------- --------------------
	18          Jennifer		Lawrence
	12          Alex 		    Parish
	10          Jessica		    Alba
	13          Leonardo		DiCaprio
	 7          Angelina		Jolie
	11          Catherine		Jones
	 3          Scarlett		Johanson

    7 rows selected.