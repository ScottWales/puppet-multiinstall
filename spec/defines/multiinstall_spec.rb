require 'spec_helper'

describe 'multiinstall', :type => :define do
    let (:facts) {{ :osfamily => 'RedHat' }}
    let (:title) { 'test' }
    let (:params) {
    }

    it 'should resolve with no errors' do
    end
end
