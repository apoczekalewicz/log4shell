#!/bin/bash
APP=$1 # 127.0.0.1:8080
curl -H "X-Api-Version: Test" $APP
