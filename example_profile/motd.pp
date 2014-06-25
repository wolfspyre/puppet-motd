class profile::motd(
  $func_hr            = hiera('profile::motd::func_hr'),
  $head               = hiera('profile::motd::head'),
  $location           = hiera('profile::motd::location'),
  $maturity           = hiera('profile::motd::maturity'),
  $maturity_alt_color = hiera('profile::motd::maturity_alt_color'),
  $maturity_color     = hiera('profile::motd::maturity_color'),
  $maturity_hr        = hiera('profile::motd::maturity_hr')
  $product_hr         = hiera('profile::motd::product_hr'),
  $region             = hiera('profile::motd::region'),
  $show_ec2           = hiera('profile::motd::show_ec2'),
  $show_env           = hiera('profile::motd::show_env'),
  $show_func          = hiera('profile::motd::show_func'),
  $show_ip            = hiera('profile::motd::show_ip'),
  $show_product       = hiera('profile::motd::show_product'),
  $show_region        = hiera('profile::motd::show_region'),
  $show_warn          = hiera('profile::motd::show_warn'),
  $tail               = hiera('profile::motd::tail'),
  ){
  if $maturity {
    #set the colors our maturity is displayed on, based on business logic
    case $maturity {
      'crp', 'rpt', 'prd': {
        $maturity_color     = red
        $maturity_alt_color = lred
      }
      'stg': {
        $maturity_color     = yellow
        $maturity_alt_color = white
      }
      'int', 'tst': {
        $maturity_color     = green
        $maturity_alt_color = lgreen
      }
      'dev':{
        $maturity_color     = lblue
        $maturity_alt_color = blue
      }
      default: {
        $maturity_color     = purple
        $maturity_alt_color = lpurple
      }
    }
  }
  class {'::motd':
    func_hr            => $func_hr,
    head               => $head,
    location           => $location,
    maturity           => $maturity,
    maturity_alt_color => $maturity_alt_color,
    maturity_color     => $maturity_color,
    maturity_hr        => $maturity_hr,
    product_hr         => $product_hr,
    region             => $region,
    show_ec2           => $show_ec2,
    show_env           => $show_env,
    show_func          => $show_func,
    show_ip            => $show_ip,
    show_product       => $show_product,
    show_region        => $show_region,
    show_warn          => $show_warn,
    tail               => $tail,
  }
}
