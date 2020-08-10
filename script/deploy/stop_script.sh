#!/bin/bash

ps -ef | grep redis_exporter | awk '{print $2}' | xargs kill -9
