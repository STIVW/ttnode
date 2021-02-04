# 甜糖（ttnode）星愿自动收取/Docker快速部署

此容器中脚本使用的是：SHELL脚本参考了yjce1314大神的[代码](https://www.right.com.cn/forum/thread-4065542-1-1.html)

# 1.容器部署


```
docker run -itd \
  --name ttcollect\
  --restart=always \
  stivw/ttnode
```


## 2.进入容器：

```
docker exec -it ttcollect bash 
```

## 3.配置脚本：

```
/usr/node/ttnode_task.sh login
```

## 修改运行时间：

```
crontab -e
```

```
8   3 * * *  /usr/node/ttnode_task.sh report  #每天三点八分运行-自行修改
↑   ↑
分  时
```
#### 如果觉得还有点用，麻烦用一下我的邀请码086567，有加成卡15张，我也有推广收入

