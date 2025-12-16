# directadmin-auto-abuse-email-sender
Automated Abuse Reporting for DirectAdmin 🚨🤖 
Automatically detect, report, and block brute-force attack IPs on DirectAdmin servers

Overview
This script is designed for system administrators using DirectAdmin who want to proactively defend their servers against brute-force attacks. Not only does it automate the process of log analysis and IP blocking, but it also takes server security one step further by sending abuse reports directly to the providers of attacking IPs using WHOIS data and templated email notifications.

Key features include:

📝 Automatic log parsing: Reads DirectAdmin logs to detect suspicious login attempts.
🌐 WHOIS abuse contact extraction: Finds abuse emails for malicious IPs.
📬 Automated reporting: Sends abuse notifications via Gmail using mailx and app passwords.
🛡️ Fail2Ban integration: Optionally block attackers with Fail2Ban.
🤖 AI-powered optimizations: Script logic and structure enhanced with AI tools.
How It Works
The script runs hourly (via cron), parses DirectAdmin logs for failed login attempts, and fetches abuse contact information for each offending IP.
Abuse reports are sent using a customizable email template.
Each attacker can be blocked automatically via Fail2Ban for enhanced server protection.
All tasks are streamlined for efficient, proactive server defense.
Requirements
DirectAdmin access with log file permissions
mailx installed and configured with a Gmail account and app password
whois installed
(Optional) Fail2Ban for auto IP blocking
Bash/shell or Python (depending on your implementation)
Why Use This Project?
Save hours of manual log review and IP tracking
Strengthen server security with immediate blocking and responsible reporting
Contribute to a safer internet by proactively notifying abuse teams
Learn and apply automation and sysadmin best practices tailored for DirectAdmin
