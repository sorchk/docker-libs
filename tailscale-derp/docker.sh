docker rm -f tailscale-derp
docker run -d \
 --name tailscale-derp \
 -e HOSTNAME=tsd.sction.org \
 -v /datadisk/sslcert/privkey.pem:/var/lib/derper/derper.key \
 -v /datadisk/sslcert/fullchain.pem:/var/lib/derper/derper.crt \
 -p 30303:30303 \
 -p 3478:3478/udp \
 --restart=always \
 sorc/tailscale-derp


docker rm -f tailscale-derp

docker run -d \
 --name tailscale-derp \
 -e HOSTNAME=tsd.sction.org \
 -v /datadisk/sslcert/privkey.pem:/certdir/tsd.sction.org.key \
 -v /datadisk/sslcert/fullchain.pem:/certdir/tsd.sction.org.crt \
 -p 30303:443 \
 -p 3478:3478/udp \
 --restart=always \
 sorc/tailscale-derp \
  /bin/sh -c './derper -hostname ${HOSTNAME}  -a :443 -stun-port 3478 -certmode manual -certdir /certdir -home blank --verify-clients'
