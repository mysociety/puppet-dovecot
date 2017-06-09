require 'spec_helper'
describe 'dovecot' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts.merge( {
          :os => {
            'distro' => {
              'codename' => facts[:lsbdistcodename]
            }
          },
          :networking => { 'fqdn' => 'debian.build' }
        } )
      end
      context 'with defaults for all parameters' do
        it { should contain_class('dovecot') }
      end
    end
  end
end
