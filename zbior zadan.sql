-- Rafa³ Ciesnowski
-- 253982

-- 1.1
select * from pracownik;
-- 1.2
select imie from pracownik;
-- 1.3
select imie, nazwisko, dzial from pracownik;
-- 2.1
select imie, nazwisko, pensja from pracownik order by pensja desc;
-- 2.2
select imie, nazwisko from pracownik order by nazwisko, imie asc;
-- 2.3
select nazwisko, dzial, stanowisko from pracownik order by dzial asc, stanowisko desc;
-- 3.1
select distinct dzial from pracownik;
-- 3.2
select distinct dzial, stanowisko from pracownik;
-- 3.3
select distinct dzial, stanowisko from pracownik order by dzial, stanowisko desc;
-- 4.1
select imie, nazwisko from pracownik where imie='Jan';
-- 4.2
select imie, nazwisko from pracownik where stanowisko='sprzedawca';
-- 4.3
select imie, nazwisko, pensja from pracownik where pensja>1500 order by pensja desc;
-- 5.1
select imie, nazwisko, dzial, stanowisko from pracownik where dzial='obsluga klienta' and stanowisko='sprzedawca'
-- 5.2
select imie, nazwisko, dzial, stanowisko from pracownik where dzial='techniczny' and (stanowisko='kierownik' or stanowisko='sprzedawca');
-- 5.3
select * from samochod where marka!='Fiat' and marka!='Ford';
-- 6.1
select * from samochod where marka in ('Mercedes','Seat','Opel'); 
-- 6.2
select imie, nazwisko, data_zatr from pracownik where imie in ('Anna', 'Marzena', 'Alicja');
-- 6.3
select imie, nazwisko, miasto from klient where miasto not in ('Warszawa', 'Wroc³aw');
-- 7.1
select imie, nazwisko from klient where nazwisko like '%k%';
-- 7.2
select imie, nazwisko from klient where nazwisko like 'D%ski';
-- 7.3
select imie, nazwisko from klient where nazwisko like '_o%' or nazwisko like '_a%';
-- 8.1
select * from samochod where poj_silnika between 1100 and 1600;
-- 8.2
select * from pracownicy where zatrudnienie between '1997-01-01' and '1997-12-31';
-- 8.3
select * from samochod where przebieg between 10000 and 20000 or przebieg between 30000 and 40000;
-- 9.1
select * from pracownik where dodatek is null;
-- 9.2
select * from klient where nr_karty_kredyt is not null;
-- 9.3
select imie, nazwisko, coalesce(dodatek, 0) from pracownik;
-- 10.1
select imie, nazwisko, pensja, coalesce(dodatek,0), pensja+coalesce(dodatek,0) as do_zaplaty from pracownik;
-- 10.2
select imie, nazwisko, 1.5*coalesce(pensja,0) as nowa_pensja from pracownik;
-- 10.3
select imie, nazwisko, 0.01*(pensja+coalesce(dodatek,0)) as jeden_procent from pracownik order by jeden_procent asc;
-- 11.1
select top 1 imie, nazwisko from pracownik order by data_zatr asc;
-- 11.2
select top 4 nazwisko, imie from pracownik order by nazwisko, imie asc;
-- 11.3
select top 1 * from wypozyczenie order by data_wyp desc;
-- 12.1
select imie, nazwisko, data_zatr from pracownik where month(data_zatr)=5 order by nazwisko asc, imie asc;
-- 12.2
select imie, nazwisko, datediff(day, data_zatr, getdate()) as staz from pracownik order by staz desc;
-- 12.3
select marka, typ, datediff(year, data_prod, getdate()) as wiek from samochod order by wiek desc;
-- 13.1
select imie, nazwisko, left(imie,1)+'.'+left(nazwisko,1)+'.' as inicjaly from klient order by inicjaly, nazwisko, imie;
-- 13.2
select upper(left(imie,1))+lower(right(imie, len(imie)-1)) as imie,
upper(left(nazwisko,1))+lower(right(nazwisko, len(nazwisko)-1)) as nazwisko
from pracownik;
-- 13.3
select imie, nazwisko, stuff(nr_karty_kredyt, 6, 6, 'xxxxxx')  from klient;
-- 14.1
update pracownik set dodatek=50 where dodatek is null;
-- 14.2
update klient set imie='Jerzy', nazwisko='Nowak' where id_klient=10;
-- 14.3
update pracownik set dodatek+=100 where pensja<1500;
-- 15.1
delete from klient where id_klient=17;
-- 15.2
delete from wypozyczenie where id_klient=17;
-- 15.3
delete from samochod where przebieg>60000;
-- 16.1
insert into klient (id_klient, imie, nazwisko, ulica, numer, kod, miasto, telefon)
values(121, 'Adam', 'Cichy', 'korzenna', '12', '00-950', 'Warszawa', '123-454-321');
-- 16.2
insert into samochod (id_samochod, marka, typ, data_prod, kolor, poj_silnika, przebieg)
values (50, 'Skoda', 'Octavia', '2012-09-01 00:00:00.000', 'srebrny', 1896, 5000);
-- 16.3
insert into miejsce (id_miejsce, ulica, numer, miasto, kod, telefon, uwagi)
values (6, 'Lewartowskiego', 12, 'warszawa', '00-950', '501-501-501', null);
insert into pracownik (id_pracownik, imie, nazwisko, data_zatr, dzial, stanowisko, pensja, dodatek, id_miejsce, telefon)
values (6, 'Alojzy', 'Mikos', '2010-08-11 00:00:00.000', 'zaopatrzenie', 'magazynier', 3000, 50, 5, '501-501-501'); 
--17.1
select s.id_samochod, s.marka, s.typ, w.data_wyp, w.data_odd
from samochod s inner join wypozyczenie w on s.id_samochod=w.id_samochod
where w.data_odd is null;
--17.2
select k.imie, k.nazwisko, w.id_samochod, w.data_wyp
from klient k inner join wypozyczenie w on k.id_klient=w.id_klient
where w.data_odd is null
order by k.nazwisko, k.imie;
--17.3
select k.imie, k.nazwisko, w.data_wyp, w.kaucja
from klient k inner join wypozyczenie w on k.id_klient=w.id_klient
where w.kaucja is not null;
--18.1 
select k.imie, k.nazwisko, w.data_wyp, s.marka, s.typ
from klient k inner join wypozyczenie w on k.id_klient=w.id_klient
inner join samochod s on w.id_samochod=s.id_samochod
order by k.nazwisko, k.imie, s.marka, s.typ;
--18.2
select m.ulica, m.numer, s.marka, s.typ
from miejsce m inner join wypozyczenie w on m.id_miejsce=w.id_miejsca_wyp
inner join samochod s on w.id_samochod=s.id_samochod
order by m.ulica, m.numer, s.marka, s.typ;
--18.3
select s.id_samochod, k.nazwisko, k.imie
from samochod s inner join wypozyczenie w on s.id_samochod=w.id_samochod
inner join klient k on k.id_klient=w.id_klient
order by s.id_samochod, k.nazwisko, k.imie;
--19.1
select max(pensja) from pracownik; 
--19.2
select avg(pensja) from pracownik;
--19.3
select min(data_prod) from samochod;
--20.1 
select k.imie, k.nazwisko, count(w.id_klient) as ilosc_wypozyczen
from klient k left join wypozyczenie w on k.id_klient=w.id_klient
group by k.imie, k.nazwisko, k.id_klient
order by count(w.id_klient) desc;
--20.2
select s.id_samochod, s.marka, s.typ, count(w.id_samochod) as ilosc_wypozyczen
from samochod s left join wypozyczenie w on s.id_samochod=w.id_samochod
group by s.id_samochod, s.marka, s.typ
order by count(w.id_samochod);
--20.3
select p.imie, p.nazwisko, count(w.id_pracow_wyp) as ilosc_wypozyczen
from pracownik p left join wypozyczenie w on p.id_pracownik=w.id_pracow_wyp
group by p.imie, p.nazwisko, p.id_pracownik
order by ilosc_wypozyczen;
--21.1 
select k.imie, k.nazwisko, count(w.id_klient) as ilosc_wypozyczen
from klient k inner join wypozyczenie w on k.id_klient=w.id_klient
group by k.imie, k.nazwisko, k.id_klient
having count(w.id_klient)>=2
order by nazwisko asc, imie asc;
--21.2
select s.id_samochod, s.marka, s.typ, count(w.id_samochod) as ilosc_wypozyczen
from samochod s left join wypozyczenie w on s.id_samochod=w.id_samochod
group by s.id_samochod, s.marka, s.typ
having count(w.id_samochod)>=5
order by s.marka, s.typ;
--21.3
select p.imie, p.nazwisko, count(w.id_pracow_wyp) as ilosc_wypozyczen
from pracownik p left join wypozyczenie w on p.id_pracownik=w.id_pracow_wyp
group by p.imie, p.nazwisko, p.id_pracownik
having count(w.id_pracow_wyp)<=20
order by ilosc_wypozyczen;
--22.1
select imie, nazwisko, pensja from pracownik where pensja=(select max(pensja) from pracownik)
--22.2
select imie, nazwisko, pensja from pracownik where pensja>(select avg(pensja) from pracownik)
--22.3
select marka, typ, data_prod from samochod where data_prod=(select min(data_prod) from samochod)
--23.1
select marka, typ, data_prod from samochod where id_samochod not in (select distinct id_samochod from wypozyczenie)
--23.2
select imie, nazwisko from klient where id_klient not in (select distinct id_klient from wypozyczenie)
--23.3
select imie, nazwisko from pracownik where id_pracownik not in (select distinct id_pracownik from wypozyczenie)
--24.1
select s.id_samochod, s.marka, s.typ
from samochod s join wypozyczenie w on s.id_samochod=w.id_samochod
group by s.id_samochod, s.marka, s.typ
having count(w.id_samochod) = 
(
select top 1 count(w.id_samochod) as ilosc
from wypozyczenie w
group by w.id_samochod
order by ilosc desc
)
order by s.marka asc, s.typ asc
--24.2
select k.id_klient, k.imie, k.nazwisko
from klient k join wypozyczenie w on k.id_klient=w.id_klient
group by k.id_klient, k.imie, k.nazwisko
having count(w.id_klient) = (
select top 1 count(w.id_klient) as ilosc
from wypozyczenie w
group by w.id_klient
order by ilosc asc
)
order by k.imie asc, k.nazwisko asc
--24.3
select p.id_pracownik, p.imie, p.nazwisko
from pracownik p join wypozyczenie w on p.id_pracownik=w.id_pracow_wyp
group by p.id_pracownik, p.imie, p.nazwisko
having count(p.id_pracownik) = (
select top 1 count(p.id_pracownik) as ilosc
from wypozyczenie w
group by w.id_pracow_wyp
order by ilosc desc
)
order by p.imie asc, p.nazwisko asc
--25.1
update pracownik set pensja=1.1*pensja where pensja < (select avg(pensja) from pracownik)
--25.2
update pracownik set dodatek=10+coalesce(dodatek, 0)
where id_pracownik in (
select p.id_pracownik from pracownik p
join wypozyczenie w on p.id_pracownik=w.id_pracow_wyp
where month(data_wyp) = 5
)
--25.3
update pracownik set pensja=pensja*0.95
where id_pracownik not in (
select p.id_pracownik from pracownik p
join wypozyczenie w on p.id_pracownik=w.id_pracow_wyp
where year(data_wyp) = 1999
)
--26.1
delete from klient where id_klient not in (select distinct id_klient from wypozyczenie)
--26.2
delete from samochod where id_samochod not in (select distinct id_samochod from wypozyczenie)
--26.3
delete from pracownik where id_pracownik not in (select distinct id_pracow_wyp from wypozyczenie)
--27.1.1
select imie, nazwisko from klient
union
select imie, nazwisko from pracownik order by 2, 1
--27.1.2
select imie, nazwisko from klient
union all
select imie, nazwisko from pracownik
order by 2,1
--27.2
select imie from klient
intersect
select imie from pracownik
union
select nazwisko from klient
intersect
select nazwisko from pracownik
--27.3
select imie, nazwisko from klient
except
select imie, nazwisko from pracownik
order by imie, nazwisko
--28.1
create table pracownik2 (
id_pracownik int identity(1,1) primary key,
imie varchar(16) not null,
nazwisko varchar(32) not null,
pesel char(11) unique,
data_zatr date default getdate(),
pensja money check(pensja>=1000)
)
--28.2
create table naprawa2 (
id_naprawa int identity(1,1) primary key,
data_przyjecia date check(data_przyjecia<=getdate()),
opis nvarchar(256) check(len(opis)>10),
zaliczka money check((zaliczka>=100) and (zaliczka<=1000))
)
--28.3
create table wykonane_naprawy2 (
id_pracownik int references pracownik2(id_pracownik),
id_naprawa int references naprawa2(id_naprawa),
data_naprawy date default getdate(),
opis_naprawy varchar(256) not null,
cena money
)
--29.1
alter table student2 alter column nazwisko varchar(20) not null;
alter table student2 add constraint unikatowa unique(nr_indeksu);
alter table student2 add constraint wysokosc check(stypendium>=1000);
alter table student2 add imie varchar(12) not null
--29.2
alter table dostawca2 add constraint unikat unique(nazwa);
alter table towar2 add nazwa varchar(20) not null;
alter table towar2 add constraint unikat unique(kod_kreskowy);
alter table towar2 add constraint id_dostawca foreign key (id_dostawca) references dostawca2(id_dostawca);
--29.3
alter table kraj2 alter column nazwa varchar(30) not null;
alter table gatunek2 alter column nazwa varchar(30) not null;
alter table zwierze2 add constraint id_gatunek foreign key (id_gatunek) references gatunek2(id_gatunek);
alter table zwierze2 add constraint id_kraj foreign key (id_kraj) references kraj2(id_kraj);
--30.1
drop table if exists kategoria2;
drop table if exists przedmiot2;
--30.2
alter table osoba2 drop column imie2;
--30.3
alter table uczen2 drop constraint uczen_nazwisko_unique;
--31.1
create table wlasciciel2 (
id_wlasciciel int identity(1,1) primary key,
imie varchar(15) not null check(len(imie)>2),
nazwisko varchar(15) not null check(len(nazwisko)>2),
data_ur date not null default getdate(),
ulica varchar(50),
numer varchar(8),
kod char(6) not null check(len(kod)=6),
miejscowosc varchar(30) not null check(len(miejscowosc)>1)
);
create table zwierze2(
id_zwierze int identity(1,1) primary key,
id_wlasciciel int references wlasciciel2(id_wlasciciel) on delete set null,  
rasa varchar(30) not null check(len(rasa)>2),
data_ur date not null default getdate(),
imie varchar(15) not null check(len(imie)>2)
)
--31.2
alter table film2_gatunek2 add constraint id_film foreign key (id_film) references film2(id_film) on delete cascade;
alter table film2_gatunek2 add constraint id_gatunek foreign key (id_gatunek) references gatunek2(id_gatunek) on delete cascade;
--31.3
alter table pracownik2 add constraint konstrejnt foreign key (id_stanowisko) references stanowisko2(id_stanowisko) on delete set null on update cascade;
--32.1
drop procedure if exists wypisz_samochody
go
create procedure wypisz_samochody @marka varchar(20) as
select * from samochod where marka=@marka;
go
execute wypisz_samochody 'opel'
--32.2
drop procedure if exists zwieksz_pensje
go
create procedure zwieksz_pensje @id int, @kwota int as
update pracownik2 set pensja=pensja+@kwota where id_pracownik=@id;
go
execute zwieksz_pensje 1,1000
--32.3
drop procedure if exists dodaj_klienta;
go
create procedure dodaj_klienta @id int, @imie varchar(20), @nazwisko varchar(20), @nr_karty int, @firma varchar(20), @ulica varchar(20), @numer varchar(20), @miasto varchar(20), @kod char(6), @nip varchar(20), @telefon varchar(20) as
insert into klient values (@id, @imie, @nazwisko, @nr_karty, @firma, @ulica, @numer, @miasto, @kod, @nip, @telefon);
go
execute dodaj_klienta 98, 'Adam', 'Borawski', null, null, 'Alba', 4, 'Belgrad', '23-000', null, '2093-20493'
select * from klient
--33.1
drop function if exists dbo.aktywnosc_klienta
go
create function dbo.aktywnosc_klienta(@id_klient int) returns int begin
	return (select COUNT(*) from wypozyczenie where id_klient = @id_klient)
