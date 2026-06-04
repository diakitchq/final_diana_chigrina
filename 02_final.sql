drop schema if exists fitness_club cascade;

create schema fitness_club;

set search_path to fitness_club;
set search_path to fitness_club;

create table members
(
    member_id serial primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    gender varchar(10)
        check (gender in ('Male','Female','Other')),
    email varchar(120) unique not null,
    phone varchar(25) not null,
    join_date date not null
        check (join_date > date '2026-01-01'),
    created_at timestamp default current_timestamp,
    emergency_contact varchar(100)
);

create table trainers
(
    trainer_id serial primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    trainer_specialization varchar(100) not null,
    salary numeric(10,2)
        check (salary >= 0),

    constraint uq_trainer_name
    unique(first_name,last_name)
);

create table equipment
(
    equipment_id serial primary key,
    equipment_name varchar(100) unique not null,
    quantity int not null
        check(quantity >= 0),

    purchase_date date not null
        check (purchase_date > date '2026-01-01')
);

create table fitness_classes
(
    class_id serial primary key,

    class_name varchar(100) not null,

    trainer_id int,

    class_date date not null
        check (class_date > date '2026-01-01'),

    duration_minutes int default 60
        check (duration_minutes > 0),

    foreign key (trainer_id)
        references trainers(trainer_id)
        on delete set null
);

create table memberships
(
    membership_id serial primary key,

    member_id int not null,

    membership_type varchar(20)
        check (
            membership_type in
            ('Basic','Standard','Premium')
        ),

    start_date date not null,

    end_date date not null,

    monthly_fee numeric(10,2)
        check (monthly_fee >= 0),

    foreign key (member_id)
        references members(member_id)
        on delete cascade
);

create table attendance
(
    attendance_id serial primary key,

    member_id int not null,

    class_id int not null,

    attendance_date date not null,

    foreign key (member_id)
        references members(member_id)
        on delete cascade,

    foreign key (class_id)
        references fitness_classes(class_id)
        on delete cascade
);

create table payments
(
    payment_id serial primary key,

    member_id int not null,

    amount numeric(10,2)
        check (amount >= 0),

    payment_date date not null,

    status varchar(20)
        default 'pending'
        check (
            status in
            ('pending','paid','cancelled')
        ),

    tax_amount numeric(10,2)
        generated always as
        (amount * 0.12) stored,

    foreign key (member_id)
        references members(member_id)
        on delete cascade
);

create table class_equipment
(
    class_equipment_id serial primary key,

    class_id int not null,

    equipment_id int not null,

    foreign key (class_id)
        references fitness_classes(class_id)
        on delete cascade,

    foreign key (equipment_id)
        references equipment(equipment_id)
        on delete cascade
);
set search_path to fitness_club;

select table_name
from information_schema.tables
where table_schema = 'fitness_club'
order by table_name;
set search_path to fitness_club;

insert into members
(first_name,last_name,gender,email,phone,join_date)
values
('Nikolay','Katkalov','Male','nikolay.katkalov@gmail.com','+77753753214','2026-02-01'),
('Roman','Timofeevich','Male','roman.timofeevich@gmail.com','+77753753215','2026-02-02'),
('Angelina','Kim','Female','angelina.kim@gmail.com','+77753753216','2026-02-03'),
('Dias','Yermekov','Male','dias.ermekov@gmail.com','+77753753217','2026-02-04'),
('Diana','Chigrina','Female','diana.chigrina@gmail.com','+77753753218','2026-02-05'),
('Aruzhan','Tulegenova','Female','aruzhan.tulegenova@gmail.com','+77753753219','2026-02-06'),
('Aru','Khismetova','Female','aru.khismetova@gmail.com','+77753753220','2026-02-07'),
('Sultan','Kalmen','Male','sultan.kalmen@gmail.com','+77753753221','2026-02-08'),
('Baurzhan','Romanov','Male','baurzhan.romanov@gmail.com','+77753753222','2026-02-09'),
('Erkebulan','Eleusinov','Male','erkebulan.eleusinov@gmail.com','+77753753223','2026-02-10'),
('Maksim','Li','Male','maksim.li@gmail.com','+77753753224','2026-02-11');

