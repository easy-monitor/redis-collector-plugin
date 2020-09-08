## 工作原理

1. redis-collector-plugin 监控插件包使用了第三方的 Redis Exporter 进行指标采集，GitHub 链接为 https://github.com/oliver006/redis_exporter。

## 准备工作

1. 确认要采集的 Redis 具体的 IP、端口和认证密码。

## 使用方法

### 导入监控插件包

1. 下载该项目的压缩包（https://github.com/easy-monitor/redis-collector-plugin/archive/master.zip ）。

2. 建议解压到 EasyOps 平台服务器上的 `/usr/local/easyops/monitor_plugin_packages` 该目录下。

3. 使用 EasyOps 平台内置的监控插件包导入工具进行导入，具体命令如下，请替换其中的 `8888` 为当前 EasyOps 平台具体的 `org`。

```sh
$ cd /usr/local/easyops/collector_plugin_service/tools
$ sh plugin_op.sh install 8888 /usr/local/easyops/monitor_plugin_packages/redis-collector-plugin
```

4. 导入成功后访问 EasyOps 平台的「采集插件」小产品页面 (http://your-easyops-server/next/collector-plugin )，就能看到导入的 "redis-collector-plugin" 采集插件。

### 启动 Redis Exporter

1. 启动 Redis Exporter，具体命令如下，请替换其中的 `--redis-host`、`--redis-port` 参数为采集的 Redis 的监听地址和端口。

```sh
$ cd /usr/local/easyops/monitor_plugin_packages/redis-collector-plugin/script
$ sh deploy/start_script.sh --redis-host 127.0.0.1 --redis-port 6379
```

2. 通过访问 http://127.0.0.1:9121/metrics 来获取指标数据，请替换其中的 `127.0.0.1:9121` 为 Exporter 具体的监听地址和端口。

```sh
$ curl http://127.0.0.1:9121/metrics 
```

3. 接下来可使用导入的采集插件为具体的资源实例创建采集任务。

## 启动参数

| 名称 | 类型 | 必填 | 默认值 | 说明 |
| --- | --- | --- | --- | --- |
| redis-host | string | false | 127.0.0.1 | Redis 监听地址 |
| redis-port | int | false | 6379 | Redis 监听端口 |
| redis-password | string | false |  | Redis 认证密码 |
| exporter-host | string | false | 127.0.0.1 | Exporter 监听地址 |
| exporter-port | int | false | 9116 | Exporter 监听端口 |
| exporter-uri | string | false | /metrics | Exporter 获取指标数据的 URI |
