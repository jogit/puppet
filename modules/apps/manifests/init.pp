#class pour les softs a installer automatiquement
class apps {
        package { "htop": ensure => latest }
        package { "iperf": ensure => latest}
        package { "nmap": ensure => latest }
        package { "wget": ensure => latest }
        package { "ngrep": ensure => latest }
        package { "vim": ensure => latest }
        package { "ncdu": ensure => latest }
        package { "ipcalc": ensure => latest }
        #package { "unattended-upgrades": ensure => latest }
        package { "sipcalc": ensure => latest }
        #package { "rsyslog": ensure => latest }

# Les softs que l'on ne veut pas
        package { "pppoe": ensure => purged }
        package { "ppp": ensure => purged }
        package { "pppconfig": ensure => purged }
        package { "pppoeconfig": ensure => purged }

}