end;
go
select dbo.aktywnosc_klienta(3) as ile_wyp
--33.2
drop function if exists dbo.ile_wypozyczen
go
create function dbo.ile_wypozyczen(@data_od date, @data_do date) returns int begin
	return (select COUNT(*) from wypozyczenie where (data_wyp > @data_od and data_wyp < @data_do))
end;
go
select dbo.ile_wypozyczen('2000-01-01', '2000-12-31') as ile_wypozyczen;
--33.3
drop function if exists dbo.roznica_pensji
go
create function dbo.roznica_pensji() returns money begin
	return ((select MAX(pensja) from pracownik) - (select MIN(pensja) from pracownik))
end;
go
select dbo.roznica_pensji() as roznica_pensji
--34.1
drop view if exists klient_raport
go
create view klient_raport as
select k.id_klient, k.imie, k.nazwisko, count(w.id_klient) as 'ilosc_wyp'
from klient k left join wypozyczenie w on k.id_klient = w.id_klient
group by k.id_klient, k.imie, k.nazwisko
go
select * from klient_raport where ilosc_wyp>1
--34.2
drop view if exists samochod_raport
go
create view samochod_raport as
select s.id_samochod, s.marka, s.typ, COUNT(w.id_samochod) as 'ilosc_wyp'
from samochod s left join wypozyczenie w on s.id_samochod = w.id_samochod
group by s.id_samochod, s.marka, s.typ
go
select * from samochod_raport order by ilosc_wyp desc;
--34.3
drop view if exists pracownik_raport
go
create view pracownik_raport as
select p.id_pracownik, p.imie, p.nazwisko, COUNT(w.id_pracow_wyp) as 'ilosc_wyp'
from pracownik p left join wypozyczenie w on p.id_pracownik = w.id_pracow_wyp
group by p.id_pracownik, p.imie, p.nazwisko
go
select * from pracownik_raport where ilosc_wyp > (select AVG(ilosc_wyp) from pracownik_raport)
--35.1
drop index if exists klient.klient_telefon
create unique index klient_telefon on klient(telefon);
go
--35.2
drop index if exists klient.nazwisko_imie
create clustered index nazwisko_imie on klient(nazwisko, imie);
go
--35.3
drop index if exists samochod.marka_typ
create index marka_typ on samochod(marka, typ)
go
--36.1
drop trigger if exists anuluj_usuwanie_klienta
go
create trigger anuluj_usuwanie_klienta on klient for delete as
raiserror('zabronione jest usuwanie klientow', 1, 2) rollback
go
delete from klient;
--36.2
drop trigger if exists mala_pensja
go
create trigger mala_pensja on pracownik for insert as begin
	declare @pensja money, @dodatek money
	set @pensja = '-1'
	set @dodatek = '-1'
	select @pensja = pensja from inserted
	select @dodatek = dodatek from inserted
	if (@pensja = 0 or @dodatek = 0 or @pensja = null or @dodatek = null) begin
		raiserror('za mala pensja', 1, 2) rollback
	end
