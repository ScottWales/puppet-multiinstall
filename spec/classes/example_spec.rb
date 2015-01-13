require 'spec_helper'

describe 'multitaginstall' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "multitaginstall class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('multitaginstall::params') }
        it { should contain_class('multitaginstall::install').that_comes_before('multitaginstall::config') }
        it { should contain_class('multitaginstall::config') }
        it { should contain_class('multitaginstall::service').that_subscribes_to('multitaginstall::config') }

        it { should contain_service('multitaginstall') }
        it { should contain_package('multitaginstall').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'multitaginstall class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('multitaginstall') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
