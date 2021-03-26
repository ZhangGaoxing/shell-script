#!/bin/sh

logger -t "【校园网自动登录】" "开始上网认证"
KEYWORD=$(curl -I -s -m 6 "https://www.baidu.com" | grep 200)
if [[ "${KEYWORD}" = "" ]]; then
  logger -t "【校园网自动登录】" "开始尝试认证"
  WLAN_IP=$(ifconfig apcli0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}')
  logger -t "【校园网自动登录】" "WLAN IP ${WLAN_IP}"
  LOGIN_STATUS=$(curl -s "http://10.2.5.251:801/eportal/?c=Portal&a=login&login_method=1&user_account=账户%40cmcc&user_password=密码")   
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