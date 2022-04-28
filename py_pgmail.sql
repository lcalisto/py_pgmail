DROP FUNCTION py_pgmail(text,text[], text[], text[], text, text, text, text, text, text);

CREATE OR REPLACE FUNCTION public.py_pgmail(from_addr text, to_addr_list text[], cc_addr_list text[], bcc_addr_list text[], subject text, login text, password text, message_text text DEFAULT ''::text, message_html text DEFAULT ''::text, _filename text DEFAULT ''::text, _attachment text DEFAULT ''::text, smtpserver text DEFAULT 'localhost'::text)
 RETURNS boolean
 LANGUAGE plpython3u
AS $function$
        import smtplib
        from email.mime.multipart import MIMEMultipart
        from email.mime.text import MIMEText
        from email.mime.base import MIMEBase
        from email import encoders

        msg = MIMEMultipart()
        msg["Subject"] = subject
        msg['From'] = from_addr
        msg['To'] = ', '.join(to_addr_list)
        #msg['Cc'] = ', '.join(cc_addr_list)
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
        all_addr_list = to_addr_list   #+ cc_addr_list + bcc_addr_list

        if _filename.replace(' ', '') != '' and _attachment.replace(' ', '') != '':
            filename = _filename
            attachment = open(_attachment, "rb")
            part = MIMEBase('application', 'octet-stream')
            part.set_payload((attachment).read())
            encoders.encode_base64(part)
            part.add_header('Content-Disposition', "attachment; filename= %s" % filename)
            msg.attach(part)

        server = smtplib.SMTP(smtpserver)
        #server.starttls()
        if login!='':
                server.login(login, password)
        problems = server.sendmail(from_addr, all_addr_list,msg.as_string())
        server.quit()
        #if we have problems then print the problem and return False
        if len(problems)>0:
                plpy.info('An error ocurred: '+str(problems))
                return False
        else:
                return True
$function$
