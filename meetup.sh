#!/bin/zsh

#add in your meetup.com API key here
local key
key=

#add in your event ID here
local event
event=

local json
json=$(curl -f -s -S -k https://api.meetup.com/2/rsvps\?\&key\=$key\&photo-host\=public\&rsvp\=yes\&event_id\=$event\&fields\=member&page=1)

local rsvps
rsvps=$(echo $json | jq -r '.results[].member.name')

local names
names=$(echo $rsvps | awk 'BEGIN { OFS = " "; ORS="\n"} { if ($2 == "") print $1, "Guest"; else print $1, $2}')

print $names