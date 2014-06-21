class profile::motd(
  $func_hr        = hiera('profile::motd::func_hr'),
  $head           = hiera('profile::motd::head'),
  $location       = hiera('profile::motd::location'),
  $product_hr     = hiera('profile::motd::product_hr'),
  $region         = hiera('profile::motd::region'),
  $show_ec2       = hiera('profile::motd::show_ec2'),
  $show_env       = hiera('profile::motd::show_env'),
  $show_func      = hiera('profile::motd::show_func'),
  $show_ip        = hiera('profile::motd::show_ip'),
  $show_product   = hiera('profile::motd::show_product'),
  $show_region    = hiera('profile::motd::show_region'),
  $show_warn      = hiera('profile::motd::show_warn'),
  $tail           = hiera('profile::motd::tail'),
  $tier           = hiera('profile::motd::tier'),
  $tier_alt_color = hiera('profile::motd::tier_alt_color'),
  $tier_color     = hiera('profile::motd::tier_color'),
  $tier_hr        = hiera('profile::motd::tier_hr')
  ){
  if $tier {
    #set the colors our tier is displayed on, based on business logic
    case $tier {
      'crp', 'rpt', 'prd': {
        $tier_color     = red
        $tier_alt_color = lred
      }
      'stg': {
        $tier_color     = yellow
        $tier_alt_color = white
      }
      'int', 'tst': {
        $tier_color     = green
        $tier_alt_color = lgreen
      }
      'dev':{
        $tier_color     = lblue
        $tier_alt_color = blue
      }
      default: {
        $tier_color     = purple
        $tier_alt_color = lpurple
      }
    }
  }
  class {'::motd':
    func_hr        => $func_hr,
    head           => $head,
    location       => $location,
    product_hr     => $product_hr,
    region         => $region,
    show_ec2       => $show_ec2,
    show_env       => $show_env,
    show_func      => $show_func,
    show_ip        => $show_ip,
    show_product   => $show_product,
    show_region    => $show_region,
    show_warn      => $show_warn,
    tail           => $tail,
    tier           => $tier,
    tier_alt_color => $tier_alt_color,
    tier_color     => $tier_color,
    tier_hr        => $tier_hr,
  }
}
