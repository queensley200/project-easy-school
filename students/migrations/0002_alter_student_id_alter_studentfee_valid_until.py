# Generated by Django 5.0.3 on 2024-03-28 21:22

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("students", "0001_initial"),
    ]

    operations = [
        migrations.AlterField(
            model_name="student",
            name="id",
            field=models.BigAutoField(primary_key=True, serialize=False),
        ),
        migrations.AlterField(
            model_name="studentfee",
            name="valid_until",
            field=models.DateField(
                default=datetime.date(2024, 4, 1), verbose_name="Valid Until"
            ),
        ),
    ]