end
go
--36.3 ??
drop trigger if exists duplikat_miejsce
go
create trigger duplikat_miejsce on miejsce for insert as
if exists (select * from miejsce m inner join inserted n on
m.ulica = n.ulica and m.numer = n.numer and m.miasto = n.miasto and m.kod = n.kod)
begin
	raiserror ('adres istnieje', 11, 1) rollback
end
go
--37.1
alter table samochod add usuniety bit default 0
drop trigger if exists usuniety_samochod
go
create trigger usuniety_samochod on samochod instead of delete as begin
	update samochod
	set usuniety=1 where id_samochod in (select id_samochod from deleted)
end
go
delete from samochod where id_samochod=3;
select * from samochod;
--37.2
drop trigger if exists usun_miejsce_i_wypozyczenia
go
create trigger usun_miejsce_i_wypozyczenia on miejsce instead of delete as begin
	if @@rowcount > 1 begin
		print 'nie mozna usunac kilku';
	end
	else begin
		delete from wypozyczenie where id_miejsca_wyp in(select id_miejsce from deleted)
		or id_miejsca_odd in(select id_miejsce from deleted);
		delete from miejsce where id_miejsce in(select id_miejsce from deleted)
	end
end
go
-- 37.3
drop trigger if exists samochod_blokada
go
create trigger samochod_blokada on samochod instead of delete, update, insert as begin
	declare @cnt int = @@rowcount
	while @cnt > 0 begin
		raiserror('blad', 1, 2) rollback
		set @cnt=@cnt-1
	end
