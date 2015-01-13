require 'spec_helper'

describe 'multiinstall', :type => :define do
    let (:facts) {{ :osfamily => 'RedHat' }}
    let (:title) { 'test' }
    let (:params) {
    }

    context 'with defaults' do
        it { should contain_file('/opt/test') }
        it { should contain_file('/opt/test/bin/test') }
    end
end
