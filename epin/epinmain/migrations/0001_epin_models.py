# -*- coding: utf-8 -*-
# Generated by Django 1.10.5 on 2017-06-28 19:16
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.RunSQL(
                '''
                        create table users(
                                id serial not null primary key,
                                username varchar(15) not null UNIQUE,
                                password text not null,
                                email text not null UNIQUE,
                                c_date timestamp default current_timestamp,full_name varchar(40) , 
                                status boolean not null default true,balance real not null default 0,
                                lastlogin timestamp not null default current_timestamp,
                                admin boolean not null default false
                        );
                        
                         create table genre(
                                id serial not null primary key,
                                name varchar(40) not null UNIQUE
                        );
                        create table game(
                                id serial not null primary key,
                                name varchar(100) not null UNIQUE,
                                price real not null CHECK (price > 0),
                                popularity int not null,
                                created_date timestamp not null default current_timestamp,
                                update_date timestamp not null default current_timestamp,
                                logo varchar(200),
                                genre_id int not null references genre(id)
                        );
                                                
                        create table sale(
                                id serial not null primary key,
                                user_id int not null references users(id),
                                game_id int not null references game(id),
                                c_date timestamp default current_timestamp,
                                price real not null CHECK (price > 0)
                        );
                       
                        
                '''
        )

    ]
