
-- Rafa� Ciesnowski
-- 253982
-- Szpital

drop table if exists pacjent cascade;
drop table if exists przyjecie cascade;
drop table if exists lekarz cascade;
drop table if exists badanie cascade;
drop table if exists pielegniarz cascade;
drop table if exists dyzur cascade;
drop table if exists wydarzenie_nieporzadane cascade;
drop table if exists zwolnienie cascade;
drop table if exists wizyta_kontrolna cascade;
drop table if exists zgon cascade;
drop table if exists autopsja cascade;

create table pacjent (
id_pacjent serial primary key,
imie varchar(16) not null check(length(imie) >= 2),
nazwisko varchar(32) not null check(length(nazwisko) >= 2),
pesel char(11),
ulica_nr varchar(50),
miasto varchar(50) default 'Gdynia',
kod int check(length(kod) = 5),
telefon int null check ((length(telefon) >= 7) and (length(telefon) <= 10)),
);

create table przyjecie (
id_przyjecie serial primary key,
data date not null default now(),
opis varchar(300),
id_pacjent not null references pacjent(id_pacjent) on update cascade
);

create table lekarz (
id_lekarz serial primary key,
imie varchar(16) not null check(length(imie) >= 2),
nazwisko varchar(32) not null check (length(nazwisko) >= 2),
pesel char(11) not null,
ulica_nr varchar(50) not null,
miasto varchar(50) default 'Gdynia',
kod int check(length(kod) = 5) not null,
telefon int not null unique check ((length(telefon) >= 7) and (length(telefon) <= 10)),
stanowisko varchar(30)
);

create table badanie (
id_badanie serial primary key,
data date not null default now(),
diagnoza varchar(300),
id_przyjecie not null references przyjecie(id_przyjecie) on update cascade,
id_lekarz not null references lekarz(id_lekarz) on update cascade
);

create table pielegniarz (
id_pielegniarz serial primary key,
imie varchar(16) not null check (length(imie) >= 2),
nazwisko varchar(32) not null check (length(nazwisko) >= 2),
pesel char(11) not null,
ulica_nr varchar(50),
miasto varchar(50) default 'Gdynia',
kod int not null check(length(kod) = 5),
telefon int not null unique check ((length(telefon) >= 7) and (length(telefon) <= 10)),
);

create table dyzur (
id_dyzur serial primary key,
data date not null default now(),
id_pielegniarz not null references pielegniarz(id_pielegniarz) on update cascade
);

create table wydarzenie_nieporzadane (
id_wydarzenie serial primary key,
opis varchar(300),
id_pacjent references pacjent(id_pacjent) on update cascade,
id_dyzur references dyzur(id_dyzur) on update cascade
);

create table zwolnienie (
id_zwolnienie serial primary key,
data date not null default now(),
id_przyjecie unique references przyjecie(id_przyjecie) on update cascade
);

create table wizyta_kontrolna (
id_wizyta serial primary key,
data date not null default now(),
id_zwolnienie references zwolnienie(id_zwolnienie) on update cascade,
id_lekarz not null references lekarz(id_lekarz) on update cascade
);

create table zgon (
id_zgon serial primary key,
data date default now(),
opis varchar(300),
id_przyjecie unique references przyjecie(id_przyjecie) on update cascade
);

create table autopsja (
id_autopsja serial primary key,
data date not null default now(),
opis varchar(300),
id_lekarz references lekarz(id_lekarz) on update cascade,
id_zgon references zgon(id_zgon) on update cascade
);


