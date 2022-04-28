# py_pgmail

### Sends emails from a PostgreSQL Database using Python3 (plpython3u)

This is a simple function in plpython3u (Python3) that sends an email from inside a PostgreSQL database.

In order to use this function please run the folowing steps:

1. Create __py_pgmail__ function by running [py_pgmail.sql](https://github.com/lcalisto/py_pgmail/blob/master/py_pgmail.sql)

2. After the function is created you can simply call the function as:

```sql 
select py_pgmail('sentFromEmail',array['destination emails'],array['cc'],array['bcc'],'Subject','<USERNAME>','<PASSWORD>','Text message','HTML message','attachment.csv','/foo/bar/','<MAIL.MYSERVER.COM:PORT>')
```
WARNING: You can send a message in __plain text__ or in __HTML__. _If you provide both plain text and HTML then only the HTML will be sent!_

For example:
    
```sql
-------------------   
-- HTML message --
-----------------
select py_pgmail(
	'sentFromEmail@whatever.com',
	array['dest@email.com','dest2@email.com'],
	array['cc@email.com','cc2@email.com','cc3@email.com'],
	array['bcc@email.com','bcc2@email.com','bcc3@email.com'],
	'My subject',
	'<USERNAME>',
	'<PASSWORD>',
	'Text message! This is an email sent from a database!',
	'<!DOCTYPE html>
		<html>
		<body>
		<p>html message! This is an email sent from a database!</p>
		</body>
		</html>',
	'attachment.csv',
	'/foo/bar/',
	'smtp.gmail.com:587');
    
-------------------------   
-- Plain text message --
-----------------------
select py_pgmail(
	'sentFromEmail@whatever.com',
	array['dest@email.com','dest2@email.com'],
	array['cc@email.com','cc2@email.com','cc3@email.com'],
	array['bcc@email.com','bcc2@email.com','bcc3@email.com'],
	'My subject',
	'<USERNAME>',
	'<PASSWORD>',
	'Text message! This is an email sent from a database!',
	'',
	'attachment.csv',
	'/foo/bar/',
    	'smtp.gmail.com:587');
```
Make sure you replace ```<USERNAME>``` ```<PASSWORD>``` and ```<MAIL.MYSERVER.COM:PORT>``` by the your email server config values.



If you plan to send emails using __gmail__ make sure you [allow less secure apps into your account](https://support.google.com/accounts/answer/6010255?hl=en)
  
You can use this function to send emails with __cc__ and __bcc__.

