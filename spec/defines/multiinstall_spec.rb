require 'spec_helper'

describe 'multiinstall' do
    let (:title) { 'test' }

    context 'with defaults' do
        it { should compile }
        it { should contain_multiinstall('test') }
        it { should contain_file('/opt/test') }
        it { should contain_file('/opt/test/bin/test') }
    end

    context 'with a tag defined' do
        let (:params) {{
            :install_type => 'multiinstall::install::mock',
            :install_tags => '1'
        }}

        it { should compile }
        it { should contain_multiinstall__install('/opt/test/1') }
    end

    context 'with multiple tags defined' do
        let (:params) {{
            :install_type => 'multiinstall::install::mock',
            :install_tags => ['1','abc']
        }}

        it { should compile }
        it { should contain_multiinstall__install('/opt/test/1') }
        it { should contain_multiinstall__install('/opt/test/abc') }
    end

end
