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
		</html>
');
