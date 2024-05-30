#!/bin/sh
nps_conf_dir=/etc/nps/conf
nps_conf_source=${nps_conf_dir}/nps.conf
nps_conf_bak=/etc/nps/conf_bak
nps_inited=/etc/nps/conf/inited

if [ ! -f $nps_conf_source ]; then
  echo "No nps.conf found. Using default configuration."
  cp -rnf $nps_conf_bak/* $nps_conf_dir/
  rm -f $nps_inited
fi
if [ ! -f $nps_inited ]; then
  #运行模式
  sed -i 's/runmode = dev/runmode=pro/g' $nps_conf_source
  sed -i 's/runmode=dev/runmode=pro/g' $nps_conf_source
  if [ -n "$RUNMOD" ]; then
    sed -i 's/runmode=pro/runmode='"${RUNMOD}"'/g' $nps_conf_source
  fi
  #代理http服务端口
  sed -i 's/http_proxy_port=80/http_proxy_port=8181/g' $nps_conf_source
  if [ -n "$HTTP_PROXY_PORT" ]; then
    echo http_proxy_port=${HTTP_PROXY_PORT}
    sed -i 's/http_proxy_port=8181/http_proxy_port='"${HTTP_PROXY_PORT}"'/g' $nps_conf_source
  fi
  sed -i 's/https_proxy_port=443/https_proxy_port=8443/g' $nps_conf_source
  if [ -n "$HTTPS_PROXY_PORT" ]; then
    echo https_proxy_port=${HTTPS_PROXY_PORT}
    sed -i 's/https_proxy_port=8443/https_proxy_port='"${HTTPS_PROXY_PORT}"'/g' $nps_conf_source
  fi
  #服务端口
  sed -i 's/bridge_port=8024/bridge_port=1440/g' $nps_conf_source
  if [ -n "$BRIDGE_PORT" ]; then
    echo bridge_port=${BRIDGE_PORT}
    sed -i 's/bridge_port=1440/bridge_port='"${BRIDGE_PORT}"'/g' $nps_conf_source
  fi
  #公开的连接key
  if [ -z "$PUBLIC_VKEY" ]; then
    PUBLIC_VKEY=$(head /dev/urandom | tr -dc a-z0-9 | head -c 16)
  fi
  echo public_vkey=${PUBLIC_VKEY}
  sed -i 's/public_vkey=123/public_vkey='"${PUBLIC_VKEY}"'/g' $nps_conf_source
  #web管理地址
  sed -i 's/web_host=a.o.com/web_host=localhost/g' $nps_conf_source
  if [ -n "$WEB_HOST" ]; then
    echo web_host=${WEB_HOST}
    sed -i 's/web_host=localhost/web_host='"${WEB_HOST}"'/g' $nps_conf_source
  fi
  #web管理密码
  if [ -z "$WEB_PASSWORD" ]; then
    WEB_PASSWORD=$(head /dev/urandom | tr -dc a-z0-9 | head -c 16)
  fi
  echo web_password=${WEB_PASSWORD}
  sed -i 's/web_password=123/web_password='"${WEB_PASSWORD}"'/g' $nps_conf_source
  #web管理端口
  sed -i 's/web_port = 8080/web_port=1441/g' $nps_conf_source
  sed -i 's/web_port=8080/web_port=1441/g' $nps_conf_source
  if [ -n "$WEB_PORT" ]; then
    echo web_port=${WEB_PORT}
    sed -i 's/web_port=1441/web_port='"${WEB_PORT}"'/g' $nps_conf_source
  fi
  #web管理是否使用https
  sed -i 's/web_open_ssl=false/web_open_ssl=true/g' $nps_conf_source
  if [ "$WEB_OPEN_SSL" == "false" ]; then
    echo web_open_ssl=${WEB_OPEN_SSL}
    sed -i 's/web_open_ssl=true/web_open_ssl=false/g' $nps_conf_source
  fi
  sed -i 's/log_level=7/log_level=6/g' $nps_conf_source
  if [ -n "$LOG_LEVEL" ]; then
    echo log_level=${LOG_LEVEL}
    sed -i 's/log_level=6/log_level='"${LOG_LEVEL}"'/g' $nps_conf_source
  fi
  #认证秘要
  if [ -z "$AUTH_CRYPT_KEY" ]; then
    AUTH_CRYPT_KEY=$(head /dev/urandom | tr -dc a-z0-9 | head -c 16)
  fi
  echo auth_crypt_key=${AUTH_CRYPT_KEY}
  sed -i 's/auth_crypt_key =1234567812345678/auth_crypt_key ='"${AUTH_CRYPT_KEY}"'/g' $nps_conf_source
  sed -i 's/auth_crypt_key=1234567812345678/auth_crypt_key ='"${AUTH_CRYPT_KEY}"'/g' $nps_conf_source
  #认证秘要
  if [ -z "$AUTH_KEY" ]; then
    AUTH_KEY=$(head /dev/urandom | tr -dc a-z0-9 | head -c 16)
  fi
  echo auth_key=${AUTH_KEY}
  sed -i 's/#auth_key=test/auth_key='"${AUTH_KEY}"'/g' $nps_conf_source
  echo "nps inited." >$nps_inited
fi

run_nps() {
  echo "Starting nps..."
  nps
  return 0
}

run_nps
