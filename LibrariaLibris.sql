create database LibrariaLibris;
use LibrariaLibris;

#Instrucțiuni DDL (cel puțin una dintre CREATE, ALTER, DROP, TRUNCATE)-->> am fol crate, drop si truncate
#creare tabele 
create table Carti
(ID int not null auto_increment,
NumeCarte varchar(70) not null,
AutorID int,
DataAparitie date,
GenID int,
Pret decimal(10, 2),
primary key(ID)
);

desc Carti;
drop table Carti;

alter table Carti add Editura varchar(50) not null;


create table Autori
(ID int not null auto_increment,
Nume varchar(100),
primary key(ID)
);

desc Autori;

alter table Autori
add Prenume varchar(50);

alter table Autori
drop column Prenume;


create table Clienti
(ID int not null auto_increment,
NumeClient varchar(100),
Email varchar(50),
primary key(ID)
);


desc Clienti;

create table Gen
(ID int not null auto_increment,
GenCarte varchar(20) not null,
primary key(ID)
);

desc Gen;

drop table Gen;

create table Comenzi
(ID int not null auto_increment,
IDclient int,
IDcarte int,
DataComenzii date,
primary key(ID)
);


truncate Comenzi;
drop table Comenzi;


desc Comenzi;


#Instrucțiuni de DML (INSERT, DELETE, UPDATE) -->> am folosit insert, rename, update
# inserare date in tabele

insert into Autori (Nume)values
('Zoulfa Katouh'),
('Franz Kafka'),
('Genki Kawamura'),
('Osho');

select *from Autori;

insert into Carti (NumeCarte, AutorID, DataAparitie, GenID, Pret, Editura)values
('Cat timp infloresc lamaii', 1, '2023-01-05', 1, '39.92', 'BOOKZONE'),
('Metamorfoza', 2, '2022-06-10', 2, '19.12', 'CARTEX'),
('Daca pisicile ar disparea din lume', 3, '2020-07-01', 3, '25.60', 'HUMANITAS'),
('Frica', 4, '2021-09-25', 4, '31.99', 'LITERA');


select *from Carti;


insert into Clienti (NumeClient, Email)values
('Radu Andreea', 'andreea.antimia@gmail.com'),
('Kiss Oana', 'oana.kiss@gmail.com'),
('Ene Elena', 'elena.ene@yahoo.com');

select *from Clienti;

insert into Comenzi(IDclient, IDcarte, DataComenzii)values
(1, 2456, '2023-09-30'),
(2, 4560, '2023-08-27'),
(3, 7834, '2023-10-03');

select *from Comenzi;

insert into Gen(GenCarte)values
('Beletristica'),
('Nuvela'),
('Ficțiune literară'),
('Dezvoltare personala');

select *from GenCarte;


#adaugam un Foreign keys; cheia secundara 'AutorID' care face referire la cheia primara 'ID' din tabela 'Autori';
alter table Carti add constraint foreign key (AutorID) references Autori(ID);

#adaugam un al doilea Foreign keys; cheia secundara 'IDclient' care face referire la cheia primara 'ID' din tabela 'Clienti'
alter table Comenzi add constraint foreign key (IDclient) references Clienti(ID);

#adaugam un al treilea Foreign keys;cheia secundara 'GenID' care face referire la cheia primara 'ID' din tabela 'Gen'
alter table Carti add foreign key (GenID) references Gen(ID);

alter table Gen
rename to GenCarte;

update GenCarte set GenCarte="Literatura" where ID=1;

update Carti set Pret=49.90 where ID=1; 

update Comenzi set DataComenzii="2024-05-01" where ID=1;

update Clienti set NumeClient="Radu Andreea-Roxana" where ID=1;

update Comenzi set IDcarte="0700" where ID=3;

alter table Carti
add Reducere int;

alter table Carti
drop column Reducere;

delete from Clienti
where ID = 2;

delete from Comenzi where ID=3;


select *from Clienti;


#(select all, select câteva coloane, filtrare cu where, filtrări cu like, filtrări cu AND și OR, 
#funcții agregate, filtrări pe funcții agregate, joinuri - inner join, left join, right join, cross
#join, limite, order by, chei primare, chei secundare)

#select all tabel carti

select *from Carti;

#selectare anumite coloane din tabela Carti

select NumeCarte, Pret  from Carti;

