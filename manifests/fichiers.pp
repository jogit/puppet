#class pour les fichiers a copier sur les serveurs
class fichiers {
        #Configuration des clients puppet
#        file { "/etc/puppet/puppet.conf":
#                owner => root,
#                group => root,
#                mode => 0644,
#                source => "puppet:///files/etc/puppet/puppet.conf",
#        }

        #Script pour nettoyer les anciens kernels
        file { "/usr/sbin/purgekernel":
                owner => root,
                group => root,
                mode => 0755,
                ensure => present,
                source => $is_proxmox ? {
                        "true" => "puppet:///files/usr/sbin/purgekernel_proxmox",
                        "false" => "puppet:///files/usr/sbin/purgekernel",
                }
        }
       file { "/etc/apt/apt.conf.d/88pergekernel":
               ensure => absent,
       }
        file { "/etc/apt/apt.conf.d/88purgekernel":
                owner => root,
                group => root,
                mode => 644,
                source => "puppet:///files/etc/apt/apt.conf.d/88purgekernel",
                ensure => present,
        }



        file { "/etc/apt/apt.conf":
                owner   => root,
                group   => root,
                mode    => 644,
                source  => "puppet:///files/etc/apt/apt.conf",
                ensure => present,
        }
}
