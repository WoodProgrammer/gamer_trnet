# -*- coding: utf-8 -*-
# Generated by Django 1.10.6 on 2017-06-13 06:54
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('game', '0004_auto_20170612_1344'),
    ]

    operations = [
        migrations.CreateModel(
            name='Genre',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=15)),
                ('count', models.IntegerField(default=0)),
            ],
        ),
        migrations.AlterModelOptions(
            name='game',
            options={'ordering': ['-update_date']},
        ),
        migrations.AlterField(
            model_name='game',
            name='genre',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='game.Genre'),
        ),
    ]
