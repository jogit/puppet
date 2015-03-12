filebucket { 'main': server => 'n-puppet-01.stgibm.univ-fcomte.fr' }
File { backup => 'main' }
import "nodes"
import "logiciels"
import "fichiers"

Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin" }

#class { 'ntp':
#        server_list => [ 'chronos.iut-bm.univ-fcomte.fr' ]
#    }

class { 'nrpe':
    dont_blame_nrpe => '1',
    allowed_hosts => ['172.20.170.32', '172.20.170.12']
}

#class { 'nrpe::plugins' {
#        'check_apt':
#                ensure  => present,
#                sudo    => true,
#                command => 'check_dell_warranty';
#    }

#class { 'sudo': }

