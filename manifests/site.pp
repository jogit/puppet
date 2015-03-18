#Maintenu par JRA le 18/03/2015
filebucket { 'main': server => 'n-puppet-01.stgibm.univ-fcomte.fr' }
File { backup => 'main' }
Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin" }

import "logiciels"
#import "fichiers"


node default {
  include logiciels
  include fichiers
  #include nrpe
  class { 'nrpe':
    dont_blame_nrpe => '1',
    allowed_hosts => ['172.20.170.32', '172.20.170.12']
  }
  
  }
  nrpe::plugin { 'event_ntp':
             # source_prefix => 'puppet:///',
              source => 'nrpe/event_ntp.sh'
        }
        
  class { 'snmp':
  agentaddress => [ 'udp:161' ],
#  com2sec      => [ 'notConfigUser 10.20.30.40/32 SeCrEt' ],
  contact      => 'pole-informatique.stgi@univ-fcomte.fr',
  location     => 'UFR STGI Belfort',
   ro_community      => 'stgi 172.20.170.32',
    }

        






