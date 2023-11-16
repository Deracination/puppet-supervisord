# Define: supervisord::group
#
# This define creates an group configuration file
#
# Documentation on parameters available at:
# http://supervisord.org/configuration.html#group-x-section-settings
#
define supervisord::group (
  $programs,
  $ensure           = present,
  $priority         = undef,
  $config_file_mode = '0644'
) {

  include supervisord

  # parameter validation

  $progstring = array2csv($programs)
  $conf = "${supervisord::config_include}/group_${name}.conf"

  file { $conf:
    ensure  => $ensure,
    owner   => 'root',
    mode    => $config_file_mode,
    content => template('supervisord/conf/group.erb'),
    notify  => Class['supervisord::reload']
  }
}
