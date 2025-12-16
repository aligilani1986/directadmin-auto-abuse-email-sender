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

<h2>Setup: Configuring <code>mailx</code> with Gmail (Google SMTP)</h2>

<h3>1. Install mailx</h3>
<p>
<strong>Debian/Ubuntu:</strong>
</p>
<pre><code>sudo apt update
sudo apt install mailutils
</code></pre>
<p>
<strong>CentOS/RHEL:</strong>
</p>
<pre><code>sudo yum install mailx
</code></pre>

<h3>2. Configure <code>mailx</code> to Use Gmail’s SMTP</h3>
<p>
Edit (or create) the mailx configuration file:
</p>

<pre><code>sudo nano /etc/mail.rc
</code></pre>
<p>
Add these lines (replace with your Gmail address and <strong>App Password</strong>):
</p>

<pre><code>set smtp=smtps://smtp.gmail.com:465
set smtp-auth=login
set smtp-auth-user=your@gmail.com
set smtp-auth-password=YOUR_APP_PASSWORD
set from="your@gmail.com"
set ssl-verify=ignore
</code></pre>

<ul>
    <li>
        <strong>Important:</strong> You <strong>must</strong> use a <a href="https://support.google.com/accounts/answer/185833" target="_blank">Google App Password</a> (not your main password). Google Account → Security → "App passwords" → generate for Mail.
    </li>
</ul>

<h3>3. Test <code>mailx</code> Sending via Gmail</h3>
<pre><code>echo "This is a test email from mailx and Gmail SMTP." | mail -s "Test Mail" your@gmail.com
</code></pre>
<p>
Or for verbose output:
</p>
<pre><code>echo "Mailx is working." | mail -v -s "Mailx Test with Gmail" your@gmail.com
</code></pre>

<h3>4. Troubleshooting</h3>
<ul>
    <li>Ensure you use the App Password (not your Gmail login password)</li>
    <li>Check <code>ssl-verify=ignore</code> is included for compatibility</li>
    <li>Confirm the config path: <code>/etc/mail.rc</code> or <code>~/.mailrc</code></li>
    <li>Ensure outbound port <strong>465</strong> is open on your server firewall</li>
</ul>
<p>
<strong>Get started in minutes and take your hosting security to the next level!</strong>
</p>Why Use This Project?
Save hours of manual log review and IP tracking
Strengthen server security with immediate blocking and responsible reporting
Contribute to a safer internet by proactively notifying abuse teams
Learn and apply automation and sysadmin best practices tailored for DirectAdmin


<h2>Setup: Installing <code>Fail2Ban</code> and <code>whois</code></h2>

<h3>1. Install Fail2Ban</h3>
<p>
<strong>Debian/Ubuntu:</strong>
</p>
<pre><code>sudo apt update
sudo apt install fail2ban
</code></pre>
<p>
<strong>CentOS/RHEL:</strong>
</p>
<pre><code>sudo yum install epel-release
sudo yum install fail2ban
</code></pre>

<h3>2. Basic Configuration for Fail2Ban</h3>
<ul>
  <li>
    Copy the default config to a local file for editing:
    <pre><code>sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local</code></pre>
  </li>
  <li>
    Edit the local jail settings to enable protection for SSH (and optionally customize for DirectAdmin):
    <pre><code>sudo nano /etc/fail2ban/jail.local</code></pre>
    <p>
      Example: To enable jail for SSH (already enabled by default in many installs):
    </p>
    <pre><code>[sshd]
enabled = true
port = ssh
bantime = 3600
findtime = 600
maxretry = 5
</code></pre>
  </li>
  <li>
    <strong>Restart Fail2Ban:</strong>
    <pre><code>sudo systemctl restart fail2ban</code></pre>
  </li>
  <li>
    <strong>Check status:</strong>
    <pre><code>sudo fail2ban-client status
sudo fail2ban-client status sshd
</code></pre>
  </li>
</ul>
<p>
For advanced log monitoring (e.g., for DirectAdmin smtp/da-pop3d), custom jails can be added. See <a href="https://www.fail2ban.org/wiki/index.php/Main_Page" target="_blank">Fail2Ban official docs</a>.
</p>

<h3>3. Install whois</h3>
<p>
<strong>Debian/Ubuntu:</strong>
</p>
<pre><code>sudo apt install whois
</code></pre>
<p>
<strong>CentOS/RHEL:</strong>
</p>
<pre><code>sudo yum install whois
</code></pre>

<h3>4. Verify Installation</h3>
<ul>
  <li>
    <strong>Fail2Ban version:</strong>
    <pre><code>fail2ban-client -V</code></pre>
  </li>
  <li>
    <strong>whois version/test:</strong>
    <pre><code>whois google.com</code></pre>
  </li>
</ul>
