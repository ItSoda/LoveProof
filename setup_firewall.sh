for i in `curl https://www.cloudflare.com/ips-v4`; do iptables -I INPUT -p tcp -m multiport --dports http,https -s $i -j ACCEPT; done
for i in `curl https://www.cloudflare.com/ips-v6`; do ip6tables -I INPUT -p tcp -m multiport --dports http,https -s $i -j ACCEPT; done

for i in `curl https://www.cloudflare.com/ips-v4`; do iptables -I DOCKER-USER -p tcp -m conntrack --ctorigdstport http --ctdir ORIGINAL -s $i -j ACCEPT; done

cd /etc/docker
echo '{"iptables": false}' >> daemon.json
systemctl restart docker