insert into pacjent (imie, nazwisko, pesel)
values ('Anastazy', 'Abakus', '98765432101');
insert into pacjent (imie, nazwisko, pesel, ulica_nr, miasto, kod, telefon)
values ('Barbara', 'Becik�wna', '37926738243', 'Marymonckowicka 98', 'W�adywostok', '78701', '723456978');
insert into pacjent (imie, nazwisko)
values ('Krystian', 'Nowak');
insert into pacjent (imie, nazwisko, pesel, miasto)
values ('Alicja', 'Krdeffe', '79837849830', 'Malbork');
insert into pacjent (imie, nazwisko, pesel)
values ('Micha�', 'Takzwany', '672987345');
insert into pacjent (imie, nazwisko, pesel, ulica_nr, kod, telefon)
values ('Janina', 'Janczewska', '94022889304', 'Kownie�ska 1087', '82304', '20930289');

insert into przyjecie (id_pacjent, data, opis)
values ('1', '2016-02-12', 'omdlengthia, b�l brzucha');
insert into przyjecie (id_pacjent, data, opis)
values ('2', '2018-02-13', 'noc bezsenna, niespokojna, dusza rwie si�, m�zg wykrusza');
insert into przyjecie (id_pacjent, data, opis)
values ('2', '2018-03-01', 'piski w uszach, dzwony w skroni');
insert into przyjecie (id_pacjent)
values ('3');
insert into przyjecie (id_pacjent, opis, data)
values ('4', 'boli go', '2013-02-20');
insert into przyjecie (id_pacjent)
values ('5');
insert into przyjecie (id_pacjent, opis)
values ('6', 'zakr�ty w g�owie i og�lny upadek');
insert into przyjecie (id_pacjent)
values ('1');
insert into przyjecie (id_pacjent)
values ('2');
insert into przyjecie (opis, id_pacjent)
values ('ostatni w kolejce po szcz�cie i zdrowie', '4');

insert into lekarz (imie, nazwisko, pesel, ulica_nr, kod, telefon, stanowisko)
values ('Zenon', 'Zu�yczy�ski', '57284379302', 'Stara 5', '81857', '78312354', 'anio� jasno�ci');
insert into lekarz (imie, nazwisko, pesel, ulica_nr, kod, miasto, telefon, stanowisko)
values ('Xawery', 'Ksyrde', '69114239743', 'Czerni �l�skiej 3', '84923', 'W�glewo na Kaszebach', '987324374', 'anio� zag�ady');
insert into lekarz (imie, nazwisko, pesel, ulica_nr, kod, miasto, telefon, stanowisko)
values ('Zuzanna', 'Dyktewicz�wna', '89278398201', 'Oboj�tno�ci 50', '10483', 'Warszawa', '98729300', 'naczelny');
insert into lekarz (imie, nazwisko, pesel, ulica_nr, kod, telefon, stanowisko)
values ('Cezary', 'Carski', '82380482011', 'Mojsze �ywyrd�a 13', '92830', '928394029', 'podczelny');
insert into lekarz (imie, nazwisko, pesel, ulica_nr, kod, telefon, stanowisko)
values ('Eliza', 'Kne�niar', '43091298374', 'Z�ota 2', '81092', '89820121', 'dyrektor');

insert into badanie (diagnoza, id_przyjecie, id_lekarz)
values ('pacjent symuluje', '1', '1');
insert into badanie (diagnoza, id_przyjecie, id_lekarz)
values ('wci�� symuluje', '1', '1');
insert into badanie (diagnoza, id_przyjecie, id_lekarz)
values ('o mord�go niesko�czona, ty co duszom skrzyde� dajesz, a� do piekie� zlatuj� i czezn�', '2', '2');
insert into badanie (id_przyjecie, id_lekarz)
values ('3', '5');
insert into badanie (diagnoza, id_przyjecie, id_lekarz)
values ('ci�kie �ycie i prze�adowanie sumienia z efektem ubocznym', '5', '4');