end
go
--38.1
drop trigger if exists usunieci_pracownicy
go
create trigger usunieci_pracownicy on pracownik for delete as begin
	declare kursor_deleted cursor for select imie, nazwisko from deleted;
	open kursor_deleted
	declare @imie varchar(15), @nazwisko varchar(20)
	fetch next from kursor_deleted into @imie, @nazwisko
	while @@fetch_status = 0 begin
		print 'usuniêto: '+@imie+' '+ @nazwisko
		fetch next from kursor_deleted into @imie, @nazwisko
	end
	close kursor_deleted
	deallocate kursor_deleted
end
go
delete from pracownik
--38.2
create table usuniete_samochody (
id_samochod int primary key,
marka varchar(20) not null,
typ varchar(16) not null,
data_prod datetime not null,
kolor varchar(16) not null,
poj_silnika smallint not null,
przebieg integer not null
);
drop trigger if exists przenies_samochod
go
create trigger samochod_przenies on samochod for delete as begin
	declare kursor_przenies cursor for select * from deleted;
	open kursor_przenies
	declare @id int, @marka varchar(20), @typ varchar(16), @data_prod datetime, @kolor varchar(16), @poj_silnika smallint, @przebieg integer
	fetch next from kursor_przenies into @id, @marka, @typ, @data_prod, @kolor, @poj_silnika, @przebieg
	while @@fetch_status=0 begin
		insert into usuniete_samochody(id_samochod, marka, typ, data_prod, kolor, poj_silnika, przebieg) values
		(@id, @marka, @typ, @data_prod, @kolor, @poj_silnika, @przebieg);
		fetch next from kursor_przenies into @id, @marka, @typ, @data_prod, @kolor, @poj_silnika, @przebieg
	end
	close kursor_przenies
	deallocate kursor_przenies
