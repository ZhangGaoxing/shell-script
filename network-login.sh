#!/bin/sh

logger -t "【校园网自动登录】" "开始上网认证"
KEYWORD=$(curl -I -s -m 6 "https://www.baidu.com" | grep 200)
if [[ "${KEYWORD}" = "" ]]; then
  logger -t "【校园网自动登录】" "开始尝试认证"
  LOGIN_STATUS=$(curl -s "http://10.2.5.251:801/eportal/?c=Portal&a=login&callback=dr1616574132648&login_method=1&user_account=账户%40cmcc&user_password=密码&wlan_user_ip=10.3.3.220&wlan_user_mac=000000000000&wlan_ac_ip=&wlan_ac_name=&jsVersion=3.0&_=1616574120266")   
  SUCCESS=$(echo ${LOGIN_STATUS} | grep \"result\":\"0\")
  if [[ "${SUCCESS}" = "" ]]; then
      logger -t "【校园网自动登录】" "成功连接至外网"
  else
    LOGIN_STATUS=$(echo ${LOGIN_STATUS})
    logger -t "【校园网自动登录】" "错误原因: ${LOGIN_STATUS}"
  fi
else
  logger -t "【校园网自动登录】" "检测到已经认证"
fi
