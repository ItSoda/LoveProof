rm -rf ssl

mkdir ssl

cd ssl

mkdir certs
mkdir csr
mkdir keys

rm -f certs/dhparam.pem certs/server.crt csr/server.csr keys/server.key

openssl dhparam -out certs/dhparam.pem 2048

openssl req -nodes -newkey rsa:2048 -keyout keys/server.key -out csr/server.csr

openssl x509 -req -days 365 -in csr/server.csr -signkey keys/server.key -out certs/server.crt

echo "SSL-сертификаты успешно перегенерированы"