#!/bin/bash
source /home/Documents/GitHub/cs-491-finalproject/venv/bin/activate
pyinstaller --onefile /home/Documents/GitHub/cs-491-finalproject/source/tictactoe.py
aws s3 mv /var/jenkins_home/workspace/final-project/dist/tictactoe s3://activity11bucket
