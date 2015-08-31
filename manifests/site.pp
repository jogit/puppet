# Serveur sur PUPPET : 
#   n-backup-01
#   n-fog-02
#   n-stgibm-display
#   n-web-01
#   n-wiki-01
#   n-opsi-01
#   r-prox-01


filebucket { 'main': server => 'n-puppet-01.stgibm.univ-fcomte.fr' }
File { backup => 'main' }
Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin" }


node default {  
}

#copie des fichiers
include fichiers

#installation des logiciels de base
include apps




#Configuration de NRPE
class { 'nrpe':
  dont_blame_nrpe => '1',
  allowed_hosts => ['172.20.170.32', '172.20.170.12'],
  command_timeout => '120'
}


#Configuration de SNMP      
class { 'snmp':
  agentaddress  => [ 'udp:161' ],
  contact       => 'pole-informatique.stgi@univ-fcomte.fr',
  location      => 'UFR STGI Belfort',
  ro_community  => 'stgi',
  ro_network    => '172.20.170.32',
}

if defined(Package['srvadmin-all']) {
  class { 'snmp':  
    openmanage_enable => true
  }
}
  
#Configuration des plugins de NRPE
nrpe::plugin { 'event_ntp':
         source => 'nrpe/event_ntp.sh'
}
nrpe::plugin { 'check_puppet_agent':
         source => 'nrpe/check_puppet_agent.sh'
}


class { 'sudo': }
sudo::conf { 'nagios':
    priority => 10,
    content  => "nagios  ALL=(ALL) NOPASSWD: /usr/lib/nagios/plugins/",
}

#Configuration des serveurs NTP
class { '::ntp':
  servers => [ 'chronos.iut-bm.univ-fcomte.fr', 'ntp.univ-fcomte.fr' ],
}
 
 
#configuration de Postfix pour le relay SMTP
include postfix
class {'postfix::relay':
    sender_hostname => $::fqdn,
    masquerade_domains => 'univ-fcomte.fr',
    relayhost => 'smtp.univ-fcomte.fr',
}


#configuration specifique pour Backuppc 
node n-backup-01 {
  nrpe::plugin { 'check_backuppc':
        source => 'nrpe/check_backuppc'
  }
} 

#Service "STGI" car le upstart de ubuntu ne fonctionne pas correctement sous openvz
if $::virtual == 'openvz' {
  service { 'STGI-upstart':
      ensure => running,
      enable => true,
    }
}
  