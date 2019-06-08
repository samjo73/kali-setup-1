alias htb='cd ~/htb && openvpn *.ovpn'
alias fingerprinter='/opt/Fingerprinter/fingerprinter.rb'

nmap-initial() {
    # Does a basic NMAP scan on a given target and saves the output in the PWD
    nmap -sC -sV -oN $1-initial $1
}

nmap-full() {
    # Does a full port scan on a given target and saves the output in the PWD
    nmap -p- -sC -sV -oN $1-full $1
}
