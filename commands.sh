yes | apt-get update
export DEBIAN_FRONTEND=noninteractive

ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
apt-get install -y tzdata
dpkg-reconfigure --frontend noninteractive tzdata
yes | apt-get install easy-rsa
ln -s /usr/share/easy-rsa/* ~/easy_rsa/
cd ~/easy_rsa
./easyrsa init-pki
cd ~/easy_rsa
yes | ./easyrsa build-ca nopass
mkdir ~/Final-csr
cd ~/Final-csr
openssl genrsa -out tls.key
apt install default-jre
apt install openssl
openssl req -new -key tls.key -out tls.req -subj \
/C=IN/ST=Karnataka/L=Benagaluru\ City/O=Besant/OU=Institute/CN=tls
openssl req -in tls.req -noout -subject
cp tls.req /tmp/
cd ~/easy_rsa
./easyrsa import-req /tmp/tls.req tls
yes yes | ./easyrsa sign-req server tls
cp ~/easy_rsa/pki/issued/tls.crt ~/Final-csr
cd ~/Final-csr
openssl pkcs12 -export -inkey tls.key -in tls.crt -out keystore.pkcs12 -password pass:password && keytool -importkeystore -noprompt -srckeystore keystore.pkcs12 -srcstoretype pkcs12 -destkeystore keystore.jks -storepass password -srcstorepass password
