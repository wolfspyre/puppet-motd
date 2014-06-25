#Class: motd
#  This class manages motd and displays relevant information derived from
#  local facts and hiera variables
#
#The following hiera keys are referenced
# motd::backup:         false
# motd::show_ec2:       true
# motd::show_maturity:       true
# motd::show_func:      true
# motd::show_ip:        true
# motd::show_product:   true
# motd::show_region:    true
# motd::show_warn:      true
# motd::func_hr:        'Human Readable Function'
# motd::head:
#  - 'this would be the first line'
#  - 'this would be the next line'
# motd::location:       'Some Location'
# motd::product_hr      'Human Readable Productname'
# motd::region:         'aus'
# motd::tail:           false
# motd::maturity:           'prd'
# motd::maturity_alt_color: 'lred'
# motd::maturity_color:     'red'
# motd::maturity_hr:        'Production'
#
#
class motd(
  $backup             = false,
  $func_hr            = 'Human Readable Function',
  $head               = false,
  $location           = 'Some Location',
  $maturity           = 'prd',
  $maturity_alt_color = 'lred',
  $maturity_color     = 'red',
  $maturity_hr        = 'Production',
  $modulepath         = $settings::modulepath,
  $product_hr         = 'Human Readable Productname',
  $region             = 'aus',
  $show_ec2           = true,
  $show_func          = true,
  $show_ip            = true,
  $show_maturity      = true,
  $show_product       = true,
  $show_region        = true,
  $show_warn          = true,
  $tail               = false,
) {
  validate_bool($backup)
  validate_bool($show_ec2)
  validate_bool($show_maturity)
  validate_bool($show_func)
  validate_bool($show_ip)
  validate_bool($show_product)
  validate_bool($show_region)
  validate_bool($show_warn)

  validate_string($func_hr)
  validate_string($location)
  validate_string($product_hr)
  validate_string($region)
  validate_string($maturity)
  validate_string($maturity_alt_color)
  validate_string($maturity_color)
  validate_string($maturity_hr)
  file{'/etc/motd':
    ensure   => 'file',
    backup   => $backup,
    content  => template('motd/motd.erb'),
    group    => 'root',
    mode     => '0644',
    owner    => 'root',
  }
  file{'/var/run/motd':
    ensure  => 'file',
    backup   => $backup,
    content => 'This file does not impact motd. Motd is read from /etc/motd',
    group   => 'root',
    mode    => '0644',
    owner   => 'root',
  }
}
