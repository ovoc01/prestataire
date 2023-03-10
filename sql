create table route_national(
    id serial primary key ,
    name varchar unique ,
    longueur float,
    width float
);

create table prestataire(
    id serial primary key ,
    nom varchar ,
    prix float default 0,
    vitesse float default 0,
    employe int default 0,
    penalite float default 0,
    dateCreation date
);

create table formule(
    idRoute int references route_national(id),
    formule varchar
);

insert into formule values(1,'4*employe+2*vitesse-2*penalite');


insert into prestataire values(default, 'SOGEA SATOM', 50000 , 60, 8, 2, '2008-01-12');

select id,nom,prix,vitesse,employe,penalite,dateCreation from prestataire order by 4*employe+2*vitesse-2*penalite desc
select longueur*2 from route_national;


create or replace view info_prestataire as
    select id,prix,nom,vitesse,employe,penalite,EXTRACT('year' FROM now()) - EXTRACT('year' FROM dateCreation) as anciennete
    from prestataire;

select id,nom,prix,vitesse,employe,penalite,anciennete,(select * from rentabilty) from info_prestataire order by (select * from rentabilty) desc;


select * from info_prestataire


create view rentabilty as select  (4*employe+2*vitesse+(1/2)*anciennete-2*penalite)/prix as rentabilty  from info_prestataire

create view formule_rn as
select * from route_national
join formule f on route_national.id = f.idRoute


select * from formule_rn where name = 'RN 1'