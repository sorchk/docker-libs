## 使用实例
```shell
docker run -d \
--restart=always \
--network host \
-e TZ="Asia/Shanghai" \
-v $(pwd)/conf:/etc/nps/conf \
--name nps_test \
sorc/nps:latest
```
## 环境变量
- `RUNMOD`：运行模式，默认值为 `pro`，可选值 `dev`、`pro`
- `BRIDGE_PORT`: npc接入端口，默认值为 `1440`
- `WEB_HOST`：web管理地址或域名，默认值为 `localhost`
- `WEB_PORT`：web管理监控端口，默认值为 `1441`
- `WEB_PASSWORD`：web管理访问密码，默认值为 `随机生成，控制台查看`
- `WEB_OPEN_SSL`：web管理是否使用https，默认值为 `true`
- `LOG_LEVEL`：日志级别，默认值为 `6`. 0: emerg, 1: alert, 2: crit, 3: error, 4: warning, 5: notice, 6: info, 7: debug
- `HTTP_PROXY_PORT`: http协议反向代理端口，默认值为 `8181`
- `HTTPS_PROXY_PORT`: https协议反向代理端口，默认值为 `8443`
- `PUBLIC_VKEY`: npc公开连接key，默认值为 `随机生成，控制台查看`
- `AUTH_CRYPT_KEY`：认证秘钥，默认值为 `随机生成，控制台查看`
- `AUTH_KEY`：认证秘钥，默认值为 `随机生成，控制台查看`
所有环境变量在第一次运行时持久化到/etc/nps/conf/nps.conf文件中，后续运行时会读取该文件。

## 挂载目录
- `/etc/nps/conf`：配置文件目录，包含npc.conf、server.key、server.pem等文件