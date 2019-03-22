SELECT py_pgmail(
	'sentFromEmail@whatever.com',					-- from
	array['dest@email.com','dest2@email.com'],			-- to
	array['cc@email.com','cc2@email.com','cc3@email.com'],		-- cc
	array['bcc@email.com','bcc2@email.com','bcc3@email.com'],	-- bcc
	'My subject',							-- subject
	'<USERNAME>',							-- login
	'<PASSWORD>',							-- password
	'Text message! This is an email sent from a database!',		-- msg_text
	'<!DOCTYPE html>
		<html>
			<body>
				<p>html message! This is an email sent from a database!</p>
			</body>
		</html>',						-- msg_html
	'attachment.csv',   						-- filename
	'/foo/bar/',   							-- filepath
	'smtpServer.whatever.com'					-- smtp_server
);
	