end
go
--38.3
drop trigger if exists zerowanie_dodatku
go
create trigger zero_dodatku on pracownik after update as begin
	declare @id int, @pensja decimal(8,2)
	declare kursor_pensja cursor for select id_pracownik, pensja from inserted;
	open kursor_pensja
	fetch next from kursor_pensja into @id, @pensja
	while @@fetch_status=0 begin
		if @pensja > (select pensja from deleted where id_pracownik=@id) begin
			update pracownik
			set dodatek=0 where id_pracownik=@id;
		end
		fetch next from kursor_pensja into @id, @pensja
	end
	close kursor_pensja
	deallocate kursor_pensja
end
go
--39.1
drop view if exists ocena_klienta
go
create view ocena_klienta as
select k.id_klient, k.imie, k.nazwisko, case
	when count(w.id_klient)>=2 then 'tak'
	else 'nie' end as staly_klient
from klient k left join wypozyczenie w on k.id_klient=w.id_klient
group by k.id_klient, k.imie, k.nazwisko;
go
select * from ocena_klienta where staly_klient='nie' order by nazwisko, imie;
--39.2
drop view if exists pensja_pracownika
go
create view pensja_pracownika as
select id_pracownik, imie, nazwisko, case
	when pensja<1500 then 'ma³a'
	when pensja>=1500 and pensja <3000 then 'œrednia'
	when pensja>=3000 then 'du¿a' end as zarobki
