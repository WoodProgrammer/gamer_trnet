# -*- coding: utf-8 -*-
# Generated by Django 1.11.2 on 2017-06-19 07:27
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('epinmain', '0002_auto_20170616_2216'),
    ]

    operations = [
        migrations.AddField(
            model_name='profile',
            name='balance',
            field=models.FloatField(default=0),
        ),
    ]
