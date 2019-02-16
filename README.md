# README

user_table

| Column | Type | Modifiers |
| :--- | :--- | :--- |
| id | integer | not null auto_increment primary_key |
| name | string | not null |
| email | string | not null unique |
| password_digest | string | not null |

task_table

| Column | Type | Modifiers |
| :--- | :--- | :--- |
| id | integer | not null auto_increment primary_key |
| name | string | not null |
| status | integer | not null |
| deadline | datetime | not null |
| priority | integer | not null |
| usr_id | integer | foreign_key |

label_table

| Column | Type | Modifiers |
| :--- | :--- | :--- |
| name | string | not null |
| task_id | integer | foreign_key |
