#Maintenu par JRA
filebucket { 'main': server => 'n-puppet-01.stgibm.univ-fcomte.fr' }
File { backup => 'main' }
Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin" }

import "logiciels"
import "fichiers"


node basenode {
  include logiciels
  include fichiers
  include nrpe
  class { 'nrpe':
    dont_blame_nrpe => '1',
    allowed_hosts => ['172.20.170.32', '172.20.170.12']
  }
  }






