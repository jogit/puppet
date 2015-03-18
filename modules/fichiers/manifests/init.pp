class fichiers {

  file { "/etc/puppet/puppet.conf":
    owner => root,
    group => root,
    mode => '0644',
    source => "puppet:///modules/fichiers/etc/puppet/puppet.conf",
  }

  #Script pour nettoyer les anciens kernels
  file { "/usr/sbin/purgekernel":
    owner => root,
    group => root,
    mode => '0755',
    ensure => present,
    source => $::is_proxmox ? {
      true => "puppet:///modules/fichiers/usr/sbin/purgekernel_proxmox",
      false => "puppet:///modules/fichiers/usr/sbin/pugekernel",
      default => "puppet:///modules/fichiers/usr/sbin/purgekernel"
    }
  }
  file { "/etc/apt/apt.conf.d/88pergekernel":
    ensure => absent,
  }
  
  file { "/etc/apt/apt.conf.d/88purgekernel":
    owner => root,
    group => root,
    mode => '0644',
    source => "puppet:///modules/fichiers/etc/apt/apt.conf.d/88purgekernel",
    ensure => present,
  }

  file { "/etc/apt/apt.conf":
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => "puppet:///modules/fichiers/etc/apt/apt.conf",
    ensure => present,
  }
 
  
  if $::osfamily == 'Ubuntu' {
    file {"/root/.bashrc":
      owner   => root,
      group   => root,
      mode    => '0644',
      source  => 'puppet:///modules/fichiers/root/bashrc.ubuntu',
    }
  }
}
