<h1>Automated Abuse Reporting for DirectAdmin 🚨🤖</h1>

<p><strong>Automatically detect, report, and block brute-force attack IPs on DirectAdmin servers</strong></p>

<h2>Overview</h2>

<p>
This script is designed for system administrators using DirectAdmin who want to proactively defend their servers against brute-force attacks. Not only does it automate the process of log analysis and IP blocking, but it also takes server security one step further by sending abuse reports directly to the providers of attacking IPs using WHOIS data and templated email notifications.
</p>

<ul>
  <li>📝 <strong>Automatic log parsing:</strong> Reads DirectAdmin logs to detect suspicious login attempts.</li>
  <li>🌐 <strong>WHOIS abuse contact extraction:</strong> Finds abuse emails for malicious IPs.</li>
  <li>📬 <strong>Automated reporting:</strong> Sends abuse notifications via Gmail using <code>mailx</code> and app passwords.</li>
  <li>🛡️ <strong>Fail2Ban integration:</strong> Optionally block attackers with Fail2Ban.</li>
  <li>🤖 <strong>AI-powered optimizations:</strong> Script logic and structure enhanced with AI tools.</li>
</ul>

<h2>How It Works</h2>

<ol>
  <li>The script runs hourly (via cron), parses DirectAdmin logs for failed login attempts, and fetches abuse contact information for each offending IP.</li>
  <li>Abuse reports are sent using a customizable email template.</li>
  <li>Each attacker can be blocked automatically via Fail2Ban for enhanced server protection.</li>
  <li>All tasks are streamlined for efficient, proactive server defense.</li>
</ol>

<h2>Requirements</h2>
<ul>
  <li>DirectAdmin access with log file permissions</li>
  <li><code>mailx</code> installed and configured with a Gmail account and app password</li>
  <li><code>whois</code> installed</li>
  <li>(Optional) Fail2Ban for auto IP blocking</li>
  <li>Bash/shell or Python (depending on your implementation)</li>
</ul>

<h2>Why Use This Project?</h2>

<ul>
  <li>Save hours of manual log review and IP tracking</li>
  <li>Strengthen server security with immediate blocking and responsible reporting</li>
  <li>Contribute to a safer internet by proactively notifying abuse teams</li>
  <li>Learn and apply automation and sysadmin best practices tailored for DirectAdmin</li>
</ul>

<hr>

<p>
<strong>Get started in minutes and take your hosting security to the next level!</strong>
</p>Why Use This Project?
Save hours of manual log review and IP tracking
Strengthen server security with immediate blocking and responsible reporting
Contribute to a safer internet by proactively notifying abuse teams
Learn and apply automation and sysadmin best practices tailored for DirectAdmin