insert into trainers
(first_name,last_name,trainer_specialization,salary)
values
('Elena','Ivanova','Yoga',400000),
('Marat','Serikov','Crossfit',500000),
('Aidana','Zhumabekova','Pilates',420000),
('Ruslan','Akhmetov','Bodybuilding',550000),
('Damir','Tuleuov','Cardio',470000);

insert into equipment
(equipment_name,quantity,purchase_date)
values
('Treadmill',10,'2026-02-01'),
('Exercise Bike',8,'2026-02-02'),
('Bench Press',5,'2026-02-03'),
('Dumbbells Set',15,'2026-02-04'),
('Rowing Machine',4,'2026-02-05');
select count(*) from members;

set search_path to fitness_club;

insert into fitness_classes
(class_name,trainer_id,class_date,duration_minutes)
values
(
'Morning Yoga',
(select trainer_id from trainers where first_name='Elena'),
'2026-03-01',
60
),
(
'Crossfit Pro',
(select trainer_id from trainers where first_name='Marat'),
'2026-03-02',
90
),
(
'Pilates Plus',
(select trainer_id from trainers where first_name='Aidana'),
'2026-03-03',
60
),
(
'Bodybuilding Advanced',
(select trainer_id from trainers where first_name='Ruslan'),
'2026-03-04',
120
),
(
'Cardio Blast',
(select trainer_id from trainers where first_name='Damir'),
'2026-03-05',
45
);

insert into memberships
(member_id,membership_type,start_date,end_date,monthly_fee)
select
member_id,
case
    when member_id in (1,2,4,8,10,11) then 'Premium'
    when member_id in (3,5,9) then 'Standard'
    else 'Basic'
end,
'2026-02-01',
'2026-12-31',
case
    when member_id in (1,2,4,8,10,11) then 35000
    when member_id in (3,5,9) then 25000
    else 15000
end
from members;

insert into payments
(member_id,amount,payment_date,status)
select
member_id,
35000,
'2026-03-01',
'paid'
from members;

insert into attendance
(member_id,class_id,attendance_date)
select
m.member_id,
c.class_id,
c.class_date
from members m
cross join fitness_classes c
where m.member_id <= 5;

insert into class_equipment
(class_id,equipment_id)
values
(
(select class_id from fitness_classes where class_name='Morning Yoga'),
(select equipment_id from equipment where equipment_name='Exercise Bike')
),
(
(select class_id from fitness_classes where class_name='Crossfit Pro'),
(select equipment_id from equipment where equipment_name='Dumbbells Set')
),
(
(select class_id from fitness_classes where class_name='Pilates Plus'),
(select equipment_id from equipment where equipment_name='Exercise Bike')
),
(
(select class_id from fitness_classes where class_name='Bodybuilding Advanced'),
(select equipment_id from equipment where equipment_name='Bench Press')
),
(
(select class_id from fitness_classes where class_name='Cardio Blast'),
(select equipment_id from equipment where equipment_name='Treadmill')
);
select count(*) from attendance;
set search_path to fitness_club;

-- =====================================================
-- ALTER TABLE (5 разных операций)
-- =====================================================

-- 1
alter table members
add column loyalty_points int default 0;

-- 2
alter table trainers
alter column salary type numeric(12,2);

-- 3
alter table equipment
rename column quantity to stock_quantity;

-- 4
alter table fitness_classes
add column room_number int;

-- 5
alter table payments
add constraint chk_payment_positive check (amount > 0);

-- =====================================================
-- UPDATE (2 запроса)
-- =====================================================

-- повышение лояльности активным участникам
update members
set loyalty_points = loyalty_points + 10
where member_id <= 5;

-- обновление статуса платежей
update payments
set status = 'paid'
where status = 'pending';

-- =====================================================
-- DELETE (обязательно с ROLLBACK)
-- =====================================================

begin;

delete from payments
where status = 'cancelled'
returning payment_id;

rollback;

-- =====================================================
-- GRANT + REVOKE
-- =====================================================

drop role if exists fitness_readonly;
drop role if exists fitness_writer;

create role fitness_readonly;
create role fitness_writer;

grant usage on schema fitness_club to fitness_readonly;

grant select on all tables in schema fitness_club to fitness_readonly;

grant insert, update on members to fitness_writer;

revoke update on members from fitness_writer;