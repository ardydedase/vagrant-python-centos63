#!/bin/bash

export PATH=$PATH:/bin:/usr/bin

./configure --prefix=/usr/local
make && sudo make altinstall