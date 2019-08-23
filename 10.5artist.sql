/*Problem 1:*/
create table Artist (Name varchar(30) PRIMARY KEY, Type varchar(6), Country varchar(30));

create table Album (Title varchar(30), Artist varchar(30), Year numeric(4), Type varchar(11), Rating numeric(1), PRIMARY KEY(Title,Artist),FOREIGN KEY(Artist) REFERENCES Artist(Name));

create table Tracklist(Album_Title varchar(30), Album_Artist varchar(30), Track_No numeric(2,0), Track_Title varchar(30), Track_Length time, PRIMARY KEY (Album_Title, Album_Artist, Track_No), FOREIGN KEY(Album_Title,Album_Artist) REFERENCES  Album(Title,Artist));

insert into Artist values ('Michael Jackson','PERSON','United States');
insert into Artist values ('Usher','PERSON','United States');
insert into Artist values ('Eric Billenger','PERSON','United States');
insert into Artist values ('Future','PERSON','United States');
insert into Artist values ('Davdio','PERSON','Nigeria');


insert into Album values ('Thriller','Michael Jackson', 1982, 'STUDIO', 5);
insert into Album values ('8701','Usher',2001,'STUDIO',2);
insert into Album values ('Eazy Call','Eric Billenger',2018,'STUDIO',4);
insert into Album values ('The WIZRD','Future',2018,'STUDIO',3);
insert into Album values ('Singles','Davido',2019,'COMPILATION',1);

insert into Tracklist values ('Thriller','Michael Jackson',2, 'Beat It','00:04:18');
insert into Tracklist values ('Thriller','Michael Jackson',1, 'Billie Jean','00:04:54');
insert into Tracklist values ('8701','Usher',1,'U Got it Bad','00:04:08');
insert into Tracklist values ('8701','Usher',2,'U Remind Me','00:04:27');
insert into Tracklist values ('Eazy Call','Eric Billenger',1,'Legs','00:03:53');
insert into Tracklist values ('Eazy Call','Eric Billenger',2,'Main Thang','00:03:29');
insert into Tracklist values ('The WIZRD','Future',1,'Jumpin on a Jet','00:02:17');
insert into Tracklist values ('The WIZRD','Future',2,'Cruched Up','00:02:30');
insert into Tracklist values ('Single','Davido',2,'Blow My Mind', '00:03:19');
insert into Tracklist values ('Single','Davido',3,'If','00:03:58');

/*Problem 2:*/
/*1)*/ 
SELECT Artist 
FROM Album A1 
WHERE A1.type='COMPILATION' 
AND EXISTS 
    (
    SELECT * 
    FROM Album A2 
    WHERE A2.Type='LIVE' 
    AND A1.Year = A2.Year 
    AND A1.Artist=A2.Artist
    );

/*2)*/ 
SELECT DISTINCT Artist 
FROM Album A1 
WHERE Artist NOT IN 
    ( 
    SELECT Artist 
    FROM Album A2 
    WHERE A2.Type='LIVE' 
    OR A2.Type='COMPILATION' 
    AND A1.Artist=A2.Artist
    );

/*3)*/ 
SELECT Title 
FROM Album A1 
JOIN Artist ON A1.Artist=Artist.Name 
WHERE Artist.type='BAND' 
AND EXISTS
    (
    SELECT * 
    FROM Album A2 
    WHERE A1.Rating>A2.Rating 
    AND A1.year>A2.Year 
    AND A1.Artist=A2.Artist
    );

/*4*/ 
SELECT A1.Title 
FROM Album A1 
JOIN Artist ON A1.Artist=Artist.Name 
WHERE Artist.Country='Nigeria' 
OR Artist.Country='London' 
OR Artist.Country='United States' 
OR Artist.Country='South Africa' 
AND A1.Type='LIVE' 
AND A1.Rating>(
    SELECT AVG(Rating) 
    FROM Album A2 
    WHERE A1.Year=A2.Year 
    Group By A1.Year
    );

/*5)*/ 
SELECT DISTINCT T1.Track_Title, A1.Title as Album_Title, A1.Artist 
FROM Album A1 
JOIN Tracklist T1 ON T1.Album_Artist=A1.Artist 
WHERE T1.Track_Length<'00:02:34' 
AND A1.Rating>=4 
AND A1.Year>1994;

/*6)*/ 
SELECT AVG(sum) 
FROM 
    (
    SELECT SUM(T1.Track_Length) 
    FROM Tracklist T1 
    JOIN Album A1 ON A1.Artist=T1.Album_Artist AND T1.Album_Title=A1.Title 
    WHERE A1.Year>=1990 
    AND A1.Year<2000 
    GROUP BY T1.Album_Title 
    HAVING COUNT(T1.Track_No)>=10
    ) 
AS sum;

