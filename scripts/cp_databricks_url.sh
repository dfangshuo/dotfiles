#!/bin/bash

cpurl  () {
        # echo $1
        data=$(cat)
        echo $data
        echo $data  | grep -o "https://abnormalsecurity-prod[^',]\+" | tr "\n" " " | pbcopy
        # awk '{print($139)}' | tr ',' '\n' | tr "'" " " 
}

DBFS_AIRFLOW_LOG_PATH='dbfs:/home/airflow/logs/'
