#!/usr/bin/env rspec
require 'spec_helper'
require 'puppetlabs_spec_helper/module_spec_helper'
foo      = Puppet.settings[:modulepath]

describe 'motd',:type => :class do
  context 'on a Debian OS' do
    let (:default_facts) do {
      'memorytotal'                  => '2000 MB',
      'operatingsystem'              => 'Debian',
      'operatingsystemrelease'       => '11',
      'ipaddress'                    => '11.22.33.44',
      'network_public_ip'
      'kernelrelease'                => '42.awesome-kernel',
      'fqdn'                         => 'hostname.domainname.com',
      'hostname'                     => 'hostname',
    }end
    let(:default_params) do
      {'modulepath'  => foo }
    end
    let :params do
       default_params
    end
    let :facts do
      default_facts
    end
    it { should contain_class('motd') }
    it { should contain_file('/etc/motd') }
    it { should contain_file('/var/run/motd').with_content(/This file does not impact motd/) }
    ['show_ec2','show_env','show_func','show_product','show_region','show_warn'].each do |booltest|
      it "should report an error when #{booltest} is not a boolean" do
        params.merge!({ booltest => 'BOGON'})
        expect { subject }.to raise_error(Puppet::Error, /"BOGON" is not a boolean.  It looks to be a String/)
      end
    end
    ['head','tail'].each do |arrtest|
      it "should report an error when #{arrtest} is populated, but not an array" do
        params.merge!({ arrtest => 'BOGON'})
        pending 'not sure if we actually want to do this.' do
          expect { subject }.to raise_error(Puppet::Error, /"BOGON" is not an array.  It looks to be a String/)
        end
      end
    end
    describe 'when show_env is true' do
      let :params do
        default_params.merge({'show_env' => true})
      end
      it 'should contain the environment' do
        should contain_file('/etc/motd').with_content(/Local/)
      end
    end
    describe 'when show_ec2 is true' do
      let :params do
        default_params.merge({'show_ec2' => true})
      end
      let :facts do
        default_facts.merge({
          'ec2_ami_id' => 'ami-12345678',
          'ec2_hostname' => 'ip-11-22-33-44.us-west-1.compute.internal',
          'ec2_instance_id' => 'i-abcdefg`',
          'ec2_instance_type' => 'm1.small',
          'ec2_local_ipv4' => '11.22.33.44',
          'ec2_placement_availability_zone' => 'us-west-1a',
          'ec2_public_ipv4' => '22.33.44.55',
          'ec2_security_groups' => 'my-awesome-security-group-of-security'
        })
      end
      it { should contain_file('/etc/motd').with_content(/AMI:/) }
      it { should contain_file('/etc/motd').with_content(/EC2 Public Hostname:/) }
      it { should contain_file('/etc/motd').with_content(/EC2 Hostname:/) }
      it { should contain_file('/etc/motd').with_content(/Instance ID:/) }
      it { should contain_file('/etc/motd').with_content(/Instance Type:/) }
      it { should contain_file('/etc/motd').with_content(/Availability Zone:/) }
      it { should contain_file('/etc/motd').with_content(/Security Group:/) }
    end
    describe 'when show_func is true' do
      let :params do
        default_params.merge({'show_func' => true})
      end
      let :facts do
        default_facts
      end
      it { should contain_file('/etc/motd').with_content(/Function:/) }
    end
    describe 'when show_warn is true' do
      let :params do
        default_params.merge({'show_warn' => true})
      end
      it 'should contain the warning header' do
        should contain_file('/etc/motd').with_content(/This system is for the use of authorized users only/)
      end
    end
    describe 'when show_ip is true' do
      context 'on an amazon instance' do
        let :params do
           default_params.merge({'show_ip' => true})
        end
        let :facts do
          default_facts.merge({
            'ec2_public_ipv4' => '54.215.11.68',
            'ec2_local_ipv4' => '10.168.7.156'
          })
        end
        it 'should display the ec2 ip information' do
          should contain_file('/etc/motd').with_content(/54.215.11.68/).with_content(/10.168.7.156/)
        end
      end
      context 'without the ec2 facts present' do
        let :params do
          default_params.merge({'show_ip' => true})
        end
        let :facts do
          default_facts
        end
        it 'should display the native IP facts' do
          should contain_file('/etc/motd').with_content(/10.168.7.156/)
        end
      end
    end
    describe 'when show_product is true' do
      let :params do
        default_params.merge({'show_product' => true})
      end
      it 'should contain the product' do
        should contain_file('/etc/motd').with_content(/RetailMeNot/)
      end
    end
    describe 'when show_region is true' do
      let :params do
        default_params.merge({'show_region' => true})
      end
      it 'should contain the region' do
        should contain_file('/etc/motd').with_content(/unknownRegion/)
      end
    end
  end
  context 'on a RHEL OS' do
    let (:default_facts) do {
      'rmninc_env_humanreadable'     => 'Local',
      'rmninc_product_humanreadable' => 'RetailMeNot',
      'rmninc_func_humanreadable'    => 'Puppetmaster',
      'rmninc_loc_humanreadable'     => 'Unknown',
      'rmninc_region'                => 'unknownRegion',
      'memorytotal'                  => '2000 MB',
      'operatingsystem'              => 'CentOS',
      'operatingsystemrelease'       => '6.4',
      'ipaddress'                    => '10.168.7.156',
      'kernelrelease'                => '2.6.32-5-amd64',
      'fqdn'                         => 'vag-loc-osx-eop-pup-pet-001.rmninc.local',
    }end
    let(:default_params) do
      {'modulepath'  => foo }
    end
    let :params do
       default_params
    end
    let :facts do
      default_facts
    end
    it { should contain_class('motd') }
    it { should contain_file('/etc/motd') }
    it { should contain_file('/var/run/motd').with_content(/This file does not impact motd/) }
    ['show_ec2','show_env','show_func','show_product','show_region'].each do |booltest|
      it "should report an error when #{booltest} is not a boolean" do
        params.merge!({ booltest => 'BOGON'})
        expect { subject }.to raise_error(Puppet::Error, /"BOGON" is not a boolean.  It looks to be a String/)
      end
    end
    ['head','tail'].each do |arrtest|
      it "should report an error when #{arrtest} is populated, but not an array" do
        params.merge!({ arrtest => 'BOGON'})
        pending 'not sure if we actually want to do this.' do
          expect { subject }.to raise_error(Puppet::Error, /"BOGON" is not an array.  It looks to be a String/)
        end
      end
    end
    describe 'when show_env is true' do
      let :params do
        default_params.merge({'show_env' => true})
      end
      it 'should contain the environment' do
        should contain_file('/etc/motd').with_content(/Local/)
      end
    end
    describe 'when show_ec2 is true' do
      let :params do
        default_params.merge({'show_ec2' => true})
      end
      let :facts do
        default_facts.merge({
          'ec2_ami_id' => 'ami-0d1b3c48',
          'ec2_hostname' => 'ip-10-168-7-156.us-west-1.compute.internal',
          'ec2_instance_id' => 'i-203d587b',
          'ec2_instance_type' => 'm1.small',
          'ec2_local_ipv4' => '10.168.7.156',
          'ec2_placement_availability_zone' => 'us-west-1a',
          'ec2_public_ipv4' => '54.215.11.68',
          'ec2_security_groups' => 'ec2-int-sw1-eop-pup-pet'
        })
      end
      it { should contain_file('/etc/motd').with_content(/AMI:/) }
      it { should contain_file('/etc/motd').with_content(/EC2 Hostname:/) }
      it { should contain_file('/etc/motd').with_content(/EC2 Public Hostname:/) }
      it { should contain_file('/etc/motd').with_content(/Instance ID:/) }
      it { should contain_file('/etc/motd').with_content(/Instance Type:/) }
      it { should contain_file('/etc/motd').with_content(/Availability Zone:/) }
      it { should contain_file('/etc/motd').with_content(/Security Group:/) }
    end
    describe 'when show_func is true' do
      let :params do
        default_params.merge({'show_func' => true})
      end
      let :facts do
        default_facts
      end
      it { should contain_file('/etc/motd').with_content(/Function:/) }
    end
    describe 'when show_ip is true' do
      context 'on an amazon instance' do
        let :params do
           default_params.merge({'show_ip' => true})
        end
        let :facts do
          default_facts.merge({
            'ec2_public_ipv4' => '54.215.11.68',
            'ec2_local_ipv4' => '10.168.7.156'
          })
        end
        it 'should display the ec2 ip information' do
          should contain_file('/etc/motd').with_content(/54.215.11.68/).with_content(/10.168.7.156/)
        end
      end
      context 'without the ec2 facts present' do
        let :params do
          default_params.merge({'show_ip' => true})
        end
        let :facts do
          default_facts
        end
        it 'should display the native IP facts' do
          should contain_file('/etc/motd').with_content(/10.168.7.156/)
        end
      end
    end
    describe 'when show_product is true' do
      let :params do
        default_params.merge({'show_product' => true})
      end
      it 'should contain the warning header' do
        should contain_file('/etc/motd').with_content(/RetailMeNot/)
      end
    end
    describe 'when show_region is true' do
      let :params do
        default_params.merge({'show_region' => true})
      end
      it 'should contain the region' do
        should contain_file('/etc/motd').with_content(/unknownRegion/)
      end
    end
    describe 'when show_warn is true' do
      let :params do
        default_params.merge({'show_warn' => true})
      end
      it 'should contain the warning header' do
        should contain_file('/etc/motd').with_content(/This system is for the use of authorized users only/)
      end
    end
  end
end
