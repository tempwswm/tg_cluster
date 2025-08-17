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

export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

```


## 共享镜像设置 (应该在安装k3s前就设置好)

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


## k3s 控制平面安装（这个集群没有设置高可用）

```shell
curl -sfL https://get.k3s.io | K3S_TOKEN=$SERVER_TOKEN sh -s - --embedded-registry
```



## k3s 工作节点安装

```shell
curl -sfL https://get.k3s.io | K3S_URL=https://$MASTER_IP K3S_TOKEN=$SERVER_TOKEN sh -s - agent \
  --node-label area=$NODE_AREA \
  --node-label stable=$NODE_STABLE
```



## 安装Longhorn1.9.1

```shell
apt update && apt install -y jq open-iscsi nfs-common cryptsetup
modprobe iscsi_tcp
kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.9.1/deploy/longhorn.yaml
kubectl get pods --namespace longhorn-system --watch
```



## 自动补全

```shell
source <(kubectl completion bash)
```



## 安装Kuboard

直接安装到k8s 使用 hostPath -> [参考链接](#https://kuboard.cn/install/v3/install-in-k8s.html#%E6%96%B9%E6%B3%95%E4%B8%80-%E4%BD%BF%E7%94%A8-hostpath-%E6%8F%90%E4%BE%9B%E6%8C%81%E4%B9%85%E5%8C%96)

```shell
kubectl apply -f https://addons.kuboard.cn/kuboard/kuboard-v3.yaml
```



# 镜像管理



## podman以及helm安装

```shell
apt update && apt install -y podman
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```



## 构建镜像并导入k3s

```shell
export BUILD_IMG_TAG="registry.cluster.local/<image_name>:<tag>" &&\
podman build -t $BUILD_IMG_TAG . &&\
podman save -o image.tar $BUILD_IMG_TAG &&\
k3s ctr i import image.tar &&\
rm image.tar
```

