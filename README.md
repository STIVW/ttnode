# 甜糖（ttnode）星愿自动收取/Docker快速部署

此容器中脚本使用的是：[744287383/AutomationTTnode](https://github.com/744287383/AutomationTTnode)
脚本使用方法参考此库
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
python3 /AutomationTTnode/ttnodeConfig.py
```

## 修改运行时间：

```
crontab -e
```

```
3   2 * * * python3 /AutomationTTnode/sendTTnodeMSG.py   #每天两点三分运行自行修改
↑   ↑
分  时
```
#### 如果觉得还有点用，麻烦用一下我的邀请码086567，有加成卡15张，我也有推广收入

