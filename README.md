Camus
=====

#### 使用说明

1. 将 ip-up.d/99-myroute.sh 拷贝到系统 /etc/ppp/ip-up.d/99-myroute.sh
2. 将 ip-down.d/99-myroute.sh 拷贝到系统 /etc/ppp/ip-down.d/99-myroute.sh

#### 其它说明

1. /etc/ppp/ip-pre-up 脚本是在 PPTP 链路激活之前被执行, 并且根据 pppd 手册的原话:

   > Pppd will wait for this script to finish before bringing the interface up, so this script should run quickly.
   
   然而我们要添加的路由信息是比较多的, 经我测试, 完全添加完这些路由信息需要大约 3 ~ 5 秒左右. 所以这么多的路由信息实际上不适合放在 /etc/ppp/ip-pre-up 脚本中加载, 再次依据 pppd 手册的原话:
   
   > At this point the interface exists and has IP addresses assigned but is still down.  This can  be  used to add firewall rules before any IP traffic can pass through the interface.
   
   所以这个脚本更适合用来添加防火墙规则, 不适合执行太耗时的任务.

2. 因此, 路由信息实际上更适合放在 /etc/ppp/ip-up, 或者 /etc/ppp/ip-up.d/ 目录下脚本中.
