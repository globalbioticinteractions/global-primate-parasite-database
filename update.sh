#!/bin/bash
# script to programmatically download the Global Primate Parasite Database.
set -xe

DB_NAME="primates"

DB_URL="https://parasites.nunn-lab.org/$DB_NAME/download/"
curl -c cookie.txt "$DB_URL" > /dev/null
CSRF_TOKEN=$(cat cookie.txt | grep csrftoken | cut -f7)
rm cookie.txt
curl "$DB_URL" -H 'Connection: keep-alive' -H 'Cache-Control: max-age=0' -H 'Origin: https://parasites.nunn-lab.org' -H 'Upgrade-Insecure-Requests: 1' -H 'Content-Type: application/x-www-form-urlencoded' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H "Referer: $DB_URL" -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.9,it;q=0.8,nl;q=0.7' -H "Cookie: csrftoken=$CSRF_TOKEN" --data "csrfmiddlewaretoken=$CSRF_TOKEN&include_zero_prevalence=0&host_and_parasite_tax_fields=parasitereportedname__parasitereportedname&host_and_parasite_tax_fields=parasitereportedname__parasitecorrectedname&host_and_parasite_tax_fields=host_taxonomy__hostreportedname&host_and_parasite_tax_fields=host_taxonomy__hostcorrectedname&host_and_parasite_tax_fields=host_taxonomy__hostcorrectedname_msw05&location_fields=locationname__locationname&location_fields=locationname__latitudedecimal&location_fields=locationname__longitudedecimal&location_fields=locationname__resolution&prevalence_fields=totalprevalence&prevalence_fields=numberhostssampled&prevalence_fields=samplingbasis&prevalence_fields=hostsex&prevalence_fields=hostage&traits_and_transmission_fields=parasitereportedname__parasitecorrectedname__parasitetype&traits_and_transmission_fields=parasitereportedname__parasitecorrectedname__closet&traits_and_transmission_fields=parasitereportedname__parasitecorrectedname__sexual&traits_and_transmission_fields=parasitereportedname__parasitecorrectedname__vertical&traits_and_transmission_fields=parasitereportedname__parasitecorrectedname__nonclose&traits_and_transmission_fields=parasitereportedname__parasitecorrectedname__vector&traits_and_transmission_fields=parasitereportedname__parasitecorrectedname__intermediate&reference_fields=citation__citation&reference_fields=citation__pubdata" --compressed > interactions.csv

