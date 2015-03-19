#Maintenu par JRA le 18/03/2015
filebucket { 'main': server => 'n-puppet-01.stgibm.univ-fcomte.fr' }
File { backup => 'main' }
Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin" }

#a transformer en module
#import "logiciels"



node default {
  #installation des logiciels de base
  include logiciels
  
  #copie des fichiers
  include fichiers


  #Configuration de NRPE
  class { 'nrpe':
    dont_blame_nrpe => '1',
    allowed_hosts => ['172.20.170.32', '172.20.170.12'],
    command_prefix => '/usr/bin/sudo',
  }

  #Configuration de SNMP      
  class { 'snmp':
    agentaddress  => [ 'udp:161' ],
    contact       => 'pole-informatique.stgi@univ-fcomte.fr',
    location      => 'UFR STGI Belfort',
    ro_community  => 'stgi',
    ro_network    => '172.20.170.32',
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



}
  