#filtrare cu where

select * from Clienti where NumeClient = 'Radu Andreea';

#filtrări cu like

select * from Carti where NumeCarte like '%pisicile%';

select *from Clienti 
where ID like '3';

#filtrări cu AND și OR

select *from Carti where GenID >= 1 AND DataAparitie > '2022-07-01';
select *from Carti where GenID =2 OR GenID =4;
select *from Carti where DataAparitie >= '2021-09-25' OR Pret > '20.00';

# filtrari cu NOT
select *from Carti where NOT ID=4;

#funcții agregate, filtrări pe funcții agregate

select SUM(pret) from Carti;
select COUNT(*) as total_carti FROM Carti;
select MIN(DataAparitie) as min_DataAparitie FROM Carti;
select MAX(DataAparitie) as max_DataAparitie FROM Carti;
select AVG(Pret) from Carti;

# Această interogare returnează o listă cu numele autorilor și suma totală a prețurilor cărților lor.
select Autori.Nume as NumeAutor, SUM(Carti.Pret) as SumaTotala from Carti inner join Autori on Carti.AutorID = Autori.ID group by Autori.Nume;

# Această interogare returnează o listă cu genurile de cărți și numărul total de cărți din fiecare gen.
select Gen.GenCarte as NumeGen, COUNT(Carti.ID) as NumarCarti from Carti inner join Gen on Carti.GenID = Gen.ID group by Gen.GenCarte;

# Această interogare returnează o listă cu genurile de cărți și prețul mediu al cărților din fiecare gen.
select Gen.GenCarte as NumeGen, AVG(Carti.Pret) as PretMediu from Carti inner join Gen on Carti.GenID = Gen.ID group by Gen.GenCarte;

# Această interogare returnează o listă de autori și suma totală a prețurilor cărților lor, dar numai pentru acei autori pentru care suma totală este mai mare de 50.
select Autori.Nume as NumeAutor, SUM(Carti.Pret) as SumaTotala from Carti inner join Autori on Carti.AutorID = Autori.ID group by Autori.Nume having SUM(Carti.Pret) > 50;


#joinuri - inner join, left join, right join, cross join, limite, order by

# Inner Join intre Carti si Autori

select Carti.NumeCarte, Autori.Nume from Carti inner join Autori on Carti.AutorID = Autori.ID;

# left join intre Carti si Comenzi

select Carti.NumeCarte, Comenzi.DataComenzii from Carti left join Comenzi on Carti.ID = Comenzi.ID;

# right join între Comenzi și Clienti

select Comenzi.ID, Clienti.NumeClient from Comenzi right join Clienti on Comenzi.IDclient = Clienti.ID;

# cross join între Carti și GenCarte

select Carti.NumeCarte, GenCarte.GenCarte from Carti cross join GenCarte;

# order by

select *from Carti order by Pret;

# limite
select *from Comenzi order by DataComenzii desc Limit 2;

# group by

select Gen.GenCarte, SUM(Carti.Pret) as SumaTotala from Carti inner join Gen on Carti.GenID = Gen.ID group by Gen.GenCarte;

select AVG(Pret) as PretMediu from Carti;

select Autori.Nume from Autori join Carti on Autori.ID = Carti.AutorID group by Autori.Nume having MAX(Carti.Pret) > (SELECT AVG(Pret) from Carti);

# having 

SELECT Gen.GenCarte, SUM(Carti.Pret) AS SumaTotala FROM Carti INNER JOIN Gen ON Carti.GenID = Gen.ID GROUP BY Gen.GenCarte HAVING SUM(Carti.Pret) > 30;

# subquery-uri
select Nume from Autori where ID in (select AutorID from Carti where Pret > (select AVG(Pret) from Carti));

select 
    NumeCarte, 
    Pret, 
    (select AVG(Pret) from Carti) as PretMediu,
    case
        when Pret > (select AVG(Pret) from Carti) then 'Peste Medie'
        else 'Sub Medie'
    end as ComparatiePret
from
    Carti;
    
select
    Gen.GenCarte, 
    SUM(Carti.Pret) as SumaTotala
from
    Carti
inner join
    Gen on Carti.GenID = Gen.ID
group by 
    Gen.GenCarte
having
    SUM(Carti.Pret) > 
    (select SUM(Pret)/COUNT(distinct GenID) from Carti);