from pracownik
go
select * from pensja_pracownika where zarobki='ma³a'
--39.3
drop view if exists pracownik_informacje
go
create view pracownik_informacje as
select p.id_pracownik, p.imie, p.nazwisko, datediff(year, p.data_zatr, getdate()) as staz_pracy, count(w.id_pracow_wyp) as wypozyczenia, case
	when p.dodatek>0 then 'tak'
	when p.dodatek=0 then 'nie'
	else 'brak' end as dodatek
from pracownik p left join wypozyczenie w on p.id_pracownik=w.id_pracow_wyp
group by p.id_pracownik,p.imie,p.nazwisko, p.data_zatr, p.dodatek
go
select * from pracownik_informacje where dodatek='tak'
select * from pracownik_informacje where id_pracownik=1
--40.1
drop procedure if exists usun_widoki
go
create procedure usun_widoki as begin
	declare @sql nvarchar(200);
	while exists (select top 1 1 from information_schema.tables
	where table_catalog=db_name() and table_type = 'view') begin
		select @sql = 'drop view ' + table_name from information_schema.tables
		where table_catalog = db_name() and table_type='view';
		exec sp_executesql @sql
	end
end
go
exec usun_widoki;
-- 40.2
drop procedure if exists usun_klucze_obce
go
create procedure usun_klucze_obce as begin
	while(exists(select 1 from information_schema.table_constraints where constraint_type='foreign key')) begin
		declare @sql nvarchar(2000)
		select top 1 @sql=('alter table ' + table_schema + '.[' + table_name + '] drop constraint [' + constraint_name + ']')
		from information_schema.table_constraints where constraint_type = 'foreign key'
        exec (@sql)
    end
end
exec usun_klucze_obce
select * from information_schema.table_constraints;
go
-- 40.3
drop procedure if exists klient_dodaj_kolumne_rabat
go
create procedure klient_dodaj_kolumne_rabat as begin
	if col_length('klient','rabat') is null begin
		alter table klient add rabat int default 0
		insert into klient(rabat) values (0)
	end
end
exec klient_dodaj_kolumne_rabat