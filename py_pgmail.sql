DROP FUNCTION py_pgmail(text,text[], text[], text[], text, text, text, text, text, text);

CREATE OR REPLACE FUNCTION py_pgmail(from_addr text, to_addr_list text[], cc_addr_list text[], bcc_addr_list text[], subject text, login text, password text, message_text text default '', message_html text default '', smtpserver text default 'smtp.gmail.com:587') 
	RETURNS boolean
AS $$ 
	import smtplib
	from email.mime.multipart import MIMEMultipart
	from email.mime.text import MIMEText
	msg = MIMEMultipart('alternative')
	msg["Subject"] = subject
	msg['From'] = from_addr
	msg['To'] = ', '.join(to_addr_list)
	msg['Cc'] = ', '.join(cc_addr_list)
	if message_text.replace(' ', '')!='':
		part1 = MIMEText(message_text, 'plain')
		msg.attach(part1)
	if message_html.replace(' ', '')!='':
		part2 = MIMEText(message_html, 'html')
		msg.attach(part2)
	#If no message (html or text) then stop script execution.
	if message_html.replace(' ', '')=='' and message_text.replace(' ', '')=='':
		plpy.info('An error ocurred: No message to send.')
		return False
	#Bcc needs to be added now, it should not be added to message.
	all_addr_list = to_addr_list+ cc_addr_list + bcc_addr_list
	server = smtplib.SMTP(smtpserver)
	server.starttls()
	server.login(login, password)
	problems = server.sendmail(from_addr, all_addr_list,msg.as_string())
	server.quit()
	#if we have problems then print the problem and return False
	if len(problems)>0:
		plpy.info('An error ocurred: '+str(problems))
		return False
	else:
		return True
$$ LANGUAGE plpython3u;
