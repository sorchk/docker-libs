## 使用实例
```shell
docker run -d \
--name npc_test \
--restart always \
--net host \
-e TZ="Asia/Shanghai" \
-e SERVER="ip或域名:1440" \
-e VKEY="密钥" \
sorc/npc:latest
```
## 环境变量
- `SERVER`：nps服务器地址
- `VKEY`：nps服务器密钥
- `CONFIG`: 自定义配置文件路径，默认使用`/home/npc/conf/npc.conf`