/*7)*/ 
SELECT DISTINCT A1.Artist 
FROM ALBUM A1 
WHERE Artist NOT IN 
    (
    SELECT A2.Artist 
    FROM Album A2, Album A3 
    WHERE A2.Type='STUDIO' 
    AND A3.Type='STUDIO' 
    AND A2.Artist=A3.Artist 
    AND 
        (
        (A2.Year-A3.Year>4) 
        OR (A3.Year-A2.Year>4)
        )
   );

/*8)*/ 
SELECT DISTINCT A1.Artist 
FROM Album A1 
WHERE 
    (
    SELECT COUNT(*) 
    FROM Album A2 
    WHERE 
        (
        A2.Type='LIVE' 
        OR A2.Type='Compilation'
        ) 
    AND A2.Artist=A1.Artist 
    GROUP BY A2.Artist
    )
>
    (
    SELECT COUNT(*) 
    FROM Album A3 
    WHERE A3.TYPE='STUDIO' 
    AND A3.Artist=A1.Artist 
    GROUP BY A3.Artist
    );

/*9)*/ 
SELECT A1.Title, SUM(T1.Track_Length) 
FROM Album A1 
JOIN Tracklist T1 On A1.Title=T1.Album_Title AND A1.Artist=T1.Album_Artist 
WHERE Album_Title IN 
    (
    SELECT T2.Album_Title
    FROM Tracklist T2 
    GROUP BY T2.Album_Title 
    HAVING MAX(T2.Track_No)=COUNT(T2.Track_NO)
    )
GROUP BY A1.Title;

/*10)*/ 
SELECT DISTINCT Artist 
FROM Album 
WHERE Artist IN 
(
    SELECT A1.Artist 
    FROM Album A1 
    WHERE A1.Type='STUDIO' 
    GROUP BY A1.Artist 
    HAVING COUNT(A1.Type)>=3
) 
AND Artist IN
(
     SELECT A2.Artist 
     FROM Album A2 
     WHERE A2.Type='LIVE' 
     GROUP BY A2.Artist 
     HAVING COUNT(A2.Type)>=2
)
AND Artist IN 
(
    SELECT A3.Artist
    FROM Album A3
    WHERE A3.Type='COMPILATION' 
    GROUP BY A3.Artist 
    HAVING COUNT(A3.Type)>=1
)
AND Artist NOT IN
(
    SELECT A4.Artist 
    FROM Album A4 
    WHERE A4.Rating<3
);

/*11)*/  
SELECT COUNT(*) 
FROM 
    (
    SELECT DISTINCT Name 
    FROM Album A1 
    JOIN Artist ON A1.Artist=Artist.Name 
    WHERE Artist.Type='BAND' 
    AND Artist.Country='United States' 
    AND EXISTS 
        (
        Select A2.Year 
        FROM Album A2 
        WHERE A1.Artist=A2.Artist 
        AND A2.Year<A1.Year
        )
     ) 
AS sumBand;

/*12)*/ 
SELECT F1.Artist AS Artist, cast((C1/C2 * 2) as numeric(1,2)) as P 
FROM 
    (
        (
        SELECT A2.Artist AS ART1, count(*) AS C1 
        FROM Album A2 
        WHERE A2.Rating <3 
        GROUP BY A2.Artist
        ) 
    AS count1 
    FULL JOIN 
        (
        SELECT A2.Artist,count(*) AS C2 
        FROM Album A2 GROUP BY A2.Artist
        ) 
    AS count2 
    ON count2.Artist=count1.ART1
    ) 
AS F1 ORDER BY P;

/*13)*/  
SELECT F1.Artist 
FROM 
    (
    SELECT DISTINCT Artist 
    FROM Album A1
    JOIN Artist ON A1.Artist=Artist.Name 
    WHERE A1.Type='STUDIO' 
    ) 
AS F1
WHERE
    (
    F1.Country=A2.Country
    AND Artist!=A2.Artist
    OR F1.Country IN
        (
        SELECT Country
        FROM Artist join Album A2 on name=A2.Artist
        WHERE A2.Type='STUDIO'
        GROUP BY Country
        HAVING count(DISTINCT Artist)=1
        )
    );

/*14)*/ 
SELECT A1.Title as Higher, A2.TITLE as Lower 
FROM Album A1 
JOIN Artist Art1 ON A1.Artist=Art1.Name, Album A2 JOIN Artist Art2 ON A2.Artist=Art2.Name 
WHERE Art1.Country!=Art2.Country 
AND A1.Year=A2.Year 
AND A1.Rating>A2.Rating;


/*15)*/ 
SELECT CountTrack.Album_Title, (A1.Rating/count) AS ratio 
FROM 
    (
    Album A1 JOIN
        (
        SELECT T1.Album_Title, count(T1.Track_No) AS count 
        FROM Tracklist T1 
        GROUP BY T1.Album_Title
        )
     As CountTrack ON CountTrack.Album_Title=A1.Title
    ) 
ORDER BY ratio DESC;
