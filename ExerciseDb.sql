create database ExerciseDb;
use ExerciseDb;
create table Student(
SId int primary key,
SName varchar(50) not null,
SEmail nvarchar(50) not null unique,
SContact nvarchar(50) not null unique 
);

insert into Student (SId, SName, SEmail, SContact) values 
('1','Raj Saxena','raj@gmail.com','7004568927'),
('2','Ravi Yadav','ravi@gmail.com','7024558927'),
('3','Suman Das','das@gmail.com','9864532892');


create table Fee(
SId int foreign key references Student(SId),
SFee float,
SMonth int,
SYear int,
Constraint SFpk primary key (SId, SFee, SMonth))

create table PayConfirmation
(SId int,
Name varchar(50),
Email varchar(50),
Fee float,
PaidOnDate date)

alter trigger trgFeePayConfirmation
on Fee
after insert
as
declare @id int
declare @fee float
declare @month int
declare @year int
declare @email nvarchar(50)
declare @name nvarchar(50)

select @id=SId from inserted
select @name=s.SName from Student s where s.SId = @id
select @email=s.SEmail from Student s where s.SId = @id
select @fee=SFee from inserted
select @month=SMonth from inserted
select @year=SYear from inserted

insert into PayConfirmation (SId, Name, Email, Fee, PaidOnDate) values
(@id, @name, @email, @fee, convert(date,convert(nvarchar(50),@month) + '/1/' + convert(nvarchar(50),@year)))

print 'Pay details added'


drop trigger trgFeePayConfirmation
insert into Fee Values(1, 2000, 12, 2023)
insert into Fee Values(2, 4000, 2, 2023)
insert into Fee Values(3, 1500, 6, 2023)
insert into Fee Values(1, 6000, 5, 2023)
insert into Fee Values(2, 6000, 4, 2023)

select * from PayConfirmation

