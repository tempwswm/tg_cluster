# 概述

使用 [k3s](https://k3s.io) 构建集群

使用 [Longhorn](https://longhorn.io) 构建分布存储卷

使用 [Kuboard](https://kuboard.cn/) 进行集群管理

使用 [ray](https://docs.ray.io/en/latest/cluster/kubernetes/index.html) 在k3s集群中并行python代码

使用 [novnc](https://novnc.com/info.html) 在需要时挂载tg官方客户端进行操作

使用 [podman](https://podman.io/) 构建导出镜像

使用 [embedded registry mirror](https://docs.k3s.io/installation/registry-mirror)在节点之间共享镜像

# 安装
## 机要信息供后面使用
```shell
export SERVER_TOKEN =""
export NODE_AREA = ""
export NODE_STABLE = "year"
export MASTER_IP = ""
export GHCR_TOKEN = ""
```
## k3s 控制平面安装
```shell
curl -sfL https://get.k3s.io | K3S_TOKEN=$SERVER_TOKEN sh -s - --embedded-registry
```

## k3s 工作节点

```shell
curl -sfL https://get.k3s.io | K3S_URL=https://$MASTER_IP sh -s - agent --token SERVER_TOKEN \
  --node-label area=$NODE_AREA \
  --node-label stable=$NODE_STABLE
```

## 共享镜像设置
```shell
mkdir -p /etc/rancher/k3s
cat > /etc/rancher/k3s/registries.yaml << EOF
mirrors: #常用镜像库，这里使用通配符更好，但我没有这样做
  docker.io:
  registry.k8s.io:
  gcr.io:
  quay.io:
  ghcr.io:
  registry.cluster.local: #一个虚构的仓库，自己构建的镜像都会放在这下面，参考-> https://docs.k3s.io/installation/registry-mirror#:~:text=Note%20that%20the%20upstream%20registry%20that%20the%20images%20appear%20to%20come%20from%20does%20not%20actually%20have%20to%20exist%20or%20be%20reachable.
EOF
```
