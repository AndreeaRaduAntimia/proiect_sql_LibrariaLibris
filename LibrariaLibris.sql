create database LibrariaLibris;
use LibrariaLibris;

#Instrucțiuni DDL (cel puțin una dintre CREATE, ALTER, DROP, TRUNCATE)-->> am fol crate, drop si truncate
#creare tabele 
create table Carti
(ID int not null auto_increment,
NumeCarte varcharacter(70) not null,
AutorID int,
DataAparitie date,
GenID int,
Pret decimal(10, 2),
primary key(ID)
);

desc Carti;

create table Autori
(ID int not null auto_increment,
Nume varchar(100),
primary key(ID)
);

desc Autori;

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

create table Comenzi
(ID int not null auto_increment,
IDclient int,
IDcarte int,
DataComenzii date,
primary key(ID)
);

desc Comenzi;

drop table Autori;
drop table Carti;
drop table Clienti;
drop table Comenzi;
drop table Gen;

truncate Autori;

#Instrucțiuni de DML (INSERT, DELETE, UPDATE) -->> am folosit insert, rename, update
# inserare date in tabele

insert into Autori (Nume)values
('Zoulfa Katouh'),
('Franz Kafka'),
('Genki Kawamura'),
('Osho');

select *from Autori;

insert into Carti (NumeCarte, AutorID, DataAparitie, GenID, Pret)values
('Cat timp infloresc lamaii', 1, '2023-01-05', 1, '39.92'),
('Metamorfoza', 2, '2022-06-10', 2, '19.12'),
('Daca pisicile ar disparea din lume', 3, '2020-07-01', 3, '25.60'),
('Frica', 4, '2021-09-25', 4, '31.99');

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


#adaugam un Foreign keys; cheia secundara 'AutorID' care face referire la cheia primara 'ID' din tabela 'Autori';
alter table Carti add constraint foreign key (AutorID) references Autori(ID);

#adaugam un al doilea Foreign keys; cheia secundara 'IDclient' care face referire la cheia primara 'ID' din tabela 'Clienti'
alter table Comenzi add constraint foreign key (IDclient) references Clienti(ID);

#adaugam un al treilea Foreign keys;cheia secundara 'GenID' care face referire la cheia primara 'ID' din tabela 'Gen'
alter table Carti add foreign key (GenID) references Gen(ID);

alter table Gen
rename to GenCarte;

update GenCarte set GenCarte="Literatura" where ID=1;

select *from GenCarte;

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
where ID like '2';

#filtrări cu AND și OR

select *from Carti where GenID >= 1 AND DataAparitie > '2022-07-01';
select *from Carti where GenID =2 OR GenID =4;

#funcții agregate, filtrări pe funcții agregate

select SUM(pret) from Carti;
select COUNT(*) as total_carti FROM Carti;
select MIN(DataAparitie) as min_DataAparitie FROM Carti;
select MAX(DataAparitie) as max_DataAparitie FROM Carti;
select AVG(Pret) from Carti;

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
select *from Comenzi order by DataComenzii desc Limit 4;

# subquery-uri
select Nume from Autori where ID IN (select AutorID from Carti where Pret > (select AVG(Pret) from Carti));