insert into pielegniarz (imie, nazwisko, pesel, ulica_nr, kod, telefon)
values ('Arnold', 'Konieczny', '88040323453', 'Pustek 4', '81860', '23920850');
insert into pielegniarz (imie, nazwisko, pesel, ulica_nr, kod, telefon)
values ('Sebastian', 'Ryksza', '96031294020', 'Haska 12', '81234', '920384020');
insert into pielegniarz (imie, nazwisko, pesel, ulica_nr, kod, telefon)
values ('Krystyna', 'Katko', '87120389203', 'Morskich �a� srebrzystych 1', '83902', '782093928');
insert into pielegniarz (imie, nazwisko, pesel, ulica_nr, kod, telefon)
values ('Miki', 'Bren', '890210283', 'Androgendra 23', '89234', '983084098');
insert into pielegniarz (imie, nazwisko, pesel, ulica_nr, miasto, kod, telefon)
values ('Daria', 'Hurczy�czyk', '728309490', 'Durdubelki 24', 'Sopot', '71078', '98393533');


insert into dyzur (data, id_pielegniarz)
values ('2018-04-10', '3');
insert into dyzur (id_pielegniarz)
values ('2');
insert into dyzur (id_pielegniarz)
values ('3');
insert into dyzur (id_pielegniarz)
values ('4');
insert into dyzur (id_pielegniarz)
values ('5');

insert into wydarzenie_nieporzadane (id_dyzur, id_pacjent)
values ('1', '3');
insert into wydarzenie_nieporzadane (opis, id_dyzur, id_pacjent)
values ('pacjent zerwa� si� nagle i przez okno skoczy�, przez co skaputnia� na pi�� chwil zupe�nie', '2', '1');
insert into wydarzenie_nieporzadane (id_dyzur, id_pacjent)
values ('2', '3');
insert into wydarzenie_nieporzadane (id_dyzur, id_pacjent, opis)
values ('2', '3', 'znowu');
insert into wydarzenie_nieporzadane (id_dyzur, id_pacjent)
values ('4', '2');

insert into zwolnienie (id_przyjecie)
values ('1');
insert into zwolnienie (id_przyjecie)
values ('2');
insert into zwolnienie (id_przyjecie)
values ('3');
insert into zwolnienie (id_przyjecie)
values ('4');
insert into zwolnienie (id_przyjecie)
values ('5');

insert into wizyta_kontrolna (id_zwolnienie, id_lekarz)
values ('1', '1');
insert into wizyta_kontrolna (id_zwolnienie, id_lekarz)
values ('1', '2');
insert into wizyta_kontrolna (id_zwolnienie, id_lekarz)
values ('1', '3');
insert into wizyta_kontrolna (id_zwolnienie, id_lekarz)
values ('1', '4');
insert into wizyta_kontrolna (id_zwolnienie, id_lekarz)
values ('1', '5');

insert into zgon (opis, id_przyjecie)
values ('trzecia nad ranem, krwotok wewn�trzny, �mier� w agonii', '6');
insert into zgon (id_przyjecie)
values ('7');
insert into zgon (id_przyjecie)
values ('8');
insert into zgon (id_przyjecie)
values ('9');
insert into zgon (id_przyjecie)
values ('10');

insert into autopsja (opis, id_lekarz, id_zgon)
values ('guz na jelicie, sprawa ciekawa', '2', '1');
insert into autopsja (opis, id_lekarz, id_zgon)
values ('wyniki poprzedniej autopsji potwierdzam', '1', '1');
insert into autopsja (opis, id_lekarz, id_zgon)
values ('norma', '2', '3');
insert into autopsja (id_lekarz, id_zgon)
values ('2', '4');
insert into autopsja (opis, id_lekarz, id_zgon)
values ('nieszcz�liwe przypadki na ka�dym kroku czyhaj� cz�owieka', '2', '5');

select * from pacjent;
select * from przyjecie;
select * from lekarz;
select * from badanie;
select * from pielegniarz;
select * from dyzur;
select * from wydarzenie_nieporzadane;
select * from zwolnienie;
select * from wizyta_kontrolna;
select * from zgon;
select * from autopsja;
