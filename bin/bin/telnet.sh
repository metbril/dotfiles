#!/usr/bin/expect
set timeout 20
set hostName [lindex $argv 0]
set userName [lindex $argv 1]
set password [lindex $argv 2]

spawn telnet $hostName

expect "Connected to router.asus.com."
expect "Escape character is '^]'."

#expect "User Access Verification"
expect "RT-AC68U login: "
#expect "Username:"
send "$userName\r"
expect "Password:"
send "$password\r"
send "cat /sys/class/net/eth0/statistics/rx_bytes\r"
send "exit\r"
interact
