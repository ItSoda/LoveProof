reload_nginx() {
    sudo nginx -s reload
}

nginx_conf="/etc/nginx/nginx.conf"

normal_rate_limit="150r/m"
normal_rate_limit_media="500/s"
normal_rate_limit_posts="50/s"

ddos_rate_limit="45r/m"
ddos_rate_limit_media="250r/s"
ddos_rate_limit_posts="20r/s"

ddos_threshold=3000

update_nginx_config() {
    sed -i "s/rate=.*r\/m;/rate=$1;/" $nginx_conf
    sed -i "s/rate=.*r\/s;/rate=$2;/" $nginx_conf
    sed -i "s/rate=.*r\/s;/rate=$3;/" $nginx_conf
    reload_nginx
}

check_request_rate() {
    request_count=$(tail -n 3000 /var/log/nginx/access.log | wc -l)
    if [ $request_count -gt $ddos_threshold ]; then
        echo "DDoS detected. Updating rate limits..."
        update_nginx_config $ddos_rate_limit $ddos_rate_limit_media $ddos_rate_limit_posts
    else
        echo "Normal traffic. Updating rate limits..."
        update_nginx_config $normal_rate_limit $normal_rate_limit_media $normal_rate_limit_posts
    fi
}

while true; do
    check_request_rate
    sleep 60
done
