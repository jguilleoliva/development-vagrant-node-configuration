#! /bin/bash
nohup vagrant up > output.log &
multitail output.log -C;
