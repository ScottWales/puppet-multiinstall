require 'spec_helper'

describe 'multiinstall' do
    let (:title) { 'test' }

    context 'with defaults' do
        it { should compile }
        it { should contain_multiinstall('test') }
        it { should contain_file('/opt/test') }
        it { should contain_file('/opt/test/bin/test') }
    end
end
