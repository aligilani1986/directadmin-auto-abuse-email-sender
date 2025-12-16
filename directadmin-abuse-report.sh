#!/bin/bash

YOUR_GMAIL="youremail@gmail.com"
SUBJECT_PREFIX="Abuse Report: Brute Force Attack from"
TICKETS_ROOT="/usr/local/directadmin/data/tickets"
ADMIN_LIST="/usr/local/directadmin/data/admin/tickets.list"
USERS_DIR="/usr/local/directadmin/data/users"
LOGFILE="/root/abuse.log"
SERVERNAME="$(hostname -f)"

# -------------------------------
# Define whitelist of IPs here:
WHITELISTED_IPS=( 
    "8.8.8.8"
    # Add more IPs as needed
)
# Helper function to check if an IP is whitelisted
is_whitelisted() {
    local ip="$1"
    for white in "${WHITELISTED_IPS[@]}"; do
        [[ "$ip" == "$white" ]] && return 0
    done
    return 1
}
# -------------------------------

find "$TICKETS_ROOT" -type f -name "*.msg" | while read -r TICKET_FILE; do
    IPS=$(grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' "$TICKET_FILE" | sort | uniq)
    for IP in $IPS; do
        # -------------- Begin whitelist check
        if is_whitelisted "$IP"; then
            echo "$(date '+%F %T') $TICKET_FILE $IP SKIPPED (whitelisted)" >> "$LOGFILE"
            continue
        fi
        # -------------- End whitelist check

        LINE=$(grep "$IP" "$TICKET_FILE" | head -1)
        COUNT=$(echo "$LINE" | grep -oP '(?<=has )\d+(?= failed login attempts)' || echo "unknown")
        DETAILS=$(echo "$LINE" | awk -F':' '{print $2}' | xargs)

        ABUSE=$(whois $IP | grep -im1 -E 'abuse-mailbox|OrgAbuseEmail|e-mail|Email|abuse' | \
                grep -oE '([A-Za-z0-9._%+-]+)@([A-Za-z0-9.-]+\.[A-Za-z]{2,})')
        [ -z "$ABUSE" ] && ABUSE=$(whois $IP | grep -im1 -oE '([A-Za-z0-9._%+-]+)@([A-Za-z0-9.-]+\.[A-Za-z]{2,})')
        [ -z "$ABUSE" ] && {
            echo "$(date '+%F %T') $TICKET_FILE $IP No abuse contact found." >> "$LOGFILE"
            continue
        }
 

        SUBJECT="$SUBJECT_PREFIX $IP"
        BODY=$(cat <<EOF
Dear Abuse Team,

A brute-force attack has been detected in one of our service logs.

- Source IP: $IP
- Failed login attempts: $COUNT
- Attempt summary: $DETAILS
- Detected at: $(date '+%F %T') (server: $SERVERNAME)

Please investigate and take appropriate action.

For further details, contact us.

Thank you,
Abuse Desk
$SERVERNAME
EOF
)

        echo "$BODY" | mailx -s "$SUBJECT" -r "$YOUR_GMAIL" "$ABUSE"
        STATUS=$?
        if [ $STATUS -eq 0 ]; then
            echo "$(date '+%F %T') $TICKET_FILE $IP $ABUSE SUCCESS" >> "$LOGFILE"
        else
            echo "$(date '+%F %T') $TICKET_FILE $IP $ABUSE FAILED" >> "$LOGFILE"
        fi

        # Add the IP to fail2ban (ban in "sshd" jail)
        fail2ban-client set sshd banip "$IP"
        echo "$(date '+%F %T') $TICKET_FILE $IP added to fail2ban" >> "$LOGFILE"
    done
done

find "$TICKETS_ROOT" -type f -exec rm -f {} \;
echo "" > "$ADMIN_LIST"
cd "$USERS_DIR" || exit 2
for i in *; do
    echo "" > "$i/tickets.list"
done
