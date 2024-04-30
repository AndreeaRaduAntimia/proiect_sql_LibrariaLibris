Database Project for Libris.ro

The scope of this project is to use all the SQL knowledge gained throught the Software Testing course and apply them in practice.

Application under test: https://www.libris.ro/

Tools used: MySQL Workbench

Database description: I created a database that contains 5 tables: Books, Authors, Genre, Orders and Customers. These tables are connected by foreign keys so that we can perform queries.
<h1>Database Project for **Libris.ro**</h1>

Database description: **I created a database that contains 5 tables: Books, Authors, Genre, Orders and Customers. These tables are connected by foreign keys so that we can perform queries.**

<ol>
<li>Database Schema </li>
<br>
You can find below the database schema that was generated through Reverse Engineer and which contains all the tables and the relationships between them.

The tables are connected in the following way:

<ul>
  <li> **Tabel 'Carti'**  is connected with **Tabel 'Autor'** through a **Many-to-many** relationship which was implemented through **Autor.ID** as a primary key and **Carti.AutorID** as a foreign key</li>

  <li> **Tabel 'Carti'**  is connected with **Tabel 'Gen'** through a **Many-to-many** relationship which was implemented through **Gen.ID** as a primary key and **Carti.GenID** as a foreign key</li>

  <li> **Tabel 'Clienti'**  is connected with **Tabel 'Comenzi'** through a **1:1** relationship which was implemented through **Clienti.ID** as a primary key and **Comenzi.nume_IDclient** as a foreign key</li>

<li>Database Queries</li><br>

<ol type="a">
  <li>DDL (Data Definition Language)</li>

  The following instructions were written in the scope of CREATING the structure of the database (CREATE INSTRUCTIONS)

  **create table Carti
  (ID int not null auto_increment,
  NumeCarte varchar(70) not null,
  AutorID int,
  DataAparitie date,
  GenID int,
  Pret decimal(10, 2),
  primary key(ID)
  );**

  **create table Autori
  (ID int not null auto_increment,
  Nume varchar(100),
  primary key(ID)
  );**

  **create table Clienti
  (ID int not null auto_increment,
  NumeClient varchar(100),
  Email varchar(50),
  primary key(ID)
  );**

  **create table Gen
  (ID int not null auto_increment,
  GenCarte varchar(20) not null,
  primary key(ID)
  );**

  **create table Comenzi
  (ID int not null auto_increment,
  IDclient int,
  IDcarte int,
  DataComenzii date,
  primary key(ID)
  );**

  After the database and the tables have been created, a few ALTER instructions were written in order to update the structure of the database, as described below:

  **
  alter table Carti add Editura varchar(50) not null;

  alter table Autori add Prenume varchar(50);

  alter table Autori drop column Prenume;

  drop table Gen;

  alter table Gen rename to GenCarte;

  alter table Carti add Reducere int;

  alter table Carti drop column Reducere;
  **


  <li>DML (Data Manipulation Language)</li>

  In order to be able to use the database I populated the tables with various data necessary in order to perform queries and manipulate the data.
  In the testing process, this necessary data is identified in the Test Design phase and created in the Test Implementation phase.

  Below you can find all the insert instructions that were created in the scope of this project:

  **insert into Autori (Nume)values
  ('Zoulfa Katouh'),
  ('Franz Kafka'),
  ('Genki Kawamura'),
  ('Osho');**


  **insert into Carti (NumeCarte, AutorID, DataAparitie, GenID, Pret, Editura)values
  ('Cat timp infloresc lamaii', 1, '2023-01-05', 1, '39.92', 'BOOKZONE'),
  ('Metamorfoza', 2, '2022-06-10', 2, '19.12', 'CARTEX'),
  ('Daca pisicile ar disparea din lume', 3, '2020-07-01', 3, '25.60', 'HUMANITAS'),
  ('Frica', 4, '2021-09-25', 4, '31.99', 'LITERA');**


  **insert into Clienti (NumeClient, Email)values
  ('Radu Andreea', 'andreea.antimia@gmail.com'),
  ('Kiss Oana', 'oana.kiss@gmail.com'),
  ('Ene Elena', 'elena.ene@yahoo.com');**


  **insert into Comenzi(IDclient, IDcarte, DataComenzii)values
  (1, 2456, '2023-09-30'),
  (2, 4560, '2023-08-27'),
  (3, 7834, '2023-10-03');**


  **insert into Gen(GenCarte)values
  ('Beletristica'),
  ('Nuvela'),
  ('Ficțiune literară'),
  ('Dezvoltare personala');**

  After the insert, in order to prepare the data to be better suited for the testing process, I updated some data in the following way:

  ** update GenCarte set GenCarte="Literatura" where ID=1;**


  <li>DQL (Data Query Language)</li>

After the testing process, I deleted the data that was no longer relevant in order to preserve the database clean:

**delete from Clienti
where ID = 2;**

In order to simulate various scenarios that might happen in real life I created the following queries that would cover multiple potential real-life situations:

** select *from Clienti where NumeClient = 'Radu Andreea';**

** select *from Carti where GenID >= 1 AND DataAparitie > '2022-07-01';**

** select *from  Carti where GenID =2 OR GenID =4;**

** select *from Carti where NOT ID=4;**

** select * from Carti where NumeCarte like '%pisicile%';
select *from Clienti where ID like '3';**

** select Carti.NumeCarte, Autori.Nume from Carti inner join Autori on Carti.AutorID = Autori.ID;**

** select Carti.NumeCarte, Comenzi.DataComenzii from Carti left join Comenzi on Carti.ID = Comenzi.ID;**

** select Comenzi.ID, Clienti.NumeClient from Comenzi right join Clienti on Comenzi.IDclient = Clienti.ID;**

** select Carti.NumeCarte, GenCarte.GenCarte from Carti cross join GenCarte;**

** select SUM(pret) from Carti;**
select COUNT(*) as total_carti FROM Carti;
select MIN(DataAparitie) as min_DataAparitie FROM Carti;
select MAX(DataAparitie) as max_DataAparitie FROM Carti;
select AVG(Pret) from Carti;**

** select Gen.GenCarte, SUM(Carti.Pret) as SumaTotala from Carti inner join Gen on Carti.GenID = Gen.ID group by Gen.GenCarte;**

** select Gen.GenCarte, SUM(Carti.Pret) AS SumaTotala FROM Carti INNER JOIN Gen ON Carti.GenID = Gen.ID GROUP BY Gen.GenCarte HAVING SUM(Carti.Pret) > 30;**

** select Nume from Autori where ID IN (select AutorID from Carti where Pret > (select AVG(Pret) from Carti));**

</ol>

<li>Conclusions</li>

**Working on this SQL project I learned to create a database, to be able to access information from it and to improve my knowledge gained during the course.
Since I lost the database I worked on initially, I had to start the project from the beginning, thus I managed to better integrate and deepen the information learned.**

</ol>
